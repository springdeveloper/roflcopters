<%@ page import="edu.ufl.osg.webmail.User,
                 edu.ufl.osg.webmail.util.Util,
                 edu.ufl.osg.webmail.imap.UFIMAPSessionProvider"%>
<%@page contentType="text/html"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>

   <table width="100%" height="15px" border="0" cellspacing="0" cellpadding="7">
    <tr>
     <td>
       <html:link forward="folder" titleKey="link.checkMail.title"><bean:message key="link.checkMail"/></html:link>
       |
       <html:link forward="compose" titleKey="link.compose.title"><bean:message key="link.compose"/></html:link>
       |
       <html:link forward="addressbook" titleKey="link.addressBook.title"><bean:message key="link.addressBook"/></html:link>
       |
       <html:link forward="folderManage" titleKey="link.manageFolder.title"><bean:message key="link.manageFolder"/></html:link>
       |
       <html:link forward="preferences" titleKey="link.preferences.title"><bean:message key="link.preferences"/></html:link>
       |
<%
    final User user = Util.getUser(session);

    // if UF User than use http://login.gatorlink.ufl.edu/quit.cgi to logout.
    if (user instanceof UFIMAPSessionProvider.UFUser) {
%>
       <html:link href="http://login.gatorlink.ufl.edu/quit.cgi" titleKey="gatorlink.link.logout.title"><bean:message key="gatorlink.link.logout"/></html:link>
<%
    } else {
%>
       <html:link forward="logout" titleKey="link.logout.title"><bean:message key="link.logout"/></html:link>
<%
    }
%>
     </td>
     <td>
      <div align="right">
        <html:link forward="help" titleKey="link.help.title"><bean:message key="link.help"/></html:link>
        |
	    <html:link forward="about" titleKey="link.about.title"><bean:message key="link.about"/></html:link>
        |
	    <html:link forward="feedback" titleKey="link.feedback.title"><bean:message key="link.feedback"/></html:link>
      </div>
     </td>
    </tr>
   </table>