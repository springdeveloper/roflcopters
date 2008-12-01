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
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

/**
 * This is the Container for holding mailing lists.
 *
 * @author ChrisG
 * @version $Revision: 1.0 $
 */
public final class MailingList implements List {
    private static final Logger logger = Logger.getLogger(AddressList.class.getName());

    private String permId;
    private List mailingList;
    private transient AddressBkDAO addressBkDAO;

    // constructor
    public MailingList(final String permId) throws AddressBkDAOException {
        this.permId = permId;
        this.mailingList = new ArrayList();
    }

    /**
     * Adds Email entry into both in-memory list and backend storage.
     */
    public boolean addMailing(final MailingEntry mailing) throws AddressBkDAOException {
        int groupId = getAddressBkDAO().addMailing(permId, mailing);
        mailing.setGroupId(groupId);
        return add(mailing);
    }
    
    /**
     * Writes updated contact info to DB without affecting in-mem list (assumed to already be updated)
     * @param oldEmail email to identify contact in DB
     * @param editedEntry data to update old data with
     * @return true if successful, false otherwise
     * @throws AddressBkDAOException
     */
    public boolean editMailingName(final int groupId, String newName) throws AddressBkDAOException {
    	
    	// find entry with matching groupId in list and set its name to newName
    	Iterator iterator = this.iterator();
    	while(iterator.hasNext()) {
    		MailingEntry curMailing = (MailingEntry) iterator.next();
    		if(curMailing.getGroupId() == groupId) {
    			curMailing.setName(newName);
    			break;
    		}
    	}
    	// update DB info
    	getAddressBkDAO().editMailingName(groupId, newName);
    	return true;
    }
    
    /**
     * Removes Email entry from both in-memory list and backend storage.
     */
    public boolean removeMailing(final int groupId) throws AddressBkDAOException {
        getAddressBkDAO().removeMailing(groupId);
        
        // search through the in-mem contacts list to find entry with same id as one
        // given, when found delete entry
        Iterator iterator = this.iterator();
    	while(iterator.hasNext()) {
    		MailingEntry curMailing = (MailingEntry) iterator.next();
    		if(curMailing.getGroupId() == groupId) {
    			this.remove(curMailing);
    			return true;
    		}
    	}
        logger.error("Contact to remove not found in in-mem list");
        throw new AddressBkDAOException("Contact to remove not found in in-mem list");
    }

    public String toString() {
        final StringBuffer buff = new StringBuffer();
        final int size = mailingList.size();
        for (int i = 0; i < size; i++) {
            final MailingEntry mailing = (MailingEntry)mailingList.get(i);
            buff.append(mailing.toString());
            if (i < size - 1)
                buff.append(", ");
        }
        return buff.toString();
    }

    private AddressBkDAO getAddressBkDAO() throws AddressBkDAOException {
        if (addressBkDAO == null) {
	    addressBkDAO = DAOFactory.getInstance().getAddressBkDAO();
	}
	return addressBkDAO;
    }

    ////////////////////////////////////////////////////////////
    // satisfy the List interface:
    ////////////////////////////////////////////////////////////
    public void add(final int index, final Object element) {
        if (!(element instanceof MailingEntry )) return;
        mailingList.add(index, element);
    }

    public boolean add(final Object o) {
        if (!(o instanceof MailingEntry )) return false;
        mailingList.add(o);
        return true;
    }

    public boolean addAll(final Collection c) {
        final Iterator it = c.iterator();
        while (it.hasNext()) {
            final Object o = it.next();
            if (!(o instanceof MailingEntry )) return false;
        }
        mailingList.addAll(c);
        return true;
    }

    public boolean addAll(final int index, final Collection c) {
        final Iterator it = c.iterator();
        while (it.hasNext()) {
            final Object o = it.next();
            if (!(o instanceof MailingEntry )) return false;
        }
        mailingList.addAll(index, c);
        return true;
    }

    public void clear() {
        mailingList.clear();
    }

    public boolean contains(final Object o) {
        return mailingList.contains(o);
    }

    public boolean containsAll(final Collection c) {
        return mailingList.containsAll(c);
    }

    public boolean equals(final Object o) {
        return mailingList.equals(o);
    }

    public Object get(final int index) {
        return mailingList.get(index);
    }

    public int hashCode() {
        return mailingList.hashCode();
    }

    public int indexOf(final Object o) {
        return mailingList.indexOf(o);
    }

    public boolean isEmpty() {
        return mailingList.isEmpty();
    }

    public Iterator iterator() {
        return mailingList.iterator();
    }

    public int lastIndexOf(final Object o) {
        return mailingList.lastIndexOf(o);
    }

    public ListIterator listIterator() {
        return mailingList.listIterator();
    }

    public ListIterator listIterator(final int index) {
        return mailingList.listIterator(index);
    }

    public Object remove(final int index) {
        return mailingList.remove(index);
    }

    public boolean remove(final Object o) {
        return mailingList.remove(o);
    }

    public boolean removeAll(final Collection c) {
        return mailingList.removeAll(c);
    }

    public boolean retainAll(final Collection c) {
        return mailingList.retainAll(c);
    }

    public Object set(final int index, final Object element) {
        if (!(element instanceof MailingEntry )) return null;
        return mailingList.set(index, element);
    }

    public int size() {
        return mailingList.size();
    }

    public List subList(final int fromIndex, final int toIndex) {
        return mailingList.subList(fromIndex, toIndex);
    }

    public Object[] toArray() {
        return mailingList.toArray();
    }

    public Object[] toArray(final Object[] a) {
        return mailingList.toArray(a);
    }
}
