<%@page contentType="text/html" import="javax.mail.Folder,
                                        edu.ufl.osg.webmail.util.Util,
                                        java.util.List,
                                        java.util.Arrays,
                                        java.util.Iterator,
                                        edu.ufl.osg.webmail.Constants"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%@taglib uri="/tags/struts-bean" prefix="bean"%>
<%@taglib uri="http://www.opensymphony.com/oscache" prefix="oscache"%>
<%
    Folder currentRootFolder = null;
    try {
        currentRootFolder = (Folder)request.getAttribute("currentRootFolder");
        if (currentRootFolder == null) {
            currentRootFolder = Util.getFolder(session, "INBOX");
        }
        currentRootFolder = Util.getFolder(currentRootFolder);
        request.setAttribute("currentRootFolder", currentRootFolder);
        final String fullName = currentRootFolder.getFullName();
%>
<oscache:cache key="<%= \"folderList.jsp#\" + ((Folder)request.getAttribute(\"folder\")).getFullName() + \"::\" + fullName %>" scope="session" time="300" groups="mailStore"> 
<%
    String imageName = "/";
    String messageID = "folder.label.";
	boolean hasLabel = true;
	
	if (currentRootFolder.getFullName().equals("INBOX")) {
        imageName += "inbox";
		messageID += "inbox";
    } else if (currentRootFolder.getFullName().equals(Constants.getSentFolderFullname(session))) {
        imageName += "sent";
		messageID += "sent";
    } else if (currentRootFolder.getFullName().equals(Constants.getTrashFolderFullname(session))) {
        imageName += "trash";
		messageID += "trash";
    } else if (currentRootFolder.getFullName().equals(Constants.getDraftFolderFullname(session))) { //Added by Robert
        //        imageName += "draft";
		imageName += "folder";
		messageID += "drafts";
	} else if (currentRootFolder.getFullName().equals(Constants.getJunkFolderFullname(session))) { //Added by Robert 
		//	 imageName += "junk";
		imageName += "junk";
		messageID += "junk";
    } else {
        imageName += "folder";
		hasLabel = false;
		messageID = currentRootFolder.getFullName(); //If this is a user created folder, we don't have a default string, so we fetch the folder name from the IMAP server. --Robert
    }
	
    // I'd rather do this by seeing if Folder objects are equal but that doesn't work. Fsck'ing JavaMail
    if (currentRootFolder.getFullName().equals(((Folder)request.getAttribute("folder")).getFullName())) {
        imageName += "-opened";
    } else {
        imageName += "-closed";
    }

    int unreadMessageCount = 0;
    if (currentRootFolder.isOpen()) {
        unreadMessageCount = currentRootFolder.getUnreadMessageCount();
        if (unreadMessageCount != 0) {
            imageName += "-unread";
        }
    }
    imageName += ".png";

%>

<div class="folderListFolder">
<%
    if (currentRootFolder.isSubscribed()) {
%>
  <html:link forward="folder" paramId="folder" paramName="currentRootFolder" paramProperty="fullName" title="<%= fullName %>">
   <html:img page="<%= imageName %>" alt="Folder:" border="0" align="absmiddle" hspace="5"/>
<%
	if(hasLabel == true){
%>  
  <bean:message key="<%= messageID %>"/>
<%
	} else {
%>
  <bean:write name="currentRootFolder" property="name"/>
<%
	}
    if (unreadMessageCount != 0) {
        out.print("(" + unreadMessageCount + ")");
    }
%>      
  </html:link>
<%
    } else if (Util.hasSubscribedSubfolder(currentRootFolder)) {
%>
  <span title="Unsubscribed Folder. Subscribe to this folder in Edit Folders.">
   <html:img page="<%= imageName %>" alt="Folder:" border="0" align="absmiddle" hspace="5"/>
<%
	if(hasLabel == true){
%>  
  <bean:message key="<%= messageID %>"/>
<%
	} else {
%>
  <bean:write name="currentRootFolder" property="name"/>
<%
	}
        if (unreadMessageCount != 0) {
            out.print("(" + unreadMessageCount + ")");
    }
%>
  </span>
<%
    }

    final List subFolderList;
    subFolderList = Arrays.asList(currentRootFolder.listSubscribed());
    Util.releaseFolder(currentRootFolder);

    final Iterator subFolderIterator = subFolderList.iterator();
    while (subFolderIterator.hasNext()) {
        final Folder f = (Folder)subFolderIterator.next();
        //f = Util.getFolder(session, f); // This is less efficent ... maybe not?
        request.setAttribute("currentRootFolder", f);

        // TODO Tiles doesn't work for some reason, should figure out why
%><jsp:include page="/tiles/folder/folderList.jsp" flush="true"/><%
        Util.releaseFolder(f);
    }
%>
</div>
<%
    request.removeAttribute("currentRootFolder");
%>
</oscache:cache>
<%
    } catch (Throwable t) {
        t.printStackTrace();
        throw t;
    } finally {
        if (currentRootFolder != null) {
            Util.releaseFolder(currentRootFolder);
        }
    }
%>
