<%@ page import="edu.ufl.osg.webmail.util.Util,
                 edu.ufl.osg.webmail.User,
                 edu.ufl.osg.webmail.prefs.PreferencesProvider,
                 edu.ufl.osg.webmail.Constants,
                 java.util.Properties"%>
<%@page contentType="text/html"%>
<%@taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>
<%
    final User user = Util.getUser(session);
    Properties prefs = null;
	String lang = "";
	String imgSigFile = "/UFsig_small";
    boolean hideHeader = false;
	
    if (user != null) {
        PreferencesProvider pp = (PreferencesProvider)application.getAttribute(Constants.PREFERENCES_PROVIDER);
        prefs = pp.getPreferences(user, session);
        hideHeader = Boolean.valueOf(prefs.getProperty("view.header.hide", "false")).booleanValue();
		lang = prefs.getProperty("pref.lang","false");
    }
	
	if(lang.equals("ja"))
		imgSigFile += "_"+lang;
	
	
    imgSigFile += ".gif";
	
	if (!hideHeader) {
%>

<%-- Andy --%>
<%-- Dependencies --%>
<script type="text/javascript" src="yui/utilities/shortcuts.js"></script>
<script>
shortcut("Ctrl+Shift+H",function(){self.location="/GatorMail/folder.do";});
shortcut("Ctrl+Shift+C",function(){self.location="/GatorMail/compose.do";});
shortcut("Ctrl+Shift+A",function(){self.location="/GatorMail/addressbook.do";});
shortcut("Ctrl+Shift+M",function(){self.location="/GatorMail/folderManage.do";});
shortcut("Ctrl+Shift+P",function(){self.location="/GatorMail/preferences.do";});
shortcut("Ctrl+Shift+L",function(){self.location="/GatorMail/logout.do";});
</script>

	<div id="backgroundAndHeader">
    <!-- START BACKGROUND AND HEADER -->
    <!-- START BACKGROUND -->
    <div id="bg1"></div>
    <div id="bg2"></div>
    <!-- END BACKGROUND -->
    <!-- START LOGO -->
    <div id="webmailLogo"><html:link href="#"><html:img page="/webmail-v2-logo_03.png" border="0" /></html:link></div>
    <!-- END LOGO -->
    <!-- END BACKGROUND AND HEADER -->
	
	<div id="headerImg">
		<html:link href="http://www.ufl.edu/"><html:img page="<%= imgSigFile %>" width="139" height="34" border="0"/></html:link>
	</div>
	
<%
    if (prefs != null) {
        final String username = user.getUsername();
        final String displayName = prefs.getProperty("user.name");
%>
	<div id="headerName">
		<bean:message key="common.currentUser" arg0="<%= username %>" arg1="<%= displayName %>"/>
	</div>
<%
    }
%>
	<div id="nav">
		<tiles:get name="navBar.jsp"/>
	</div>
    
	</div>
<%
    }
%>
