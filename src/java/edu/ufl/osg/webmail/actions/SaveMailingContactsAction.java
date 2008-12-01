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
import edu.ufl.osg.webmail.data.MailingEntry;
import edu.ufl.osg.webmail.data.MailingList;
import edu.ufl.osg.webmail.data.AddressList;
import edu.ufl.osg.webmail.data.AddressBkEntry;
import edu.ufl.osg.webmail.forms.MailingForm;
import edu.ufl.osg.webmail.forms.MailingContactsForm;
import edu.ufl.osg.webmail.forms.MoveCopyForm;
import edu.ufl.osg.webmail.util.Util;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Iterator;

/**
 * Moves or copies 1 or more messages into another folder.
 *
 * @author drakee
 * @version $Revision: 1.3 $
 */
public class SaveMailingContactsAction extends Action {
    private static final Logger logger = Logger.getLogger(MoveCopyAction.class.getName());

    /**
     * Move or copy a message from one folder to another.
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
    	logger.debug("=== SaveMailingContactsAction.execute() begin ===");
        ActionsUtil.checkSession(request);

        final MailingContactsForm contactsForm = (MailingContactsForm) form;
        
        final HttpSession session = request.getSession();
        final MailingList mailingList = Util.getMailingList(session);
        MailingEntry entry = null;
        
        // find mailing list entry with request groupId, exit search loop when found
        Iterator iterator = mailingList.iterator();
        while(iterator.hasNext()) {
        	entry = (MailingEntry)iterator.next();
        	if(entry.getGroupId() == contactsForm.getToGroupId())
        		break;
        }
        
        // add mailing list contacts for all emails provided
        for(String email : contactsForm.getEmail()) {
        	entry.addContact(email);
        }
        logger.debug("saved contacts to mailing list");

        // set success message for the upcoming view
        final ResultBean result = new ResultBean(Util.getFromBundle("saveMailingContacts.result.success"));
        request.setAttribute(Constants.RESULT, result);

        logger.debug("=== SaveMailingContactsAction.execute() end ===");
        return mapping.findForward("success");
    }
}
