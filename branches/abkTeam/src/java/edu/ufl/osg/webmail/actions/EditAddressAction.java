/*
 * This file is part of GatorMail, a servlet based webmail.
 * Copyright (C) 2002-2004 William A. McArthur, Jr.
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

import edu.ufl.osg.webmail.data.AddressList;
import edu.ufl.osg.webmail.data.AddressBkEntry;
import edu.ufl.osg.webmail.forms.AddressForm;
import edu.ufl.osg.webmail.util.Util;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Saves a list of addresses into a user's address book.
 *
 * @author ChrisG
 * @version $Revision: 1.0 $
 */
public class EditAddressAction extends Action {
    private static final Logger logger = Logger.getLogger(EditAddressAction.class.getName());

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
        logger.debug("=== AddressBkAction.execute() begin ===");
        ActionsUtil.checkSession(request);

        final HttpSession session = request.getSession();
        final AddressForm addressForm = (AddressForm)form;
        final int index = addressForm.getIndex();
        
        // load addressForm with values from in-mem list
        final AddressBkEntry entry = (AddressBkEntry)Util.getAddressList(session).get(index);
        addressForm.setName(entry.getPersonal());
        addressForm.setEmail(entry.getAddress());
        addressForm.setCompany(entry.getCompany());
        addressForm.setPosition(entry.getPosition());
        addressForm.setPhoneHome(entry.getPhoneHome());
        addressForm.setPhoneWork(entry.getPhoneWork());
        addressForm.setPhoneCell(entry.getPhoneCell());
        addressForm.setAddress(entry.getMailingAddress());
        addressForm.setNotes(entry.getNotes());
        
        logger.debug("=== AddressBkAction.execute() end ===");
        return mapping.findForward("success");
    }
}
