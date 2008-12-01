<%@page contentType="text/html"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>
<html:form action="saveEditedAddress">
	<html:hidden property="index" value="${addressForm.index}" />
   <table class="addressBook" width="100%" cellpadding="4" cellspacing="0">
    <tr>
      <th colspan="2" class="darkBlueRow" align="center">
        <bean:message key="editAddress.header"/>
      </th>
    </tr>
    <tr>
     <td class="leftNavBar" width="170"><bean:message key="addAddress.name"/></td>
     <td><html:text property="name" size="30" maxlength="40"/></td>
    </tr>
    <tr>
     <td class="leftNavBar" width="170"><bean:message key="addAddress.email"/></td>
     <td><html:text property="email" size="30" maxlength="40"/></td>
    </tr>
	<tr>
     <td class="leftNavBar" width="170">Company</td>
     <td><html:text property="company" size="30" maxlength="40"/></td>
    </tr>
    <tr>
     <td class="leftNavBar" width="170">Position</td>
     <td><html:text property="position" size="30" maxlength="40"/></td>
    </tr>
    <tr>
     <td class="leftNavBar" width="170">Home Phone</td>
     <td><html:text property="phoneHome" size="30" maxlength="40"/></td>
    </tr>
    <tr>
     <td class="leftNavBar" width="170">Work Phone</td>
     <td><html:text property="phoneWork" size="30" maxlength="40"/></td>
    </tr>
    <tr>
     <td class="leftNavBar" width="170">Cell Phone</td>
     <td><html:text property="phoneCell" size="30" maxlength="40"/></td>
    </tr>
    <tr>
     <td class="leftNavBar" width="170">Mailing Address</td>
     <td><html:text property="address" size="30" maxlength="40"/></td>
    </tr>
    <tr>
     <td class="leftNavBar" width="170">Notes</td>
     <td><html:textarea property="notes" cols="30" rows="5" /></td>
    </tr>
    <tr>
     <td class="leftNavBar" width="170">&nbsp;</td>
     <td class="lightBlueRow">
      <html:submit><bean:message key="button.saveEntry"/></html:submit>
     </td>
    </tr>
   </table>
</html:form>

<p>
 <html:link forward="addressbook"><bean:message key="link.backToAddressBk"/></html:link>
</p>