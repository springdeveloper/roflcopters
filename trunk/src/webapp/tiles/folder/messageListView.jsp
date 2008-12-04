<%@page contentType="text/html" import="java.util.List,
                                        edu.ufl.osg.webmail.actions.FolderAction"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>
<bean:define id="folderName" name="folder" property="fullName" type="java.lang.String"/>
<table width="100%" border="0" cellpadding="4" cellspacing="0" class="folderMessageList">
 <tr class="lightBlueRow">
  <td alight="left">
   <html:form action="folder" style="padding : 0px; margin : 0px; border : 0px;">
    <html:hidden property="folder" value="<%=folderName%>"/>
    <html:hidden property="filterType" value="simple" />
    <html:text property="filter" size="30" titleKey="folder.filter.filter.title"/>
    <html:submit property="action" styleClass="button" titleKey="folder.filter.action.title">
     <bean:message key="button.filter"/>
    </html:submit>
   </html:form>
  </td>
  <td align="right">
<script language="JavaScript" type="text/javascript">
function jumpToPage(f) {
window.location = "folder.do?folder=<%=folderName%>&sort=${folderSort}&page=" + f.value;
}
</script>
<c:if test="${not empty folderListPage}">
<form>
  <c:choose>
   <c:when test="${folderListPage > 1}">
     <a href="folder.do?folder=<%=folderName%>&amp;sort=<c:out value="${folderSort}"/>&amp;page=<c:out value="${folderListPage-1}"/>">&lt;&nbsp;prev</a>
   </c:when>
   <c:otherwise>
     <a href="folder.do?folder=<%=folderName%>&amp;sort=<c:out value="${folderSort}"/>&amp;page=0"><bean:message key="label.showAll"/></a>
   </c:otherwise>
  </c:choose>
<select onchange="jumpToPage(this)">
<c:forEach begin="1" end="${folderListPages}" var="page">
<c:choose>
 <c:when test="${page == (folderListPage)}">
 <option value="<c:out value="${page}"/>" selected="selected"><c:out value="${page}"/></option>
 </c:when>
 <c:otherwise>
  <option value="<c:out value="${page}"/>"><c:out value="${page}"/></option>
 </c:otherwise>
</c:choose>
</c:forEach>
</select> of <b><c:out value="${folderListPages}"/></b>
<c:if test="${folderListPage < folderListPages}">
	<a href="folder.do?folder=<%=folderName%>&amp;sort=<c:out value="${folderSort}"/>&amp;page=<c:out value="${folderListPage+1}"/>">
		<bean:message key="link.next"/>
	</a>
</c:if>
</form>
</c:if>
  </td>
 </tr>
</table>
