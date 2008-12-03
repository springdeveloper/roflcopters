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

package edu.ufl.osg.webmail.actions;

import edu.ufl.osg.webmail.Constants;
import edu.ufl.osg.webmail.beans.ResultBean;
import edu.ufl.osg.webmail.data.AddressList;
import edu.ufl.osg.webmail.forms.AddressForm;
import edu.ufl.osg.webmail.util.Util;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import java.util.Iterator;

import edu.ufl.osg.webmail.data.AddressBkEntry;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Updates an addressbook entry in the DB and in users in-mem list
 *
 * @author ChrisG
 * @version $Revision: 1.0 $
 */
public class SaveEditedAddressAction extends Action {
    private static final Logger logger = Logger.getLogger(SaveAddressAction.class.getName());

    /**
     * Saves an addressbook entry.
     *
     * @param     mapping             The ActionMapping used to select this
     *                                instance
     * @param     form                The optional ActionForm bean for this
     *                                request (if any)
     * @param     request             The HTTP request we are processing
     * @param     response            The HTTP response we are creating
     * @exception Exception if the application business
     *                                logic throws an exception
     */
    public ActionForward execute(final ActionMapping mapping, final ActionForm form, final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        logger.debug("=== SaveAddressAction.execute() begin ===");
        ActionsUtil.checkSession(request);

        final ActionErrors errors = new ActionErrors();
        final HttpSession session = request.getSession();
        final AddressList addressList = Util.getAddressList(session);
        final AddressForm addressForm = (AddressForm)form;
        final AddressBkEntry entry = (AddressBkEntry)addressList.get(addressForm.getIndex());
		
        String email = addressForm.getEmail();
        email = email != null ? email.trim() : null;
		
        String name = addressForm.getName();
        name = name != null ? name.trim() : null;
		
		String company = addressForm.getCompany();
		company = company != null ? company.trim() : null;
		
		String position = addressForm.getPosition();
		position = position != null ? position.trim() : null;	
		
		String phoneHome = addressForm.getPhoneHome();
		phoneHome = phoneHome != null ? phoneHome.trim() : null;

		String phoneWork = addressForm.getPhoneWork();
		phoneWork = phoneWork != null ? phoneWork.trim() : null;
		
		String phoneCell = addressForm.getPhoneCell();
		phoneCell = phoneCell != null ? phoneCell.trim() : null;
		
		String address = addressForm.getAddress();
		address = address != null ? address.trim() : null;	
		
		String notes = addressForm.getNotes();
		notes = notes != null ? notes.trim() : null;	
	
		String oldEmail = entry.getAddress();
        
        // if email address has been changed
        // check for addressbook entry with duplicate primary email address, disallow edit if found
        if(!email.equals(oldEmail))
        {
	        AddressBkEntry curEntry;
	        Iterator iterator = addressList.iterator();
	        while(iterator.hasNext()) {
	        	curEntry = (AddressBkEntry) iterator.next();
	        	if(curEntry.getAddress().equals(email)) {
	        		logger.error("addressList already contains contact with primary email '" + entry.getAddress() + "'");
	                errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.address.duplicate", entry.getAddress()));
	                saveErrors(request, errors);
	                return mapping.findForward("fail");
	        	}
	        }
        }
        
        entry.setPersonal(name);
        entry.setAddress(email);
        entry.setCompany(company);
        entry.setPosition(position);
        entry.setPhoneHome(phoneHome);
        entry.setPhoneWork(phoneWork);
        entry.setPhoneCell(phoneCell);
        entry.setMailingAddress(address);
        entry.setNotes(notes);
        logger.debug("edited addressbook entry: " + entry);
        
        // write changes to DB
        addressList.commitEditsForContact(oldEmail, entry);

        // set success message for the upcoming view
        final ResultBean result = new ResultBean(Util.getFromBundle("saveAddress.result.success"));
        request.setAttribute(Constants.RESULT, result);

        logger.debug("=== SaveAddressAction.execute() end ===");
        return mapping.findForward("success");
    }
}

