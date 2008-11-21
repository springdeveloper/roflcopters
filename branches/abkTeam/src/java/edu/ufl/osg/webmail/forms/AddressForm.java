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
 * @author drakee
 * @version $Revision: 1.2 $
 */
public final class AddressForm extends ActionForm {
    private static final Logger logger = Logger.getLogger(AddressForm.class.getName());
    private String name;
    private String email;
	private String company;
	private String position;
	private String phoneHome;
	private String phoneWork;
	private String phoneCell;
	private String address;
	private String notes;

    /**
     * @param mapping The mapping used to select this instance
     * @param request The servlet request we are processing
     */
    public void reset(final ActionMapping mapping, final HttpServletRequest request) {
        setName(null);
        setEmail(null);
		setCompany(null);
		setPosition(null);
		setPhoneHome(null);
		setPhoneWork(null);
		setPhoneCell(null);
		setAddress(null);
		setNotes(null);
	}

    /**
     * Verifies the name and email form a valid RFC 822 email adddress as
     * understood by {@link javax.mail.internet.InternetAddress#validate()}.
     *
     * @param  mapping             The mapping used to select this instance
     * @param  request             The servlet request we are processing
     * @return                     Errors, if any are found.
     */
    public ActionErrors validate(final ActionMapping mapping, final HttpServletRequest request) {
        final ActionErrors errors = new ActionErrors();

        FormsUtil.validateAddress(getEmail(), getName(), errors);

        return errors;
    }

    /**
     * Getter for property email.
     *
     * @return Value of property email.
     */
    public String getEmail() {
        return this.email;
    }

    /**
     * Setter for property email.
     *
     * @param email New value of property email.
     */
    public void setEmail(final String email) {
        this.email = email;
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
	
		
	public void setCompany(String company) {
		this.company = company;
	}
	
	public void setPosition(String position) {
		this.position = position;
	}
	
	public void setPhoneHome(String phoneHome) {
		this.phoneHome = phoneHome;
	}
	
	public void setPhoneWork(String phoneWork) {
		this.phoneWork = phoneWork;
	}
	
	public void setPhoneCell(String phoneCell) {
		this.phoneCell = phoneCell;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public void setNotes(String notes) {
		this.notes = notes;
	}
	
	public String getCompany() {
		return company;
	}
	
	public String getPosition() {
		return position;
	}
	
	public String getPhoneHome() {
		return phoneHome;
	}
	
	public String getPhoneWork() {
		return phoneWork;
	}
	
	public String getPhoneCell() {
		return phoneCell;
	}
	
	public String getAddress() {
		return address;
	}
	
	public String getNotes() {
		return notes;
	}

}
