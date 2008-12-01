<%@page contentType="text/html" import="edu.ufl.osg.webmail.Constants,
                                        java.util.HashMap,
                                        java.util.Map,
                                        edu.ufl.osg.webmail.data.AddressBkEntry,
                                        edu.ufl.osg.webmail.data.AddressList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>

<div class='abk' id='container'>
   		<table class='abkLayout'>
   			<tr>
   				<td class='first'>
   					<html:form action="saveMailingContacts">
						<table class="headerTable" cellspacing="0" cellpadding="4" width="100%">
						   <thead>
						   		<tr>
						   			<td colspan="4">
						   				Contacts
						   			</td>
						   		</tr>
						   </thead>
						   <tr class="subheader">
						     
						     <td colspan="4">
						       <bean:define id="usage" name="<%=Constants.ADDRESSBK_USAGE%>" scope="request" type="java.lang.String"/>
						       <bean:define id="limit" name="<%=Constants.ADDRESSBK_LIMIT%>" scope="request" type="java.lang.String"/>
						       <bean:message key="addressbook.limit.message" arg0="<%=usage%>" arg1="<%=limit%>"/>
						     </td>
						   </tr>
						   <tr class="subheader">
						   		<td><html:link forward="addAddress"><bean:message key="link.addAddress"/></html:link></td>
						   		<td colspan="3">
						   			Add to Mailing List:
						   			<select name="toGroupId">
						   				<c:forEach items="${mailingList}" var="mailingEntry" varStatus="index">
						   					<option value="${mailingEntry.groupId}">${mailingEntry.name}</option>
						   				</c:forEach>
						   			</select>
						   			<html:submit><bean:message key="button.submit"/></html:submit>
						   		</td>
						   </tr>
						   <tr class="header">
						   	  <th />
						      <th><bean:message key="addressbook.name"/></th>
						      <th><bean:message key="addressbook.email"/></th>
						      <th></th>
						   </tr>
			   
						<%
					    Map composeParams = new HashMap();
					    pageContext.setAttribute("composeParams", composeParams);
					    Map outParams = new HashMap();
					    pageContext.setAttribute("outParams", outParams);
					    Map editParams = new HashMap();
					    pageContext.setAttribute("editParams", editParams);
					    
					    int indexCount = 0; // counter for upcoming loop 
						%>
					   		<c:forEach items="${addressList}" var="internetAddress" varStatus="index">
					   <%
					     AddressBkEntry internetAddress = (AddressBkEntry)pageContext.getAttribute("internetAddress");
					     AddressList addressList = (AddressList)pageContext.getAttribute("addressList");
					     composeParams.put("to", internetAddress.toString());
					     outParams.put("email", internetAddress.getAddress());
					     outParams.put("name", internetAddress.getPersonal());
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
					     <td><input type="checkbox" name="email" value="${internetAddress.address}" /></td>
					     <td>
					     	<html:link forward="editAddress" name="editParams" scope="page">
					     		<bean:write name="internetAddress" property="personal"/>
					     	</html:link>
					     </td>
					     <td><bean:write name="internetAddress" property="address"/></td>
					     <td>
						 <html:link forward="deleteAddress" name="outParams" scope="page">
						   <bean:message key="addressbook.delete"/>
						 </html:link>
					     </td>
					   </tr>
					  </c:forEach>
					</table>
				</html:form>
			</td>
			<td>
				<table class="headerTable" id="mailingList" cellspacing="0" cellpadding="4" width="100%">
					   <thead>
					   		<tr>
					   			<td colspan="3">
					   				Mailing Lists
					   			</td>
					   		</tr>
					   </thead>
					   <tr class="subheader">
					     <td>
					       <html:link forward="addMailing"><bean:message key="link.addMailing"/></html:link>
					     </td>
					     <td colspan="2">
					     </td>
					   </tr>
					   <tr class="header">
					      <th><bean:message key="addressbook.name"/></th>
					      <th></th>
					      <th></th>
					   </tr>
				   		<c:forEach items="${mailingList}" var="mailingEntry" varStatus="index">
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
				     		<bean:write name="mailingEntry" property="name"/>
				     	</html:link>
				     </td>
				     <td></td>
				     <td>
					 <html:link forward="deleteAddress" name="outParams" scope="page">
					   <bean:message key="addressbook.delete"/>
					 </html:link>
				     </td>
				   </tr>
				  </c:forEach>
				</table>
			</td>
		</tr>
</table>
