<%@page contentType="text/html" import="edu.ufl.osg.webmail.Constants,
                                        java.util.HashMap,
                                        java.util.Map,
                                        edu.ufl.osg.webmail.data.AddressBkEntry,
                                        edu.ufl.osg.webmail.data.AddressList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>

<table class="headerTable" cellspacing="0" cellpadding="4" width="100%">
   <tr class="subheader">
     <td>
       <html:link forward="addAddress"><bean:message key="link.addAddress"/></html:link>
     </td>
     <td colspan="3">
       <bean:define id="usage" name="<%=Constants.ADDRESSBK_USAGE%>" scope="request" type="java.lang.String"/>
       <bean:define id="limit" name="<%=Constants.ADDRESSBK_LIMIT%>" scope="request" type="java.lang.String"/>
       <bean:message key="addressbook.limit.message" arg0="<%=usage%>" arg1="<%=limit%>"/>
     </td>
   </tr>
   <tr class="header">
      <th><bean:message key="addressbook.name"/></th>
      <th><bean:message key="addressbook.email"/></th>
      <th><bean:message key="addressbook.delete"/></th>
      <th width="30%">&nbsp;</th>
   </tr>
<%
    Map composeParams = new HashMap();
    pageContext.setAttribute("composeParams", composeParams);
    Map deleteParams = new HashMap();
    pageContext.setAttribute("deleteParams", deleteParams);
    Map editParams = new HashMap();
    pageContext.setAttribute("editParams", editParams);
    
    int indexCount = 0; // counter for upcoming loop 
%>
  <c:forEach items="${addressList}" var="internetAddress" varStatus="index">
   <%
     AddressBkEntry internetAddress = (AddressBkEntry)pageContext.getAttribute("internetAddress");
     AddressList addressList = (AddressList)pageContext.getAttribute("addressList");
     composeParams.put("to", internetAddress.toString());
     deleteParams.put("email", internetAddress.getAddress());
     deleteParams.put("name", internetAddress.getPersonal());
     editParams.put("index", indexCount++); // get location of contact in in-memory list
     
   %>
    <c:choose>
     <c:when test="${index.index % 2 == 0}">
      <tr>
     </c:when>
     <c:otherwise>
      <tr class="altrow">
     </c:otherwise>
    </c:choose>
     <td>
     	<html:link forward="editAddress" name="editParams" scope="page">
     		<bean:write name="internetAddress" property="personal"/>
     	</html:link>
     </td>
     <td><bean:write name="internetAddress" property="address"/></td>
     <td>
	 <html:link forward="deleteAddress" name="deleteParams" scope="page">
	   <bean:message key="addressbook.delete"/>
	 </html:link>
     </td>
     <td width="30%">&nbsp;</td>
   </tr>
  </c:forEach>


</table>
