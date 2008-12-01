<%@page contentType="text/html"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>
<html:form action="saveMailing">
   <table class="addressBook" width="100%" cellpadding="4" cellspacing="0">
    <tr>
      <th colspan="2" class="darkBlueRow" align="center">
        <bean:message key="addMailing.header"/>
      </th>
    </tr>
    <tr>
     <td class="leftNavBar" width="170"><bean:message key="addMailing.name"/></td>
     <td><html:text property="name" size="30" maxlength="40"/></td>
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
