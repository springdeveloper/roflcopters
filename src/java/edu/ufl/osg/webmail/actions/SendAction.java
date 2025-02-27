/*
 * This file is part of GatorMail, a servlet based webmail.
 * Copyright (C) 2002-2004 William A. McArthur, Jr.
 * Copyright (C) 2003 The Open Systems Group / University of Florida
 *
 * GatorMail is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * GatorMail is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GatorMail; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package edu.ufl.osg.webmail.actions;

import com.sun.mail.imap.IMAPFolder;
import edu.ufl.osg.webmail.Constants;
import edu.ufl.osg.webmail.User;
import edu.ufl.osg.webmail.prefs.PreferencesProvider;
import edu.ufl.osg.webmail.beans.ResultBean;
import edu.ufl.osg.webmail.data.AttachDAOException;
import edu.ufl.osg.webmail.data.AttachList;
import edu.ufl.osg.webmail.data.AttachObj;
import edu.ufl.osg.webmail.forms.ComposeForm;
import edu.ufl.osg.webmail.util.Util;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.mail.BodyPart;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Flags;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

/**
 * Performs the sending of a composed message.
 *
 * @author sandymac
 * @author drakee
 * @version $Revision: 1.6 $
 */
public class SendAction extends Action {
    private static final Logger logger = Logger.getLogger(SendAction.class.getName());
    // start looking to wrap composed message body a little before the limit
    // RFC2646 suggests line length of 66 characters
    private static final int WRAP_WIDTH = 66; //Constants.COMPOSE_BODY_WIDTH - 4;

    /**
     * Sends an email.
     *
     * @param     mapping             The ActionMapping used to select this
     *                                instance
     * @param     form                The optional ActionForm bean for this
     *                                request (if any)
     * @param     request             The HTTP request we are processing
     * @param     response            The HTTP response we are creating
     * @exception Exception if the application business
     *                                logic throws an exception
     */
    public ActionForward execute(final ActionMapping mapping, final ActionForm form, final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        logger.debug("=== SendAction.execute() begin ===");
        ActionsUtil.checkSession(request);

        final ActionErrors errors = new ActionErrors();
        final ComposeForm compForm = (ComposeForm)form;

        // "to" field validation. only perform if messaage is not a draft
        if (!compForm.getIsDraft() && (compForm.getTo() == null || compForm.getTo().trim().equals(""))) {
            errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.compose.to.required"));
            saveErrors(request, errors);
            compForm.setAttachment(null);
            return mapping.findForward("fail");
        }

        final HttpSession httpSession = request.getSession();
        final Session session = Util.getMailSession(httpSession);
        final String subject = compForm.getSubject();
        final String body = formatRfc2646(compForm.getBody());
        final String bodyplain = body.replaceAll("\\<.*?\\>", "");
        final String replyMessageID = compForm.getReplyMessageID();
        final String replyReferences = compForm.getReplyReferences();
        final User user = Util.getUser(httpSession);
        final PreferencesProvider pp = (PreferencesProvider)getServlet().getServletContext().getAttribute(Constants.PREFERENCES_PROVIDER);
        final Properties prefs = pp.getPreferences(user, httpSession);
        final boolean draft = compForm.getIsDraft();

        final InternetAddress[] to = parseAddresses(compForm.getTo(), errors);
        final InternetAddress[] cc = parseAddresses(compForm.getCc(), errors);
        final InternetAddress[] bcc = parseAddresses(compForm.getBcc(), errors);

        // get attachment list from memory
        final AttachList attachList = Util.getAttachList(compForm.getComposeKey(), httpSession);

        /* jli+marlies intelligent attachment reminder requirement
         * 4 part "and":
         * 1. global attachment reminder var set,
         * 2. hasn't already displayed attachment reminder
         * 3. no files attached
         * 4. string "attach" exists in body or subject
         *
         * FIXME: breaks for forwards, because the forwarded message is
         * an attachment.
         */
        final String remindPref = prefs.getProperty("compose.attachmentReminder");
        if ((remindPref != null)
            && remindPref.equals("true")
            && (!compForm.getIsDraft())
            && (!compForm.isAttachRemindShown())
            && (attachList.size() == 0)
            && (subjMentionsAttach(subject) || bodyMentionsAttach(body))) {
            errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.attachment.reminder"));
            saveErrors(request, errors);
            compForm.setAttachment(null);
            compForm.setAttachRemindShown(true);
            return mapping.findForward("fail");
        }

        if (!errors.isEmpty()) {
            saveErrors(request, errors);
            compForm.setAttachment(null);
            return mapping.findForward("fail");
        }

        final MimeMessage message = new MimeMessage(session);
        message.setFrom(getFromAddress(user, httpSession));
        message.setRecipients(RecipientType.TO, to);
        message.setRecipients(RecipientType.CC, cc);
        message.setRecipients(RecipientType.BCC, bcc);
        message.setSubject(subject);
        message.setSentDate(new Date());
        message.setHeader("X-Mailer", "ROFLified GatorMail WebMail (http://GatorMail.sf.net/)");
        message.setHeader("X-Originating-IP", request.getRemoteHost() + " [" + request.getRemoteAddr() + "]");

        logger.debug("reply's MessageID: " + replyMessageID);
        logger.debug("  equal to empty?: " + replyMessageID.trim().equals(""));
        logger.debug("reply's References: " + replyReferences);
        logger.debug("   equal to empty?: " + replyReferences.trim().equals(""));
        if ((replyMessageID != null) && !replyMessageID.trim().equals("")) {
            // set parent's Message-ID to In-Reply-To
            message.setHeader("In-Reply-To", replyMessageID);
            if ((replyReferences != null)
                && !replyReferences.trim().equals("")) {
                // set catenation of replyReferences, replyMessageID
                // to References
                message.setHeader("References", replyReferences +
                                  " " + replyMessageID);
            } else { // first reply, just set to parent's Message-ID
                message.setHeader("References", replyMessageID);
            }
        }

        final String replyTo = prefs.getProperty("compose.replyTo");
        if (replyTo != null) {
            final InternetAddress[] replyToAddr = parseAddresses(replyTo, errors);
            message.setReplyTo(replyToAddr);
        }

        final String imageUrl = prefs.getProperty("compose.X-Image-Url");
        if (imageUrl != null && imageUrl.length() > 0) {
            message.setHeader("X-Image-Url", imageUrl);
        }

        // create message content
        /* Patrick here.  Did away with single part messaging entirely.  Attachment handling is accomplished in the createMultipart method
        if (attachList.size() == 0) {
            logger.debug("no attachments");
            message.setContent(body, "text/html; format=flowed");
            //message.addHeader("Content-Type", "text/plain; format=flowed");
        } else {
            logger.debug("there are attachments: " + attachList);
                     */
            final Multipart multipart = createMultipart(bodyplain, body, attachList, httpSession);
            // put all the parts into message
            message.setContent(multipart);
            message.saveChanges();
   //     }

        logger.debug("message is " + (compForm.getIsDraft() ? "" : " not ") + "a draft");

        // check if message is a draft
        if( !compForm.getIsDraft() )
        {
            // if not a draft, do the sending
            Transport.send(message);
            logger.debug("successfully sent message");

            // is "copy to sent" checked?
            logger.debug("copyToSent value: " + compForm.isCopyToSent());
            if (compForm.isCopyToSent()) {
                logger.debug("copy message to Sent folder - start");
                final Folder sentFolder = Util.getFolder(httpSession, Constants.getSentFolderFullname(httpSession));
                message.setFlag(Flags.Flag.SEEN, true);
                ActionsUtil.flushMailStoreGroupCache(httpSession);
                if (!ActionsUtil.appendMessage(message, sentFolder, errors)) {
                    // error - go to special error page
                    saveErrors(request, errors);
                    Util.releaseFolder(sentFolder); // clean up
                    return mapping.findForward("errorCopyToSent");
                }
                Util.releaseFolder(sentFolder); // clean up
                logger.debug("copy message to Sent folder - end");
            }
            // success message for next page
            final ResultBean result = new ResultBean(Util.getFromBundle("send.result.success"));
            request.setAttribute(Constants.RESULT, result);
        } else {
            // othewise, copy to drafts folder
            final Folder draftFolder = Util.getFolder( httpSession, Constants.getDraftFolderFullname(httpSession) );
            message.setFlag( Flags.Flag.DRAFT, true );
            if( !ActionsUtil.appendMessage( message, draftFolder, errors )) {
                // error - go to draft error page
                saveErrors( request, errors );
                Util.releaseFolder( draftFolder );
                return mapping.findForward("fail");
            }
            Util.releaseFolder( draftFolder );
            final ResultBean result = new ResultBean( Util.getFromBundle("draft.result.success") );
            logger.debug("save draft success");
            Util.removeAttachList(compForm.getComposeKey(), httpSession);
            return mapping.findForward("draft");

        }


        // now that the message was sent successfully, get rid of attachments
        Util.removeAttachList(compForm.getComposeKey(), httpSession);

        logger.debug("=== SendAction.execute() end ===");
        return mapping.findForward("success");
    }

    // parses and validates a string of email addresses
    private static InternetAddress[] parseAddresses(final String addressLine, final ActionErrors errors) {
        InternetAddress[] addresses = null;
        try {
            addresses = InternetAddress.parse(addressLine);
            for (int i = 0; i < addresses.length; i++) {
                addresses[i].validate();
            }
        } catch (AddressException ae) {
            errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.address.invalid", addressLine));
        }
        return addresses;
    }

    // returns a MIME multipart
    private static Multipart createMultipart(final String bodyplain, final String body, final AttachList attachList, final HttpSession session) throws MessagingException, AttachDAOException {
    
        final Multipart multipart = new MimeMultipart("mixed");
    
        // create the alternative subpart
        final Multipart alternativeMultipart = new MimeMultipart("alternative");

        // create the plain message part
        final BodyPart messagePlainBodyPart = new MimeBodyPart();
        messagePlainBodyPart.setText(bodyplain);
        messagePlainBodyPart.setHeader("Content-Type", "text/plain; charset=UTF-8");
        alternativeMultipart.addBodyPart(messagePlainBodyPart);
        
        // create the HTML message part
        final BodyPart messageHTMLBodyPart = new MimeBodyPart();
        messageHTMLBodyPart.setText(body);
        messageHTMLBodyPart.setHeader("Content-Type", "text/html; charset=UTF-8");
        alternativeMultipart.addBodyPart(messageHTMLBodyPart);
        
        // start filling the super multipart message
        final BodyPart messageAlternativeSubBodyPart = new MimeBodyPart();
        messageAlternativeSubBodyPart.setContent(alternativeMultipart);
        multipart.addBodyPart(messageAlternativeSubBodyPart);

        // add alternative subparts for each attachment (if there are any)
        for (int i = 0; i < attachList.size(); i++) {
            final AttachObj attachObj = (AttachObj)attachList.get(i);
            if (attachObj.getIsForward()) {
                final String folderFullName = attachObj.getFolderFullName();
                final Folder folder = Util.getFolder(session, folderFullName);
                // Find the message
                final Message message;
                if (attachObj.getUid() != null) {
                    // UID to get message
                    final IMAPFolder imapFolder = (IMAPFolder)folder;
                    message = imapFolder.getMessageByUID(attachObj.getUid().longValue());
                } else {
                    // messageNumber to get message
                    message = folder.getMessage(attachObj.getMessageNumber().intValue());
                }
                final BodyPart fwdBodyPart = new MimeBodyPart();
                fwdBodyPart.setDataHandler(message.getDataHandler());
                // Add part to multi part
                multipart.addBodyPart(fwdBodyPart);
                break;
            }
        }

        // now for the attachment(s)
        final List bodyPartList = attachList.getMimeBodyPartList();
        final int size = bodyPartList.size();
        for (int i = 0; i < size; i++) {
            final MimeBodyPart attachBodyPart = (MimeBodyPart)bodyPartList.get(i);
            multipart.addBodyPart(attachBodyPart);
            logger.info("attached file: " + attachBodyPart.getFileName() + ", contentType: " + attachBodyPart.getContentType());
        }

        return multipart;
    }

    private InternetAddress getFromAddress(final User user, final HttpSession session) throws UnsupportedEncodingException {
        final PreferencesProvider pp = (PreferencesProvider)getServlet().getServletContext().getAttribute(Constants.PREFERENCES_PROVIDER);
        final Properties prefs = pp.getPreferences(user, session);

        return new InternetAddress(user.getEmail(), prefs.getProperty("user.name"));
    }

    /**
     * Formats a block of text so that it is <code>text/plain;
     * format=flowed</code> as described in RFC2646.
     *
     * @param  body                the block of text to wrap.
     * @return                     the rfc2646 form of <code>body</code>.
     * @throws IOException         Thrown from {@link
     *                             java.io.BufferedReader#readLine()}.
     */
    private static String formatRfc2646(final String body) throws IOException {
        final List lines = new ArrayList(body.length() / 40); // Guess
        final StringBuffer sb = new StringBuffer(body.length());
        final BufferedReader br = new BufferedReader(new StringReader(body));
        String line = null;

        // Build a list of lines.
        while ((line = br.readLine()) != null) {
            lines.add(line);
        }

        // Rewrap lines
        for (int i = 0, size = lines.size(); i < size; i++) {
            line = (String)lines.get(i);
            final int quoteDepth = countQuoteDepth(line);
            line = line.substring(quoteDepth);

            // Rewrap quoted blocks
            if (quoteDepth != 0) {
                line = unStuff(line);

                // Join flowed lines to this one
                String nextLine = (i + 1 < lines.size()) ? (String)lines.get(i + 1) : null;
                while (nextLine != null && isFlowed(line) && countQuoteDepth(nextLine) == quoteDepth) {
                    nextLine = nextLine.substring(countQuoteDepth(nextLine));
                    line += unStuff(nextLine);
                    i++;
                    nextLine = (i + 1 < lines.size()) ? (String)lines.get(i + 1) : null;
                }
            }

            line = makeHardBreak(line);
            
            // Preserve cut lines
            if (line.equals("--")) {
                line += " ";
            }

            while (line != null) {
                if (line.length() < WRAP_WIDTH) {
                    // Line doesn't need wrapping
                    while (isFlowed(line)) {
                        line = line.substring(0, line.length() - 1);
                    }
                    sb.append(makeQuoteDepth(quoteDepth)).append(line).append("\r\n");
                    line = null;

                } else {
                    // Line needs to be wrapped
                    final String lineChunk;
                    int breakPoint = Math.min(line.length() - 1, WRAP_WIDTH - quoteDepth);
                    while (breakPoint > 1 && line.charAt(breakPoint) != ' ') {
                        breakPoint--;
                    }
                    if (1 == breakPoint) {
                        breakPoint = Math.min(line.length(), WRAP_WIDTH - quoteDepth);
                        while (breakPoint < line.length() && line.charAt(breakPoint) != ' ') {
                            breakPoint++;
                        }
                    }
                    if (line.length() > breakPoint + 1) {
                        breakPoint++;
                    }
                    lineChunk = line.substring(0, breakPoint);
                    line = line.substring(breakPoint);

                    sb.append(makeQuoteDepth(quoteDepth)).append(lineChunk).append("\r\n");

                    if (line.length() == 0) {
                        line = null;
                    }
                }
            }
        }

        return sb.toString();
    }

    private static String makeQuoteDepth(final int quoteDepth) {
        if (quoteDepth == 0) {
            return "";
        }

        final StringBuffer sb = new StringBuffer();
        for (int i = 0; i < quoteDepth; i++) {
            sb.append('>');
        }

        return sb.append(" ").toString();
    }

    private static boolean shouldStuff(final String line) {
        if (line.length() < 1) {
            return false;
        }

        final char c = line.charAt(0);
        return c == '>' || c == ' ';
    }

    private static String makeHardBreak(final String line) {
        final StringBuffer sb = new StringBuffer(line);
        while (sb.length() != 0 && sb.charAt(sb.length() - 1) == ' ') {
            sb.setLength(sb.length() - 1);
        }
        return sb.toString();
    }

    /**
     * Does this line end with a soft line break.
     *
     * @param  line                a {@link String} to test if ends with a soft
     *                             line break.
     * @return                     true if <code>line</code> ends with a soft
     *                             line break, else false.
     */
    private static boolean isFlowed(final String line) {
        return line.endsWith(" ");
    }

    private static String unStuff(final String line) {
        if (line.length() > 0 && line.charAt(0) == ' ') {
            return line.substring(1);
        }
        return line;
    }

    /**
     * Counts the number of '&gt;' at the start of a line.
     *
     * @param  line                a string
     * @return                     the number of '&gt;' at the start of a line
     */
    private static int countQuoteDepth(final String line) {
        final int length = line.length();
        int depth;

        for (depth = 0; depth < length && line.charAt(depth) == '>'; depth++) ;

        return depth;
    }

    /**
     * Checks the body of the message for mention of attachments.
     *
     * @param body                a string
     * @return                    boolean: if attachments mentioned
     */
    private static boolean bodyMentionsAttach(final String body) {
        /* Either "attach" at beginning of a line, or in middle of a
         * line that doesn't start with ">" (so it doesn't match
         * quoted text). Need 2 for each case to take care of 1st line
         * edge case.
         *
         * The (?i)(?s), \r\n horribleness is because the regex needs
         * to match the *entire* string, not just a substring, and
         * multiline mode (?m) doesn't appear to help.
         *
         * With FCK, don't think "otherbegin" is ever true ("attach"
         * at the beginning of a line is preceded by "<p>". Still
         * caught by "othermid", and otherwise harmless, so leaving it
         * in.
         */
        boolean firstbegin = body.matches("(?i)(?s)^attach.*");
        boolean otherbegin = body.matches("(?i)(?s).*?\r\nattach.*");
        boolean firstmid = body.matches("(?i)(?s)^[^&gt;][.[^\r\n]]*attach.*");
        boolean othermid = body.matches("(?i)(?s).*?\r\n[^&gt;][.[^\r\n]]*attach.*");

        logger.debug("ATTACH body check.");
        logger.debug("very beginning: " + firstbegin);
        logger.debug("beginning ofline in middle: " + otherbegin);
        logger.debug("middle ofline on 1st line: " + firstmid);
        logger.debug("middle ofline in middle: " + othermid);

        return (firstbegin || otherbegin || firstmid || othermid);
    }

    /**
     * Checks the subject line for mention of attachments.
     *
     * @param subj                a string
     * @return                    boolean: if attachments mentioned
     */
    private static boolean subjMentionsAttach(final String subj) {
        /* subject has "attach" somewhere and does not start with
         * "Re: " or "Fw: " or "Fwd: " (doesn't match replies or
         * forwards). Not perfect.
         */
        final boolean b = subj.matches("(?i).*attach.*");
        final boolean bre = subj.matches("(?i)^Re: .*");
        final boolean bfwd = subj.matches("(?i)^Fw[d]: .*");
        logger.debug("ATTACH subj check.");
        logger.debug("in subj: " + b);
        logger.debug("no Re: " + !bre);
        logger.debug("no Fw[d]: " + !bfwd);
        return (b && !bre && !bfwd);
    }

}
