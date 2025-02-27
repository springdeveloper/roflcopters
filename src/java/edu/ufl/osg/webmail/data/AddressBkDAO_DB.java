/*
 * This file is part of GatorMail, a servlet based webmail.
 * Copyright (C) 2003-2004 The Open Systems Group / University of Florida
 *
 * GatorMail is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * GatorMail is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GatorMail; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package edu.ufl.osg.webmail.data;

import org.apache.log4j.Logger;

import javax.mail.MessagingException;
import edu.ufl.osg.webmail.data.AddressBkEntry;
import javax.mail.internet.MimeUtility;
import javax.mail.internet.AddressException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

/**
 * Implementation for interacting with the address book store.
 *
 * @author drakee
 * @version $Revision: 1.5 $
 */
public class AddressBkDAO_DB implements AddressBkDAO {
    private static final Logger logger = Logger.getLogger(AddressBkDAO_DB.class.getName());
    // use DataSource for DB connections? If not, defaults to DriverManager
    private boolean useDataSource;
    // connect with DriverManager using name + password?
    // determined by presence or absence of these values in config properties
    private boolean useDMCredentials = true;
    private String dbUser;
    private String dbCredentials;
    // used only by DataSource connection method
    private DataSource dataSource;
    // used only by DriverManager DB connection
    private String jdbcUrl;

    protected AddressBkDAO_DB() throws AddressBkDAOException {
        final ConfigDAO configDAO;
        try {
            configDAO = DAOFactory.getInstance().getConfigDAO();
            useDataSource = Boolean.valueOf(configDAO.getProperty("useDataSource")).booleanValue();
            logger.debug("useDataSource set to " + useDataSource);
            if (useDataSource) { // using DataSource
                final String dsjn = configDAO.getProperty("dataSourceJndiName");
                final Context ctx = new InitialContext();
                logger.debug("dataSourceJndiName: " + dsjn);
                dataSource = (DataSource)ctx.lookup(dsjn);
            } else { // using DriverManager
                final String dbDriverClassName = configDAO.getProperty("dbDriverClassName");
                Class.forName(dbDriverClassName).newInstance();
                jdbcUrl = configDAO.getProperty("jdbcUrl");
            }
        } catch (Exception e) {
            throw new AddressBkDAOException(e.toString());
        }
        dbUser = configDAO.getProperty("dbUser");
        dbCredentials = configDAO.getProperty("dbCredentials");
        if ("true".equals(configDAO.getProperty("passwordsBase64Encoded")) && dbCredentials != null) {
            try {
                final InputStream in = MimeUtility.decode(new ByteArrayInputStream(dbCredentials.getBytes("US-ASCII")), "base64");
                final BufferedReader br = new BufferedReader(new InputStreamReader(in));
                // XXX This assumes there is no new line in the password.
                dbCredentials = br.readLine();
                br.close();
            } catch (MessagingException e) {
                final AddressBkDAOException ae = new AddressBkDAOException("MessagingException: " + e.getMessage());
                ae.initCause(e);
                throw ae;

            } catch (UnsupportedEncodingException e) {
                final AddressBkDAOException ae = new AddressBkDAOException("UnsupportedEncodingException: " + e.getMessage());
                ae.initCause(e);
                throw ae;

            } catch (IOException e) {
                final AddressBkDAOException ae = new AddressBkDAOException("IOException: " + e.getMessage());
                ae.initCause(e);
                throw ae;
            }
        }
        if (dbUser == null || dbCredentials == null || dbUser.trim().equals("") || dbCredentials.trim().equals(""))
            useDMCredentials = false;
    }

    private Connection getConnection() throws SQLException {
        if (useDataSource) {
            //return dataSource.getConnection(dbUser, dbCredentials);
            return dataSource.getConnection();
        } else {
            if (useDMCredentials) {
                return DriverManager.getConnection(jdbcUrl, dbUser, dbCredentials);
            } else {
                return DriverManager.getConnection(jdbcUrl);
            }
        }
    }

    public AddressList getAddressList(final String permId) throws AddressBkDAOException {
        Connection con = null;
        final Collection coll = new ArrayList();
        try {
            con = getConnection();
            PreparedStatement ps = null;
			
            try {
				//Fetch only the address book entry name and primary email for the Address Book managmenet window. From there, the user can view/modify/delete the entry. -r0b
                ps = con.prepareStatement("SELECT abkPerson.name, abkEmail.email, abkPerson.company, abkPerson.position, abkPerson.phoneHome, abkPerson.phoneWork, abkPerson.phoneCell, abkPerson.address,abkPerson.notes FROM abkPerson, abkEmail WHERE abkPerson.userId = ? AND abkEmail.contactId = abkPerson.contactId");
                ps.setString(1, permId); 
				
                final ResultSet rs = ps.executeQuery();
				
                while (rs.next()) {
                    try {
                        coll.add(new AddressBkEntry(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9)));
                    } catch (Exception e) {
                        e.printStackTrace();  //To change body of catch statement use Options | File Templates.
                    }
                }
            } finally {
                if (ps != null) {
                    ps.close();
                }
            }
            con.close();
        } catch (SQLException e) {
            logger.error("Problem in getAddressList", e);
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                logger.error(se.getMessage(), se);
            }
            throw new AddressBkDAOException(e.getMessage());
        }
        final AddressList lst = new AddressList(permId);
        lst.addAll(coll);
        return lst;
    }

    public void addEntry(final String permId, final AddressBkEntry entry) throws AddressBkDAOException {
        Connection con = null;
        try {
            con = getConnection();
            PreparedStatement ps = null;
            try {
				
                ps = con.prepareStatement("INSERT INTO abkPerson " + "(userId, name,company,position,phoneHome,phoneWork,phoneCell,address,notes) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, permId);
                ps.setString(2, entry.getPersonal() );
				ps.setString(3, entry.getCompany() );
				ps.setString(4, entry.getPosition() );
				ps.setString(5, entry.getPhoneHome() );
				ps.setString(6, entry.getPhoneWork() );
			    ps.setString(7, entry.getPhoneCell() );
				ps.setString(8, entry.getMailingAddress() );
				ps.setString(9, entry.getNotes() );
				
                int count = ps.executeUpdate();
                
				if (count == 0) {
                    throw new AddressBkDAOException("Address book insert failed for entry: " + entry.toString());
                }
				
				ResultSet keys = ps.getGeneratedKeys();
			
				int key = -1;
				
				while(keys.next())
					key = keys.getInt(1);
					
				if(key <= 0)
					throw new AddressBkDAOException("Error retrieving index from abkPerson entry!");
					
				ps = con.prepareStatement("INSERT INTO abkEmail(userId, contactId, email) VALUES (?, ?, ?)");
                ps.setString(1, permId);
				ps.setString(2, (new Integer(key)).toString() );
                ps.setString(3, entry.getAddress());
				
				count = ps.executeUpdate();
                
				if (count == 0) {
                    throw new AddressBkDAOException("Address book insert failed for entry: " + entry.toString());
                }

            } finally {
                if (ps != null) {
                    ps.close();
                }
            }
            con.close();
        } catch (Exception e) {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                logger.error(se.getMessage(), se);
            }
            throw new AddressBkDAOException(e.getMessage());
        }
    }
    
    public void editEntry(final String permId, final String oldEmail, final AddressBkEntry entry) throws AddressBkDAOException {
        Connection con = null;
        try {
            con = getConnection();
            PreparedStatement ps = null;
            try {
                ps = con.prepareStatement("UPDATE abkPerson SET name=?, company=?, position=?, phoneHome=?, phoneWork=?, phoneCell=?, address=?, notes=? WHERE contactId=(SELECT contactId FROM abkEmail WHERE userId=? AND email=? LIMIT 1)");
                ps.setString(1, entry.getPersonal() );
				ps.setString(2, entry.getCompany() );
				ps.setString(3, entry.getPosition() );
				ps.setString(4, entry.getPhoneHome() );
				ps.setString(5, entry.getPhoneWork() );
			    ps.setString(6, entry.getPhoneCell() );
				ps.setString(7, entry.getMailingAddress() );
				ps.setString(8, entry.getNotes() );
				ps.setString(9, permId);
				ps.setString(10, oldEmail);
                int count = ps.executeUpdate();
                
				if (count == 0) {
                    throw new AddressBkDAOException("Address book edit failed for entry: " + entry.toString());
                }
					
				ps = con.prepareStatement("UPDATE abkEmail set email=? WHERE userId=? AND email=?");
				ps.setString(1, entry.getAddress());
                ps.setString(2, permId);
				ps.setString(3, oldEmail);
				
				count = ps.executeUpdate();
			
				if (count == 0) {
                    throw new AddressBkDAOException("Address book edit failed for entry: " + entry.toString());
                }

            } finally {
                if (ps != null) {
                    ps.close();
                }
            }
            //con.close();
        } catch (Exception e) {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                logger.error(se.getMessage(), se);
            }
            throw new AddressBkDAOException(e.getMessage());
        }
    }

    public void removeEntry(final String permId, final AddressBkEntry entry) throws AddressBkDAOException {
        Connection con = null;
        try {
            con = getConnection();
            PreparedStatement ps = null;
            try {
                ps = con.prepareStatement("DELETE FROM abkPerson WHERE userId=? AND contactId = (SELECT contactId FROM abkEmail WHERE userId=? AND email = ? LIMIT 1)");
                ps.setString(1, permId);
                ps.setString(2, permId);
                ps.setString(3, entry.getAddress());

                int count = ps.executeUpdate();
                if (count == 0) {
                    logger.error("address book delete failed. permId: " + permId + ", entry: " + entry.toString());
                    throw new AddressBkDAOException("Address book delete failed for entry: " + entry.toString());
                }
                
                // delete email entries where email and session id matches
                ps = con.prepareStatement("DELETE FROM abkEmail WHERE userId=? AND email=?");
                ps.setString(1, permId);
                ps.setString(2, entry.getAddress());

                count = 0;
                count = ps.executeUpdate();
                if (count == 0) {
                    logger.error("address book delete failed. permId: " + permId + ", entry: " + entry.toString());
                    throw new AddressBkDAOException("Address book delete failed for entry: " + entry.toString());
                }
            } finally {
                if (ps != null) {
                    ps.close();
                }
            }
            con.close();
        } catch (Exception e) {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                logger.error(se.getMessage(), se);
            }
            throw new AddressBkDAOException(e.getMessage());
        }
    }
}
