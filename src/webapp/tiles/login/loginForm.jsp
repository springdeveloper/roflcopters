<%@page contentType="text/html" import="org.apache.struts.action.ActionErrors"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>

<table border="0" width="600" id="announcement">
    <tr>
        <td class="alertMessage" id="loginAlertMessage">
            <script type="text/javascript" src="alertMessage.js"></script>
            &nbsp;
        </td>
    </tr>
</table>
<%
String loginFocus = "username";
%>
<c:if test="${! empty loginForm}">
 <c:if test="${! empty loginForm.username}">
<%
  loginFocus = "password";
%>
 </c:if>
</c:if>
<html:errors property="<%= ActionErrors.GLOBAL_ERROR %>"/>
<html:form action="login" focus="<%= loginFocus %>">
<div id="loginUI"> <!-- THIS SHOULD BE THE NAME OF THE BOX.. all other names branch from this -->
       <!-- BEGIN CONTENT BOX DEFAULT CENTER UI -->
    	<div id="loginUIContentBoxTop"> <!-- RENAME THIS TO REFLECT THE BOX -->
        	<div class="topLeft"></div>
        	<div class="top"></div>
        	<div class="topRight"></div>
            <div class="errSpace">&nbsp;</div>
            <div class="left"></div>
            <div class="right"></div>               
        </div>
        <div id="loginUIContentBoxMiddle"> <!-- RENAME THIS TO REFLECT BOX -->
            <div class="left"></div>
			
            <div id="loginUIContent"> <!-- RENAME THIS TO REFLECT BOX AS WELL -->
            <!-- DEFAULT FOLDER UI CONTENT START -->
				
                <div id="webmailTan">
       	 			<html:img page="/webmail-tan.png" width="400" height="270" alt="Some Things Never Change..."/>                
				</div>
				
                <div id="loginUIForm">
                <!-- BEGIN LOGIN UI CONTENT -->
					<table border="0" width="600" id="announcement">
					    <tr>
					        <td class="alertMessage" id="loginAlertMessage">
					            <script type="text/javascript" src="alertMessage.js"></script>
					            &nbsp;
					        </td>
					    </tr>
					</table>
                    <table align="center">
                        <tr>
                            <td class="usernamePrompt"><bean:message key="prompt.username"/></td>
                            <td class="usernameInput"><html:text property="username" size="16" /></td>
                            <td class="usernameErrors"><html:errors property="username"/></td>
                        </tr>
                        <tr>
                            <td class="passwordPrompt"><bean:message key="prompt.password"/></td>
                            <td class="passwordInput"><html:password property="password" size="16" redisplay="false"/></td>
                            <td class="passwordErrors"><html:errors property="password"/></td>
                        </tr>
                        <tr>
                        <td><br /></td>
                        </tr>
                        <tr>
                            <td class="submitButton"><html:submit property="action" styleClass="button"> <bean:message key="button.login"/></html:submit></td>
                            <td class="resetButton"><html:reset property="action" styleClass="button"> <bean:message key="button.reset"/></html:reset></td>
                        </tr>
                    </table>
			</html:form>
           		 <!-- END LOGIN CONTENT -->
           		 </div>
            <!-- START LOGIN UI FOOTER -->
            <div id="loginUIFooter">
                <p>For up to date information about scams that are targeted at UF email users, click <a href="http://infosec.ufl.edu/blog/category/advisories/">here</a>.</p>
                <p>Check the <a href="http://open-systems.ufl.edu/status/">current status</a> of Gatorlink services, including Webmail.</p>
                <p>To submit a bug report or request a feature, click <a href="http://gatormail.sf.net/bugs">here</a>.</p>
            <!-- END LOGIN UI FOOTER -->
            </div>  
       
      		<!-- DEFAULT FOLDER UI CONTENT STOP -->		
            <!-- BEGIN FOR IE -->
    		<div class="clear">&nbsp;</div> 
    		<!-- END FOR IE -->
            </div>
            <div class="right"></div> 
        </div>
        <div class="loginUIContentBoxBottom"> <!-- RENAME THIS TO REFLECT BOX -->
        	<div class="bottomLeft"></div>
        	<div class="bottom"></div>
        	<div class="bottomRight"></div>
        </div>
    <!-- END CONTENT BOX LOGIN UI -->
    </div>

