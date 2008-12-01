<%@ page import="javax.mail.Message,
                 javax.mail.Folder,
                 edu.ufl.osg.webmail.util.Util,
                 java.util.Map,
                 java.util.HashMap"%>
<%@page contentType="text/html"%>
<%@taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>
<%
    Message message = (Message)request.getAttribute("message");
    String sort = (String)request.getAttribute("sort");

    Folder mF = message.getFolder();
    request.setAttribute("messageFolder", mF);

    Map mP = new HashMap();
    Util.addMessageParams(message,sort, mP);
    request.setAttribute("messageParams", mP);
%>
<bean:define id="messageParams" name="messageParams" scope="request" type="java.util.Map"/>
<bean:define id="messageFolder" name="messageFolder" scope="request" type="javax.mail.Folder"/>
<html:html locale="true" xhtml="true">
<head>
 <title>
  <bean:message key="site.title"/>
  <bean:message key="message.title"/>
 </title>
<%--
// TODO I18N these
--%>
 <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
 <link rel="start" href="<html:rewrite forward="INBOX"/>" title="INBOX"/>
 <link rel="up" href="<html:rewrite forward="folder" paramId="folder" paramName="messageFolder" />" title="<%= mF.getFullName() %>"/>
 <link rel="prev" href="<html:rewrite forward="prevMessage" name="messageParams"/>" title="Previous Message"/>
 <link rel="next" href="<html:rewrite forward="nextMessage" name="messageParams"/>" title="Next Message"/>
 <link rel="help" href="<html:rewrite forward="help"/>" title="GatorMail Help"/>
 <link rel="alternate" href="<html:rewrite forward="printerFriendly" name="messageParams"/>" title="Printer Friendly View"/>
 <link rel="alternate" href="<html:rewrite forward="reportSpam" name="messageParams"/>" title="Report As Spam"/>
 <link rel="alternate" href="<html:rewrite forward="reportHam" name="messageParams"/>" title="Report As Not Spam"/>
 <link rel="alternate" href="<html:rewrite forward="rawMessage" name="messageParams"/>" title="Message Source"/>
<%--
 XXX: Despite all sorts of recomendations I think this causes more problems
    than it helps. -Sandy 7/23
 <html:base/>
--%>
 <link rel="stylesheet" type="text/css" href="<html:rewrite forward="CSS"/>"/>
</head>
<body>

  <tiles:get name="header"/>


<div id="ContentContainer">
<!-- BEGIN CONTENT CONTAINER -->
	<div id="defaultCenterUI">
    	<div id="defaultCenterUIContentBoxTop"> <!-- RENAME THIS TO REFLECT THE BOX -->
        	<div class="topLeft"></div>
        	<div class="top"></div>
        	<div class="topRight"></div>
            <div class="errSpace">&nbsp;</div>
            <div class="left"></div>
            <div class="right"></div>               
        </div>
    	<div id="defaultCenterUIContentBoxMiddle"> <!-- RENAME THIS TO REFLECT BOX -->
            <div class="left"></div>
            <div id="defaultCenterUIContent"> <!-- RENAME THIS TO REFLECT BOX AS WELL -->
            <!-- DEFAULT FOLDER UI CONTENT START -->
			   <tiles:get name="results"/>
			   <tiles:get name="messageMenuHead"/>
			   <tiles:get name="body"/>
			   <tiles:get name="messageMenuFoot"/>
      		<!-- DEFAULT FOLDER UI CONTENT STOP -->		
            <!-- BEGIN FOR IE -->
    		<div class="clear">&nbsp;</div> 
    		<!-- END FOR IE -->
            </div>
            <div class="right"></div> 
        </div>
        <div class="defaultCenterUIContentBoxBottom"> <!-- RENAME THIS TO REFLECT BOX -->
        	<div class="bottomLeft"></div>
        	<div class="bottom"></div>
        	<div class="bottomRight"></div>
        </div>
    <!-- END CONTENT BOX LOGIN UI -->
    
    </div>
    
    <!-- BEGIN FOR IE -->
    <div class="clear">&nbsp;</div> 
    <!-- END FOR IE -->
    
    
    <div id="defaultFooterUI">
    <!-- BEGIN DEFAULT FOOTER -->
        <p class="copyright">
            Copyright &copy; 2002-2005 <a href="http://Sandy.McArthur.org/" style="color:gray;text-decoration:none">William A. McArthur, Jr.</a> <br/>
            Copyright &copy; 2003-2007 <a href="http://open-systems.ufl.edu/">The Open Systems Group</a> <br/>
            Copyright &copy; 2008 <a href="http://www.cise.ufl.edu/~f63022bw/roflcopters/">CEN3031 ROFLCOPTERS</a> <br/>
            <a href="http://www.cns.ufl.edu/">Computing and Networking Services</a> /
            <a href="http://www.ufl.edu/">University of Florida</a> <br/>
            Site maintained by <a href="http://open-systems.ufl.edu/">The Open Systems Group</a>
            <br/> Last Modified: @DATE@
        </p>
    <!-- END DEFAULT FOOTER -->
    </div>
<!-- END CONTENT CONTAINER -->
</div> 
 	

</body>
</html:html>
