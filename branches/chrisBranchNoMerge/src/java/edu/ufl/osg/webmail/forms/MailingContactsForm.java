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

package edu.ufl.osg.webmail.forms;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForm;

import javax.servlet.http.HttpServletRequest;

/**
 * Holds values required for one or more Address Book entries.
 *
 * @author ChrisG
 * @version $Revision: 1.0 $
 */
public final class MailingContactsForm extends ActionForm {
    private static final Logger logger = Logger.getLogger(MailingContactsForm.class.getName());

    private int toGroupId;
    private String[] email;

    /**
     * @param mapping The mapping used to select this instance
     * @param request The servlet request we are processing
     */
    public void reset(final ActionMapping mapping, final HttpServletRequest request) {
    	setToGroupId(-1);
        setEmail(null);
    }

    /**
     * Verifies nothing
     */
    public ActionErrors validate(final ActionMapping mapping, final HttpServletRequest request) {
        return null;
    }

    /**
     * Getter for property email.
     *
     * @return Value of property email.
     */
    public String[] getEmail() {
        return email != null ? (String[])email.clone() : null;
    }

    /**
     * Setter for property email.
     *
     * @param email New value of property email.
     */
    public void setEmail(final String[] email) {
        this.email = email != null ? (String[])email.clone() : null;
    }


    public int getToGroupId() {
        return this.toGroupId;
    }

    public void setToGroupId(final int toGroupId) {
        this.toGroupId = toGroupId;
    }
}
