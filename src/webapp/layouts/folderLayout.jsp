<%@page contentType="text/html"%>
<%@taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>

<html:html locale="true" xhtml="true">
<head>
 <title>
  <bean:message key="site.title"/>
  <bean:message key="folder.title"/>
  <tiles:getAsString name="folderName"/>
 </title>
 <html:base/>
 <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
 <link rel="start" href="<html:rewrite forward="INBOX"/>" title="INBOX"/>
 <link rel="help" href="<html:rewrite forward="help"/>" title="GatorMail Help"/>
 <link rel="stylesheet" type="text/css" href="<html:rewrite forward="CSS"/>"/>
</head>
<body>

	<tiles:get name="header"/>
   <tiles:get name="navBar"/>

   <div id="defaultSideBarUIContentBox"> <!-- THIS SHOULD BE THE NAME OF THE BOX.. all other names branch from this -->
   <!-- BEGIN CONTENT BOX DEFAULT CENTER UI -->
    	<div id="defaultSideBarUIContentBoxTop"> <!-- RENAME THIS TO REFLECT THE BOX -->
        	<div class="topLeft"></div>
        	<div class="top"></div>
        	<div class="topRight"></div>
            <div class="errSpace">&nbsp;</div>
            <div class="left"></div>
            <div class="right"></div>               
        </div>
        <div id="defaultSideBarUIContentBoxMiddle"> <!-- RENAME THIS TO REFLECT BOX -->
            <div class="left"></div>
            <div id="defaultSideBarUIContent"> <!-- RENAME THIS TO REFLECT BOX AS WELL -->
            <!-- DEFAULT FOLDER UI CONTENT START -->
                 <div id="ContentA"> <!-- WHERE THE FOLDER LIST WILL GO -->
				      <tiles:get name="folderList"/>
						 <p align="center">
						  <html:link forward="folderManage" titleKey="link.manageFolder.title"><bean:message key="link.manageFolder.label"/></html:link>
						 </p>
                 </div>
                 
                 <div id="ContentB"> <!-- WHERE THE SPACE INFO WILL GO -->
                 <% //TODO: Fix this.
					try {
					//java.lang.reflect.Method quotaMethod = com.sun.mail.imap.IMAPFolder.class.getMethod("getQuota", null);
					java.lang.reflect.Method quotaMethod = request.getAttribute("folder").getClass().getMethod("getQuota", null);

					%>
							<hr align="center" width="90%">
							<tiles:get name="emptyTrash"/>
							<tiles:get name="folderQuota"/>
							<tiles:get name="emptyFolder"/>
					<%
					} catch (NoSuchMethodException nsme) {
					// do nothing
					}
					%>
                 </div>
                 <div id="ContentC">
                 
                 </div>
      		<!-- DEFAULT FOLDER UI CONTENT STOP -->		
            <!-- BEGIN FOR IE -->
    		<div class="clear">&nbsp;</div> 
    		<!-- END FOR IE -->
            </div>
            <div class="right"></div> 
        </div>
			<div class="defaultSideBarUIContentBoxBottom"> <!-- RENAME THIS TO REFLECT BOX -->
        	<div class="bottomLeft"></div>
        	<div class="bottom">&nbsp;</div>
        	<div class="bottomRight"></div>
			</div>
    <!-- END CONTENT BOX LOGIN UI -->
    </div>
    
 
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
                 <table cellpadding="0" cellspacing="0" width="100%">
					  <tr>
					   <td>
						<tiles:get name="results"/>
					   </td>
					  </tr>

					  <tr>
					   <td>
						<tiles:get name="messageListHeader"/>
					   </td>
					  </tr>

					  <tr>
					   <td>
						<tiles:get name="messageListView"/>
					   </td>
					  </tr>

					  <tr>
					   <td valign="top">
						<tiles:get name="messageList"/>
					   </td>
					  </tr>
					 </table>
					</td>
				   </tr>
				  </table>
      		<!-- DEFAULT FOLDER UI CONTENT STOP -->		
            <!-- BEGIN FOR IE -->
    		<div class="clear">&nbsp;</div> 
    		<!-- END FOR IE -->
            </div>
            <div class="right"></div> 
        </div>
        <div class="defaultCenterUIContentBoxBottom"> <!-- RENAME THIS TO REFLECT BOX -->
        	<div class="bottomLeft"></div>
        	<div class="bottom">Test</div>
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
