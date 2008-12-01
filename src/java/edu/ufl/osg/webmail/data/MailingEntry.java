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

import org.apache.log4j.Logger;

import java.util.ArrayList;

/**
 * This is the Container for holding InternetAddresses. It is self-sorting.
 * This is what is retrieved from the AddressBkDAO, and all InternetAddress
 * objects are accessed through here.
 *
 * @author ChrisG
 * @version $Revision: 1.0 $
 */
public final class MailingEntry {
    private static final Logger logger = Logger.getLogger(AddressList.class.getName());

    private int groupId;
    private String name;
    private ArrayList<Integer> mailing;
    private transient AddressBkDAO addressBkDAO;

    // constructor
    public MailingEntry(String name) throws AddressBkDAOException {
    	this.name = name;
        this.mailing = new ArrayList<Integer>();
    }
    
    public MailingEntry(int id, String name) throws AddressBkDAOException {
    	this.groupId = id;
    	this.name = name;
        this.mailing = new ArrayList<Integer>();
    }
    
    public String getName() {
    	return this.name;
    }
    
    public int getGroupId() {
    	return this.groupId;
    }
    
    public void setName(String name) {
    	this.name = name;
    }
    
    public void setGroupId(int groupId) {
    	this.groupId = groupId;
    }

    /**
     * Checks if an email address is already present in this List
     */
    public boolean containsContact(final int contactId) {
        return mailing.contains(Integer.valueOf(contactId));
    }

    /**
     * Adds Mailing contact entry into both in-memory list and backend storage.
     */
    public boolean addContact(final int contactId) throws AddressBkDAOException {
        getAddressBkDAO().addMailingContact(groupId, contactId);
        mailing.add(Integer.valueOf(contactId));
        return true;
    }
    
    /**
     * Adds Mailing contact entry into both in-memory list and backend storage.
     * @return contactId
     */
    public int addContact(final String email) throws AddressBkDAOException {
        int contactId = getAddressBkDAO().addMailingContact(groupId, email);
        mailing.add(Integer.valueOf(contactId));
        return contactId;
    }
    
    /**
     * Removes Email entry from both in-memory list and backend storage.
     */
    public boolean removeContact(final int contactId) throws AddressBkDAOException {
        getAddressBkDAO().removeMailingContact(groupId, contactId);
        return mailing.remove(Integer.valueOf(contactId));
    }
    
    public String toString() {
    	return this.getName();
    }

    private AddressBkDAO getAddressBkDAO() throws AddressBkDAOException {
        if (addressBkDAO == null) {
	    addressBkDAO = DAOFactory.getInstance().getAddressBkDAO();
	}
	return addressBkDAO;
    }
}
