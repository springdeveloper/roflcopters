/*
 * This file is part of GatorMail, a servlet based webmail.
 * Copyright (C) 2002, 2003 William A. McArthur, Jr.
 * Copyright (C) 2003 The Open Systems Group / University of Florida
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

import edu.ufl.osg.webmail.User;
import org.apache.log4j.Logger;
import javax.naming.*;
import javax.sql.DataSource;
import java.sql.*;
import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

/**
 * Interface for obtaining and setting user information.
 *
 * @author drakee
 * @version $Revision: 1.2 $
 */
public class UserInfoDAO_DB implements UserInfoDAO {
    private static final Logger logger = Logger.getLogger(UserInfoDAO_DB.class.getName());
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
    
    private String[] allInfoArray;

    protected UserInfoDAO_DB() throws UserInfoDAOException {
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
            throw new UserInfoDAOException(e.toString());
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
                final UserInfoDAOException ae = new UserInfoDAOException("MessagingException: " + e.getMessage());
                ae.initCause(e);
                throw ae;

            } catch (UnsupportedEncodingException e) {
                final UserInfoDAOException ae = new UserInfoDAOException("UnsupportedEncodingException: " + e.getMessage());
                ae.initCause(e);
                throw ae;

            } catch (IOException e) {
                final UserInfoDAOException ae = new UserInfoDAOException("IOException: " + e.getMessage());
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

    public String getDisplayName(String username) throws UserInfoDAOException {
    	return getField("displayName", username, null);
    }
    
    public String getDisplayName(String username, String password) throws UserInfoDAOException {
    	return getField("displayName", username, password);
    }
    
    public String getPermId(String username) throws UserInfoDAOException {
    	return getField("permId", username, null);
    }

    public String getPermId(String username, String password) throws UserInfoDAOException {
    	return getField("permId", username, password);
    }
    
    private String getField(String fieldName, String username, String password) throws UserInfoDAOException {
    	Connection con = null;
        PreparedStatement ps = null;
        final Collection coll = new ArrayList();
        try {
            con = getConnection();
            
            if(password == null)
            	ps = con.prepareStatement("SELECT " + fieldName + " FROM users WHERE gatorlinkId = \"" + username + "\"");
            else
            	ps = con.prepareStatement("SELECT " + fieldName + " FROM users WHERE (gatorlinkId = \"" + username + "\") AND (gatorlinkPassword = \"" + password + "\")");
            
            
            final ResultSet rs = ps.executeQuery();
            rs.first();
            if (rs.getString(1) != null)
            {
                return rs.getString(1);
            }
            else
            {
                throw new UserInfoDAOException("User does not exist");
            }
            
        } catch (SQLException e) {
            logger.error("Problem in getField with retrieving: " + fieldName, e);
            throw new UserInfoDAOException(e.getMessage());
        }
    }

 
	
    /**
     * Initializes all the user info in a User object at once -
     */
    public void setUserInfo(final User user) throws UserInfoDAOException {
        try {
            doSetUserInfo(user);
        } catch (Exception e) {
            try {
                logger.warn("First DB attempt failed for " + user.getDisplayName() + ", trying again (" + e + ")");
                Thread.sleep(1000);  // one second delay
                doSetUserInfo(user); // try again
            } catch (Exception e2) {
                // second try failed, now throw error
                final UserInfoDAOException userInfoDAOException = new UserInfoDAOException(e2.toString());
                userInfoDAOException.initCause(e);
                throw userInfoDAOException;
            }
        }
    }

    // Tries to fetch the user data out of DB and sets it in the User Object.
    private void doSetUserInfo(final User user) throws UserInfoDAOException {	
        final String permId = getPermId(user.getUsername(), user.getPassword());
        final String displayName = getDisplayName(user.getUsername(), user.getPassword());

        user.setPermId(permId);
        user.setDisplayName(displayName);
    }
}
