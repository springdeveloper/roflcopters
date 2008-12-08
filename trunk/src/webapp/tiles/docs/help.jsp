<%@page contentType="text/html"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>

<table class="headerTable" cellspacing="0" cellpadding="0" width="100%">
  <tr class="header">
    <th><a name="top"><bean:message key="help.header"/></a></th>
  </tr>
  <tr>
    <td>
	<p>
	<bean:message key="help.intro"/>
	</p>
	<blockquote>
	<ul>
	  <li><html:link href="#gl"><bean:message key="help.question.gl"/></html:link>
	  </li>
	  <li>
	      <html:link href="#login"><bean:message key="help.question.login"/></html:link>
	  </li>
	  <li>
	      <html:link href="#noINBOX"><bean:message key="help.question.noINBOX"/></html:link>
	  </li>
	  <li>
	      <html:link href="#userInfoException"><bean:message key="help.question.userInfoException"/></html:link>
	  </li>
	  <li>
	      <html:link href="#composeNewWindow"><bean:message key="help.question.composeNewWindow"/></html:link>
	  </li>
	  <li>
	      <html:link href="#sentMail"><bean:message key="help.question.sentMail"/></html:link>
	  </li>
	  <li>
	      <html:link href="#displayName"><bean:message key="help.question.displayName"/></html:link>
	  </li>
	  <li>
	      <html:link href="#pagination"><bean:message key="help.question.pagination"/></html:link>
	  </li>
	  <li>
	      <html:link href="#subscribed"><bean:message key="help.question.subscribed"/></html:link>
	  </li>
	  <li>
	      <html:link href="#foldersDisapeared"><bean:message key="help.question.foldersDisapeared"/></html:link>
	  </li>
	  <li>
	      <html:link href="#open"><bean:message key="help.question.open"/></html:link>
	  </li>
	  <li>
	    <html:link href="#hotkeys">Are there any hotkeys in GatorMail?</html:link>
	  </li>
	</ul>
	</blockquote>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="gl"><bean:message key="help.question.gl"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
		<bean:message key="help.answer.gl"/>
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="login"><bean:message key="help.question.login"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
		<bean:message key="help.answer.login"/>
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="noINBOX"><bean:message key="help.question.noINBOX"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
		<p>
		<bean:message key="help.answer.noINBOX"/>
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
		</p>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  
  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
	      <a name="userInfoException"><bean:message key="help.question.userInfoException"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
		<p>
		<bean:message key="help.answer.userInfoException"/>
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
		</p>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="composeNewWindow"><bean:message key="help.question.composeNewWindow"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
	    <bean:message key="help.answer.composeNewWindow"/>
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="sentMail"><bean:message key="help.question.sentMail"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
	    <bean:message key="help.answer.sentMail"/>
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="displayName"><bean:message key="help.question.displayName"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
	    <bean:message key="help.answer.displayName"/>
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="pagination"><bean:message key="help.question.pagination"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
	    <bean:message key="help.answer.pagination"/>
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="subscribed"><bean:message key="help.question.subscribed"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
	    <bean:message key="help.answer.subscribed"/>
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="foldersDisapeared"><bean:message key="help.question.foldersDisapeared"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
		<p>
		<bean:message key="help.answer.foldersDisapeared"/>

		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
		</p>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  
  <%-- faq entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="open"><bean:message key="help.question.open"/></a>
	    </td>
	  </tr>
	  <tr>
	    <td>
	    <bean:message key="help.answer.open"/>
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  
  <%-- shortcuts entry --%>
  <tr>
    <td>
	<table class="headerTable" cellspacing="0" cellpadding="3" width="100%">
	  <tr class="subheader">
	    <td>
		<a name="hotkeys">Keyboard Shortcuts</a>
	    </td>
	  </tr>
	  <tr><td>&nbsp;</td></tr>
	    </table>
    </td>
  </tr>
	    
  <%-- Edit by Andy --%> 
	     
	    <font face="Arial, Helvetica, sans-serif" size="-1"><p>
	    <table width="90%" border="1" cellspacing="0" cellpadding="2">
	  <tr bgcolor="#c3d9ff">
		<th valign=middle align=center><font size=-1>Shortcut Key</font></th>
		<th valign=middle align=center><font size=-1>Definition</font></th>
		<th valign=middle align=center><font size=-1>Action</font></th>
	  </tr>
	  <tr>
		<th valign=middle align=center><font size=-1>Ctrl + Shift + c</font></th>
		<td valign=middle align=center nowrap><font size=-1>Compose</font></td>
		<td valign=top><font size=-1>Allows you to compose
		  a new message.</font></td>
	  </tr>
	  <tr>
		<th valign=middle align=center><font size=-1>Ctrl + Shift + h</font></th>
		<td valign=middle align=center nowrap><font size=-1>Home Page</font></td>
		<td valign=top><font size=-1>Returns back to the main page.</font></td>
	  </tr>
	  <tr>
		<th valign=middle align=center><font size=-1>Ctrl + Shift + p</font></th>
		<td valign=middle align=center nowrap><font size=-1>Preferences</font></td>
		<td valign=top><font size=-1>Allows you to access your preferences.</font></td>
	  </tr>
	  <tr>
		<th valign=middle align=center><font size=-1>Ctrl + Shift + a</font></th>
		<td valign=middle align=center nowrap><font size=-1>Address Book</font></td>
		<td valign=top><font size=-1>Allows you to access your address book.</font></td>
	  </tr>
	  <tr>
		<th valign=middle align=center><font size=-1>Ctrl + Shift + m</font></th>
		<td valign=middle align=center nowrap><font size=-1>Manager Folders</font></td>
		<td valign=top><font size=-1>Allows you to access your manage folders.</font></td>
	  </tr>
	  <tr>
		<th valign=middle align=center><font size=-1>Ctrl + Shift + l</font></th>
		<td valign=middle align=center nowrap><font size=-1>Logout</font></td>
		<td valign=top><font size=-1>Logout of the system.</font></td>
	  </tr>
	  <tr>
		<th valign=middle align=center><font size=-1>Ctrl + Shift + right arrow</font></th>
		<td valign=middle align=center nowrap><font size=-1>Next message</font></td>
		  <td valign=top><font size=-1>Moves your cursor to the
		  next message.
		  <font size="-2">(Only applicable in 'Message View.')</font></td>
	 </tr>
	 <tr>
		<th valign=middle align=center><font size=-1>Ctrl + Shift + left arrow</font></th>
		<td valign=middle align=center nowrap><font size=-1>Previous message</font></td>
		  <td valign=top><font size=-1>Moves your cursor to the
		  previous message. 
		  <font size="-2">(Only applicable in 'Message View.')</font></td>
	</tr>
	  <tr>
		<th valign=middle align=center><font size=-1>Ctrl + Shift + d</font></th>
		<td valign=middle align=center nowrap><font size=-1>Delete</font></td>
		<td valign=top><font size=-1>Allows you to deletea message.  
		  <font size="-2">(Only applicable in 'Message View.')</font></td>
	  </tr>
	  <tr>
		<th valign=middle align=center><font size=-1>Ctrl + Shift + r</font></th>
		<td valign=middle align=center nowrap><font size=-1>Reply</font></td>
		<td valign=top><font size=-1>Allows you to reply to
		  a message. 
		  <font size="-2">(Only applicable in 'Message View.')</font></td>
	  </tr>

	</table>
    </font>
	<html:link href="#top">[top]</html:link>
  <tr><td>&nbsp;</td></tr>
 </table>

<%--
<li>
 <a name="whyNewWebMail">
  Why did you write a new webmail? Why not just use <i>SomeOtherWebMail</i>?
 </a>

 <blockquote>
  <p>
   We tried to find a suitable webmail. UF has a larger than normal user base
   and whatever webmail package we use needs to be scalable and well written.
   We examined many packages in the summer of 2002 before the GatorMail project
   was written.
  </p>

  <p>
   On one rather popular software index a
   <html:link href="http://freshmeat.net/search/?q=webmail&section=projects">search for "webmail"</html:link>
   turns up 72 results. Have you ever thought why there are so many different
   webmail choices?
  </p>

  <p>
   The fact is most webmails out there just aren't very good in some aspect or
   another. For example many of you suggested that we use a product called
   SquirrelMail. If you look deeper than the surface of the product you'll see
   some huge performance problems which is a serious issue when you have as many
   users as UF does. Unfortunately SquirrelMail is PHP based and it is simply
   not possible to write an efficent webmail in PHP because it does not have
   good support of sessions.
  </p>

 </blockquote>
</li>
--%>

