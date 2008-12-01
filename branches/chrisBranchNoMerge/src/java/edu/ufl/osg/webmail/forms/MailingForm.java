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
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Holds values required for one Address Book entry.
 *
 * @author ChrisG
 * @version $Revision: 1.0 $
 */
public final class MailingForm extends ActionForm {
    private static final Logger logger = Logger.getLogger(MailingForm.class.getName());
    private String name;
    
    /**
     * @param mapping The mapping used to select this instance
     * @param request The servlet request we are processing
     */
    public void reset(final ActionMapping mapping, final HttpServletRequest request) {
        setName(null);
	}

    /**
     * No validation currently performed
     */
    public ActionErrors validate(final ActionMapping mapping, final HttpServletRequest request) {
        return null;
    }

    /**
     * Getter for property name.
     *
     * @return Value of property name.
     */
    public String getName() {
        return this.name;
    }

    /**
     * Setter for property name.
     *
     * @param name New value of property name.
     */
    public void setName(final String name) {
        this.name = name;
    }
}
