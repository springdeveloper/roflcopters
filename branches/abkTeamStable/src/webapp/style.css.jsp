<%@page contentType="text/css" session="false"%>
<%@taglib uri="/tags/struts-html" prefix="html"%>
<%--
May be useful: http://www.infinitespaces.com/bmah/

TODO: This is a mess. Could split this into a few files or just clean it all up.
    Also finish the docs in the jsp comment below.
--%>

body {
    height:768px;
	width:800px;
	background-image:url(cssImg/webmail-v2-bg0_01.png);
	background-repeat:repeat-x;
	background-attachment:scroll;
	overflow:auto;
    font-weight: normal;
    font-family: Arial, Helvetica, sans-serif;
<%  // This is so IE doesn't get horizontal scroll bars in the compose view.
    String us = request.getHeader("User-Agent").toLowerCase();
    if (us.indexOf("msie") != -1) {
%>
    margin : 0px;
    padding : 0px;
<%
    }
%>
}

/* START MASTER CONTENT */
#bg1{
	position:fixed;
	top:0px;
	left:0px;
	background-image:url(cssImg/webmail-v2-bg1_03.png);
	width:100%;
	height:141px;
	z-index:1;
	
}
#bg2{
	position:fixed;
	top:105px;
	left:0px;
	width:100%;
	height:47px;
	background-image:url(cssImg/webmail-v2-grayBar_06.png);
	background-repeat:repeat-x;
	z-index:3;
	
}
#webmailLogo{
	position:fixed;
	top:50px;
	left:5px;
	width:290px;
	height:57px;
	z-index:1;
}
#nav{
	position:fixed;
	white-space: nowrap;
	font-family: Arial;
	top:110px;
	left: 5px;
	width:100%;
	z-index:4;
}
a #nav {
}

#headerImg{
	position: fixed;
	margin-left: 85%;
	top:50;
	z-index:4;
}

#headerName{
	position: fixed;
	margin-left: 85%;
	top:85;
	z-index:4;
}

.clearBottom {
	font-size:1px;
	height:1px;
}



/* END MASTER CONTENT */

/* START LOGIN CONTENT */


#loginUI{
	position:absolute;
	top:120px;
	left:20%;
	right:35%;
	width:600px;
	z-index:0;
	font-family:Verdana, Arial, Helvetica, sans-serif;
}
#loginUIContentBoxMiddle{
	position:relative;
	margin-top:0px;
	min-height:200px;
	width:100%;
	padding-top:10px;
	float:left;
}
#loginUIContent{
	width:580px;
	margin-left:10px;
	background-color:#FFFFFF;
	text-align:center;
}

#webmailTan{
	position:relative;
	top:20px;
	left:90px;
	right:100px;
	width:400px;
	height:270px;
}

#loginUIForm{
	position:relative;
	padding:30px 10px 10px 10px;
	font-size:14px;
}

#loginUIFooter{
	position:relative;
	font-size:10px;
	text-align:center;
	line-height:3px;
}

#loginFooter{
	position:absolute;
	top:750px;
	left:34%;
	right:40%;
	text-align:center;
	font-size:9px;
	font-family:Verdana, Arial, Helvetica, sans-serif;
	width:300px;
}


/* END LOGIN CONTENT */

.topNavBar {
    margin : 0px;
    padding : 0px;
    font-size: 11px;
    font-weight: bold;
}

.leftNavBar {
    background-color: #e6e6e6;
    font-size: 11px;
    font-weight: bold;
}

a:link {
    font-family: Arial, Helvetica, sans-serif;
    color: #0021a5;
}

a:visited {
    font-family: Arial, Helvetica, sans-serif;
    color: #ff4a00;
}

/* Page header */
.header .version { /* Version text next to the logo */
    font-family: Arial, Helvetica, sans-serif;
    font-size: 18px;
    color: #CCCCCC;
}

.header .loggedInAs {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 11px;
	font-weight: bold;
    color: #CCCCCC;
}

.header .username {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 14px;
}


.topNav { /* The text across the nav bar*/
    font-family: Arial, Helvetica, sans-serif;
    font-size: 13px;
    font-weight: bold;
    color: #0021a5;
}

/* Copyright text at bottom of pages */
.copyright {
   text-align:center;
   color:#666666;
}

.footer {
    color: #666666;
    font-size: 11px;
    font-weight: normal;
}
/* START Content Box Necessary */
.topLeft{
	position:relative;
	top:0px;
	left:0px;
	width:10px;
	height:15px;
	background-image:url(cssImg/webmail-v2-topLeftCorner_06.png);
	z-index:1;
}
.top{
	position:absolute;
	top:0px;
	left:10px;
	right:15px;
	height:10px;
	background-image:url(cssImg/webmail-v2-topContent_08.png);
	background-repeat:repeat-x;
	z-index:1;
}
.topRight{
	position:absolute;
	top:0px;
	right:0px;
	width:15px;
	height:15px;
	background-image:url(cssImg/webmail-v2-topRightCorner_10.png);
	z-index:1;
}
.bottomLeft{
	position:absolute;
	bottom:0px;
	left:0px;
	width:10px;
	height:18px;
	background-image:url(cssImg/webmail-v2-bottomLeftCorner_28.png);
	z-index:1;
}
.bottom{
	position:absolute;
	bottom:0px;
	left:10px;
	right:15px;
	height:18px;
	background-image:url(cssImg/webmail-v2-bottom_29.png);
	background-repeat:repeat-x;
	z-index:1;
}
.bottomRight{
	position:absolute;
	bottom:0px;
	right:0px;
	width:15px;
	height:18px;
	background-image:url(cssImg/webmail-v2-bottomRightCorner_28.png);
	z-index:1;
}
.left{
	position:absolute;
	left:0px;
	top:15px;
	bottom:18px;
	width:10px;
	background-image:url(cssImg/webmail-v2-left_09.png);
	background-repeat:repeat-y;
	z-index:1;
}
.right{
	position:absolute;
	top:15px;
	right:0px;
	bottom:18px;
	width:15px;
	background-image:url(cssImg/webmail-v2-right_20.png);
	background-repeat:repeat-y;
	z-index:1;
}
.errSpace{
	position:absolute;
	top:5px;
	background-color:#FFF;
	left:10px;
	right:12px;
}
/* END CONTENT BOX NECESSARY */

/* START LOGIN CONTENT */
#statusIconUI{
	position:fixed;
	top:50px;
	left:750px;
	width:260px;
	height:83px;
	background-image:url(cssImg/webmail-v2-loggedIn_06.png);
	z-index:1;
}

#defaultContainer{
	position:relative;
	top:0px;
	left:200px;
	right:30%;
	width:600px;
	height:100%;
	z-index:0;
}
#defaultComposeContainer{
	position:relative;
	top:0px;
	left:60px;
	right:30%;
	width:600px;
	height:100%;
	z-index:0;
}
#defaultCenterUI{
	position:absolute;
	top:120px;
	left:300px;
	right:60px;
	min-height:500px;
	min-width:500px;
	z-index:0;
}
#defaultCenterComposeUI{
	position:relative;
	top:120px;
	left:60px;
	right:60px;
	min-height:500px;
	min-width:500px;
	z-index:0;
}
#defaultCenterComposeUIContentBoxMiddle{
	position:relative;
	margin-top:0px;
	min-height:700px;
	width:100%;
	float:left;
	z-index:0;
}

#defaultCenterUIContent{
	margin-left:10px;
	margin-top:10px;
	margin-right:10px;
	padding-left: 2px;
	padding-right: 2px;
	min-height:500px;
	right:20px; /*  This needs to be 20 less than the original width */
	background-color:#FFFFFF;
}
#defaultCenterComposeUIContent{
	margin-left:10px;
	margin-top:10px;
	margin-right:10px;
	padding-left: 2px;
	padding-right: 2px;
	min-height:500px;
	right:20px; /*  This needs to be 20 less than the original width */
	background-color:#FFFFFF;
}
#defaultCenterComposeUIContent{
	margin-left:10px;
	margin-top:10px;
	margin-right:10px;
	padding-left: 2px;
	padding-right: 2px;
	min-height:500px;
	right:20px; /*  This needs to be 20 less than the original width */
	background-color:#FFFFFF;
}
#defaultSideBarUIContentBox{
	position:absolute;
	top:145px;
	left:30px;
	min-height:500px;
	width:225px;
	z-index:0;
}

#defaultFooterUI{
	position:absolute;
	left:30%;
	top:103%;
	text-align:center;
	font-size:10px;
	font-family:Verdana, Arial, Helvetica, sans-serif;
	float:left;
	z-index:5;
}
#Space{
	position:relative;
	width:50px;
	height:150px;
	clear:both;
}
#defaultSideBarUIContentBoxMiddle{
	position:relative;
	margin-top:0px;
	min-height:500px;
	width:100%;
	float:left;
	z-index:0;
}

#defaultSideBarUIContent{
	margin-left:10px;
	margin-top:10px;
	min-height:500px;
	width:200px;
	background-color:#FFFFFF;
}
/* END LOGIN CONTENT */



.button {
    border : outset 2px;
    padding : 1px 3px;
}

/* message displaying result of action */
font.result {
    color : green;
    font-weight : bolder;
}

font.warning {
    color : red;
}

.alert {
    color:red;
}

<%--
Available CSS classes:
    loginForm: loginErrors, {username,password}{Prompt,Input,Errors}, {submit,reset}Button
    messageList: message{New,NewSelected,Seen,SeenSelected}
    messageHeader:
--%>
/* error messages */
ul.errors {
    color: red;
}

li.error {
    font-weight: bolder;
}

font.error {
    color: red;
    font-weight: bolder;
}

/* login form */
table.loginForm {
    border-spacing: 15pt;
    empty-cells: hide;
}

td.submitButton, td.resetButton {
    text-align: center;
}


/* Common table properties */

.darkBlueRow {
    color : #FFFFFF;
    background-color : #0021a5;
    text-align : left;
    font-size : 14px;
    font-style : normal;
    font-weight : normal;
}

.darkBlueRow a { /* Make links on the dark blue be white so the user can see them. */
    color : #FFFFFF;
}

.lightBlueRow {
    color: #000000;
    background-color: #ccd3ed;
    font-size: 12px;
    font-weight: normal;
}

/* Folder Message Listings */
.folderMessageListHeader {
    color : #000000;
    background-color : #e6e6e6;
    text-align : left;
    font-size : 17px;
    font-weight : normal;
}

.messageUnread {
    background-color: #ffffff;
    font-size: 14px;
    font-style: normal;
    font-weight: 900;
}

.messageUnreadSelected {
    background-color: #ffffcc;
    font-size: 14px;
    font-style: normal;
    font-weight: 900;
}

.messageUnreadThreaded {
    background-color: #d8ffe4;
    font-size: 14px;
    font-style: normal;
    font-weight: 900;
}

.messageUnreadSelectedThreaded {
    background-color: #ebffd8;
    font-size: 14px;
    font-style: normal;
    font-weight: 900;
}


.messageSeen {
    background-color: #ffffff;
    color : #666666;
    font-size : 14px;
    font-weight : normal;
}

.messageSeenSelected {
    background-color: #ffffcc;
    color : #666666;
    font-size : 14px;
    font-weight : normal;
}

.messageSeenThreaded {
    background-color: #d8ffe4;
    color : #666666;
    font-size : 14px;
    font-weight : normal;
}

.messageSeenSelectedThreaded {
    background-color: #ebffd8;
    color : #666666;
    font-size : 14px;
    font-weight : normal;
}

.folderEmptyFolder {
    color : red;
    text-align : center;
    font-size : larger;
}

/* Folder List */

.folderListFolder { /* First level folders shouldn't be indented */

}

.folderListFolder .folderListFolder { /* Second+ level folders should be indented */
    padding-left : 20px;
}

/* Folder Quota */
.forceIENonStandardsCenter {
	width : 100%;
	border-width : 0;
	margin : 0;
	padding : 0;
	text-align : center;
}

.folderQuota {
    background-color : #fff;
    margin-left : auto;
    margin-right : auto;
    width : 146px;
    border : 2px solid black;
    padding : 0;
    text-align : center;
}

.folderQuotaTitle {
    color : #ffffff;
    background-color : #0021a5;
    font-size : 14px;
    font-style : normal;
    font-weight : normal;
    width : 100%;
}

.folderQuotaResource {
    margin : 7px 0;
    padding : 0;
}

.folderQuotaResourceTitle {
    font-size : 16px;
    font-weight : bold;
    color : #333333;
}

.folderQuotaResourceBar {
    margin : 1px 0;
    padding : 0;
    border : solid #000;
    border-width : 1px 0;
    height : 1em;
}

.folderQuotaResourceUsed {
    background-color : #ff9900;
    height : 1em;
    margin : 0;
    float : left;
}

.folderQuotaResourceFree {
    background-color : #ffeacc;
    height : 1em;
    margin : 0;
    float : right;
}

.folderQuotaMessage {
    color : #666666;
    text-align : center;
    font-size : 11px;
    font-weight : normal;
    padding : 0 5px;
}


.fromList, .recipientList {
    font-style : italic;
}

/* Compose view */
.composeHeaderTitle {
	font-size: 14px;
	font-weight: bold;
	color: #666666;
	background-color: #e6e6e6;
}


/* generic table with nice header */
.headerTable .header {
    color : #ffffff;
    background-color : #0021a5;
    text-align : left;
    font-size : 14px;
    font-style : normal;
    font-weight : normal;
}

.headerTable .subheader {
    color: #000000;
    background-color: #ccd3ed;
    font-size: 12px;
    font-weight: normal;
}

.headerTable tr {
    background-color: #ffffff;
}

.headerTable tr.altrow {
    background-color : #e6e6e6;
}

/* ========= Address Book ========== */
.addressBook .leftNavBar {
    text-align : right;
	font-size: 14px;
	font-weight: bold;
}

/* ========= Message view ========== */

/* message header */
.messageHeader th.leftNavBar , .messageBody th.leftNavBar{ /* A lot of values also come from .leftNavBar */
    color: #666666;
    text-align : right;
    font-size: 14px;
}

.messageNavBar {
    margin : 0px;
    padding : 0px;
    font-size: 11px;
    font-weight: bold;
}

.messageHeader .darkBlueRow { /* This is so the move/copy form is right aligned. */
    text-align : right;
}

.messageHeader td.lightBlueRow {
    background-color: #ccd3ed;
    font-size: 12px;
    font-weight: normal;
}

.XmessageHeader .darkBlueRow th {
    color : #FFFFFF;
    background-color : #0021a5;
    text-align : left;
    font-size : 14px;
    font-style : normal;
    font-weight : normal;
}

.messageHeader td {
    background-color: #ffffff;
}

.messageBody {
}

.messageBody td {
    padding : 5px;
}

.messageBody > div {
}

.messageMessageRfc822, .messageContentOther {
    margin-bottom : 1em;
}

/* Text plain inline forwarding colorization */
.messageInlineForwardBlock {
    padding-left : 5px;
}

<%
for (int i=1; i < 25; i+=3) {
    if (i > 3) {
        out.print(", ");
    }
    for (int j=0; j < i; j++) {
        out.print(".messageInlineForwardBlock ");
    }
}
%> {
    border-left : solid navy;
    color : navy;
}

<%
for (int i=2; i < 25; i+=3) {
    if (i > 3) {
        out.print(", ");
    }
    for (int j=0; j < i; j++) {
        out.print(".messageInlineForwardBlock ");
    }
}
%> {
    border-left : solid maroon;
    color : maroon;
}

<%
for (int i=3; i < 25; i+=3) {
    if (i > 3) {
        out.print(", ");
    }
    for (int j=0; j < i; j++) {
        out.print(".messageInlineForwardBlock ");
    }
}
%> {
    border-left : solid green;
    color : green;
}
