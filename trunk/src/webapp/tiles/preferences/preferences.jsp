<%@page contentType="text/html" import="java.util.List,
                                        edu.ufl.osg.webmail.util.Util,
                                        edu.ufl.osg.webmail.Constants,
                                        java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>
<%@taglib uri="/tags/webmail" prefix="wm"%>

<html:form action="preferences">
<table class="headerTable" cellpadding="3" cellspacing="0" width="100%">
  <tr class="header">
    <th colspan="2"><bean:message key="preferences.title"/></th>
  </tr>

  <tr class="subheader">
    <th colspan="2" align="left"><bean:message key="preferences.nameAndAddress.title"/></th>
  </tr>

  <tr>
    <th width="20%" align="right" valign="top"><bean:message key="preferences.nameAndAddress.fromName"/></th>
    <td>
      <html:errors property="username"/>
      <html:text property="username" size="40"/>
      <div class="tip">
      		<bean:message key="preferences.nameAndAddress.fromName.help"/>
      </div>
    </td>
  </tr>

  <tr class="altrow">
    <th width="20%" align="right" valign="top"><bean:message key="preferences.nameAndAddress.reply"/></th>
    <td>
      <html:errors property="replyTo"/>
      <html:text property="replyTo" size="40"/>
      <div class="tip">
      		<bean:message key="preferences.nameAndAddress.reply.help"/>
      </div>
    </td>
  </tr>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

  <tr class="subheader">
    <th colspan="2" align="left"><bean:message key="compose.title"/></th>
  </tr>

  <tr>
    <th wdith="20%" align="right" valign="top"><bean:message key="preferences.compose.signature"/></th>
    <td>
      <html:errors property="signature"/>
      <html:textarea property="signature" cols="78" rows="5"/>
      <div class="tip">
        	<bean:message key="preferences.compose.signature.help"/>
      </div>
    </td>
  </tr>

  <tr class="altrow">
    <th width="20%" align="right" valign="top"><bean:message key="preferences.compose.RAC"/></th>
    <td>
      <html:checkbox property="autocomplete"/>
		<div class="tip">
			<bean:message key="preferences.compose.RAC.help"/>
		</div>
    </td>
  </tr>

  <tr>
    <th width="20%" align="right" valign="top"><bean:message key="preferences.compose.image"/></th>
    <td>
<%
    if (request.getAttribute("X-Image-Url") != null && ((String)request.getAttribute("X-Image-Url")).length() > 0) {
        final String imageUrl = (String)request.getAttribute("X-Image-Url");
%>
     <div style="width: 48px; height: 48px; float: right; overflow: hidden;">
       <img src="<%= imageUrl %>" border="0" alt="<%= imageUrl %>" title="<%= imageUrl %>"/>
     </div>
<%
    }
%>
      <html:errors property="imageUrl"/>
      <html:text property="imageUrl" size="40"/>
      <div class="tip">
			<bean:message key="preferences.compose.image.help"/>
      </div>
    </td>
  </tr>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

  <tr class="subheader">
    <th colspan="2" align="left"><bean:message key="folder.label.junk"/></th>
  </tr>

  <tr>
    <th width="20%" align="right" valign="top"><bean:message key="preferences.junk.flag"/></th>
    <td>
<%
    final List junkThresholds = new ArrayList(16);
    for (int i=0; i <= 15; i++) {
        junkThresholds.add("" + i);
    }
    pageContext.setAttribute("junkThresholds", junkThresholds);
%>
      <html:errors property="junkThreshold"/>
      <html:select property="junkThreshold">
        <c:forEach items="${junkThresholds}" var="choice">
<%
    String choice = (String)pageContext.getAttribute("choice");
    String filterKey = "message.junk.threshold." + choice;
%>
          <html:option value="<%= choice %>"><bean:message key="<%= filterKey %>"/></html:option>
        </c:forEach>
      </html:select>
      <div class="tip">
       		<bean:message key="preferences.junk.flag.help"/>
      </div>
    </td>
  </tr>

  <tr class="altrow">
    <th width="20%" align="right" valign="top"><bean:message key="preferences.junk.filter"/></th>
    <td>
      <html:checkbox property="junkSieveEnabled"/>
      <div class="tip">
       		<bean:message key="preferences.junk.filter.help"/>
      </div>
    </td>
  </tr>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

  <tr class="subheader">
    <th colspan="2" align="left"><bean:message key="preferences.vacation.title"/></th>
  </tr>

  <tr>
    <th width="20%" align="right" valign="top"><bean:message key="preferences.vacation.message"/></th>
    <td>
        <html:errors property="vacationMessage"/>
        <html:textarea property="vacationMessage" cols="78" rows="5"/>

        <div class="tip">
            <bean:message key="preferences.vacation.message.help"/>
        </div>
    </td>
  </tr>

  <tr class="altrow">
    <th width="20%" align="right" valign="top"><bean:message key="preferences.vacation.enable"/></th>
    <td>
      <html:checkbox property="vacationSieveEnabled"/>
      <div class="tip">
       		<bean:message key="preferences.vacation.enable.help"/>
      </div>
    </td>
  </tr>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

  <tr class="subheader">
    <th colspan="2" align="left"><bean:message key="preferences.view.title"/></th>
  </tr>

  <tr>
    <th width="20%" align="right" valign="top"><bean:message key="preferences.view.showThread"/></th>
    <td>
      <html:errors property="threading"/>
      <html:checkbox property="threading"/>
      <div class="tip">
       		<bean:message key="preferences.view.showThread.help"/>
      </div>
    </td>
  </tr>

  <tr class="altrow">
    <th width="20%" align="right" valign="top"><bean:message key="preferences.view.hideHeader"/></th>
    <td>
      <html:errors property="hideHeader"/>
      <html:checkbox property="hideHeader"/>
      <div class="tip">
			<bean:message key="preferences.view.hideHeader.help"/>
      </div>
    </td>
  </tr>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

<tr class="subheader">
    <th colspan="2" align="left"><bean:message key="preferences.language.title"/></th>
  </tr>

  <tr>
    <th width="20%" align="right" valign="top"><bean:message key="preferences.language.setting"/></th>
    <td>
      <html:select property="language">
	<html:options collection="languages" property="value" labelProperty="label" />
	  </html:select>
       <div class="tip">
       	<bean:message key="preferences.language.setting.help"/>
      </div>
    </td>
  </tr>
  
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

  <tr>
    <td>&nbsp;</td>
    <td>
      <html:submit property="action"><bean:message key="button.savePreferences"/></html:submit>
    </td>
  </tr>


</table>

</html:form>
