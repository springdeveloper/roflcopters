<%@page contentType="text/html"%>
<%@taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>
<html:html locale="true" xhtml="true">
<head>
 <title>
  <bean:message key="site.title"/>
  <tiles:getAsString name="title"/>
 </title>
 <html:base/>
 <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
 <link rel="start" href="<html:rewrite forward="INBOX"/>" title="INBOX"/>
 <link rel="help" href="<html:rewrite forward="help"/>" title="GatorMail Help"/>
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
                 <table class="body" width="100%" cellspacing="0" cellpadding="0" border="0">
				  <tr>
				   <td>
					 <tiles:get name="results"/>
				   </td>
				  </tr>
				  <tr>
				   <td>
					 <tiles:get name="body"/>
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
        	<div class="bottom"></div>
        	<div class="bottomRight"></div>
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
    <!-- END CONTENT BOX LOGIN UI -->
    
    </div>
    
    <!-- BEGIN FOR IE -->
    <div class="clear">&nbsp;</div> 
    <!-- END FOR IE -->
      <div id="Space">
    &nbsp;
    </div>
    
    
    </div>
<!-- END CONTENT CONTAINER -->
</div> 
 	

</body>
</html:html>