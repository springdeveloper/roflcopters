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
 
 /**
 * @author Rob
 * @version $Revision: 1.2 $
 */
 
 package edu.ufl.osg.webmail.data;
 
 import java.lang.Comparable;
 import java.io.Serializable;
 import javax.mail.internet.InternetAddress;
 import javax.mail.internet.AddressException;
 import java.io.UnsupportedEncodingException;
 
 public class AddressBkEntry implements Comparable, Serializable {
	private InternetAddress email = new InternetAddress();
	private String company;
	private String position;
	private String phoneHome;
	private String phoneWork;
	private String phoneCell;
	private String address;
	private String notes;
	
	public AddressBkEntry(String name, String email) throws AddressException, UnsupportedEncodingException
	{
		setPersonal(name);
		setAddress(email);
	}
	
	public AddressBkEntry(String name, String email, String company, String position, String phoneHome, String phoneWork, String phoneCell, String address, String notes) throws AddressException, UnsupportedEncodingException
	{
		setPersonal(name);
		setAddress(email);
		setCompany(company);
		setPosition(position);
		setPhoneHome(phoneHome);
		setPhoneWork(phoneWork);
		setPhoneCell(phoneCell);
		setMailingAddress(address);
		setNotes(notes);
	}
	
	public void setPersonal(String name) throws UnsupportedEncodingException {
		email.setPersonal(name);
	}
	
	public void setAddress(String email) throws AddressException {
		this.email.setAddress(email);
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
	
	public void setMailingAddress(String address) {
		this.address = address;
	}
	
	public void setNotes(String notes) {
		this.notes = notes;
	}
	
	public String getPersonal() {
		return email.getPersonal();
	}
	
	public String getAddress() {
		return email.getAddress();
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
	
	public String getMailingAddress() {
		return address;
	}
	
	public String getNotes() {
		return notes;
	}
	
	public String getAbkPersonEntry()
	{
		return "'"+email.getPersonal()+"','"+company+"','"+position+"','"+phoneHome+"','"+phoneWork+"','"+phoneCell+"','"+address+"','"+notes+"'";
	}
	
	public String getAbkEmailEntry()
	{
		return "'"+email.getAddress()+"'";
	}
	
	public String toString()
	{
		return email.toString();
	}
	
	public int compareTo(Object comp) {
		AddressBkEntry tmp = (AddressBkEntry) comp;
		
		if (this.getPersonal().compareTo(tmp.getPersonal()) < 0) {
            return -1;
        } else if (this.getPersonal().compareTo(tmp.getPersonal()) > 0) {
            return 1;
        }
        // entries are equal, so let's compare email addresses
        if (this.getAddress().compareTo(tmp.getAddress()) < 0) {
            return -1;
        } else if (this.getAddress().compareTo(tmp.getAddress()) > 0) {
            return 1;
        }
		
		return 0;
	}
 }
 