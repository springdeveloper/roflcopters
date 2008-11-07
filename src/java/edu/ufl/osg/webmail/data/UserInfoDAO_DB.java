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

/**
 * Interface for obtaining and setting user information.
 *
 * @author ChrisG
 * @version $Revision: 1.1 $
 */
public class UserInfoDAO_DB implements UserInfoDAO {
    private static final Logger logger = Logger.getLogger(UserInfoDAO_DB.class.getName()); // log4j logger
    private DataSource dataSource; // used by DataSource connection method

    protected UserInfoDAO_DB() throws UserInfoDAOException {
        final ConfigDAO configDAO;
        try {
            configDAO = DAOFactory.getInstance().getConfigDAO();
            final String dsjn = configDAO.getProperty("dataSourceJndiName");
            final Context ctx = new InitialContext();
            logger.debug("dataSourceJndiName: " + dsjn);
            dataSource = (DataSource)ctx.lookup(dsjn);
        } catch (Exception e) {
            throw new UserInfoDAOException(e.toString());
        }
    }

    public String getDisplayName(String username) throws UserInfoDAOException {
    	return getField("displayId", username);
    }

    // password authentication by local DB not supported in current implementation
    // authentication to be done by mail server
    public String getDisplayName(String username, String password) throws UserInfoDAOException {
    	return getField("displayId", username);
    }

    public String getPermId(String username) throws UserInfoDAOException {
    	return getField("userId", username);
    }

    // password authentication by local DB not supported in current implementation
    // authentication to be done by mail server
    public String getPermId(String username, String password) throws UserInfoDAOException {
    	return getField("userId", username);
    }
    
    /**
     * Private general method for handling DB data requests from various query methods from interface
     * @param fieldName name of DB column result to return
     * @param username name of user for which to return results
     * @return first result found
     * @throws UserInfoDAOException problem encountered
     */
    private String getField(String fieldName, String username) throws UserInfoDAOException {
        try {
            Connection connect = dataSource.getConnection();
            PreparedStatement statement = connect.prepareStatement("SELECT " + fieldName + " FROM user WHERE gatorlinkId = '" + username + "'");

            final ResultSet results = statement.executeQuery();
            results.first();
			
            if (results.getString(1) != null) {
                return results.getString(1);
            }
            else {
                throw new UserInfoDAOException("User <" + username + "> does not exist.");
            }

        } catch (SQLException e) {
            logger.error("Problem in getField with retrieving: " + fieldName, e);
            throw new UserInfoDAOException(e.getMessage());
        }
    }

    /**
     * Initializes all the user info in a User object at once
     * @param user User object to hold information taken from DB
     * @throws UserInfoDAOException problem encountered
     */
    public void setUserInfo(final User user) throws UserInfoDAOException {
        int numTries = 0, maxTries = 1;
        	
        while(numTries <= maxTries) {
        	try {
        		numTries++;
        		final String permId = getPermId(user.getUsername());
        		final String displayName = getDisplayName(user.getUsername());

        		user.setPermId(permId);
        		user.setDisplayName(displayName);
    
        	} catch(Exception e) {
        		logger.warn("DB attempt #" + numTries + " failed for user " + user.getDisplayName() + ": " + e);
        		if(numTries <= maxTries) {	
        			try { Thread.sleep(1000); } catch(InterruptedException e2) { logger.warn("Current thread failed to sleep:" + e2); }
        			logger.warn("Attempting to connect again for user " + user.getDisplayName() + ".");
        		}
        		else {
        			// all connection attempts up to maxTries failed, now throw error
        			final UserInfoDAOException userInfoDAOException = new UserInfoDAOException(e.toString());
                    userInfoDAOException.initCause(e);
                    throw userInfoDAOException;
        		}
        	}
        }
    }
}
