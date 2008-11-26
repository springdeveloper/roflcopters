<%@page contentType="text/html"%>
<%@taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>

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
	<div id="nav">
   <tiles:get name="navBar.jsp"/>
   </div>
    </div>


