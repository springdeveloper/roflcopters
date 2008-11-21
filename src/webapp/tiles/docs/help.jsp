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
		This error indicates that GatorMail couldn't find your
		entry in the <html:link href="http://phonebook.ufl.edu/">UF Directory</html:link>.
		GatorMail uses the directory to get your display
		name and your UF ID, which it uses internally.
		</p>
		<p>
		People commonly get this error if they have very
		recently registered into the GatorLink system. The UF
		Directory pulls information from the registration
		database overnight, so if you have registered earlier
		in the day, please try logging onto GatorMail the next
		morning.
		</p>
		<p>
		Also, it is possible that this error represents a transient lookup
		glitch. You may be able to log in successfully after waiting a
		short while. However, if you keep getting this error, and you know
		you have a UF Directory entry, please report the problem
		to the Help Desk at (352)392-HELP
		or <html:link href="mailto:helpdesk@ufl.edu">helpdesk@ufl.edu</html:link>.
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
		GatorMail already supports this via your web browser's "Open in New Window"
		feature. When you "right click" on the compose or reply to links a pop up menu
		with a choice similar to "Open in New Window" should be available. When you
		choose this you will be able to compose a message in one window and read or
		other activities in another window.
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
		You need to click the "<bean:message key="compose.copyToSent"/>" check box
		next the "<bean:message key="button.send"/>" button.
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
		Your name is retrieved from UF's directory server. We use the "Display Name"
		field for both your signature and your name as it appears in the
		<code>From:</code> field of emails. To change your directory information,
		please visit UF's
		<html:link href="http://directory.ufl.edu/edit">directory editing site</html:link>.
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
		GatorMail currently does not support paginating the list of messages when
		viewing a folder. This feature is on our short list of features to implement.
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
		GatorMail uses the <html:link href="http://www-camis.stanford.edu/projects/imap/ml/imap.html">IMAP</html:link>
		protocol to interact with the Gatorlink mail server. In IMAP, a
		folder may be marked subscribed or unsubscribed, and mail clients
		may treat each type of folder differently. GatorMail allows you to
		set the subscribed status of your folders, and will ignore (not
		display) unsubscribed folders, except in the "Manage Folders" page.
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
		It is very likely that you need to mark these folders as
		"Subscribed". Here is how to do this:
		</p>
		<p>
		Click on the <html:link forward="folderManage">Manage
		Folders</html:link> link on the menu bar. From here you can see the
		subscription status of each of your folders. If the "Subscribed"
		column is marked "N", click the folder's "Modify Folder" link, and
		then press the "Subscribe Folder" button on the next page.
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
		If you still have questions, or would like to report a problem, use the
		<html:link forward="feedback">Send Feedback</html:link> at the top of most
		pages or you can ask for support at
        <html:link href="http://GatorMail.sf.net/support">http://GatorMail.sf.net/support</html:link>.
		<html:link href="#top">[<bean:message key="help.top"/>]</html:link>
	    </td>
	  </tr>
        </table>
    </td>
  </tr>
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
