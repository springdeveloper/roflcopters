/*
 * This file is part of GatorMail, a servlet based webmail.
 * Copyright (C) 2002, 2003 William A. McArthur, Jr.
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

import edu.ufl.osg.webmail.User;
import edu.ufl.osg.webmail.Constants;
import edu.ufl.osg.webmail.prefs.PreferencesProvider;
import edu.ufl.osg.webmail.forms.ComposeForm;
import edu.ufl.osg.webmail.util.Util;
import edu.ufl.osg.webmail.data.AttachList;
import edu.ufl.osg.webmail.data.AttachObj;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.commons.beanutils.PropertyUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.mail.Message;
import javax.mail.Folder;
import javax.mail.Address;
import javax.mail.Part;
import javax.mail.Multipart;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.Flags;

import java.io.ByteArrayOutputStream;
import java.io.ObjectOutputStream;

/**
 * Set up the view for the compose page.
 *
 * @author sandymac
 * @author drakee
 * @version $Revision: 1.2 $
 */
public class ComposeAction extends Action {
    private static final Logger logger = Logger.getLogger(ComposeAction.class.getName());

    /**
     * Composes an email. This is the first page view of a "compose message"
     * session, and we don't return to this action until after the user has left
     * or sent the message.
     *
     * @param     mapping             The ActionMapping used to select this
     *                                instance
     * @param     form                The optional ActionForm bean for this
     *                                request (if any)
     * @param     request             The HTTP request we are processing
     * @param     response            The HTTP response we are creating
     * @return                        The "success" <code>ActionForward</code>.
     * @exception Exception if the application business
     *                                logic throws an exception
     */
    public ActionForward execute(final ActionMapping mapping, final ActionForm form, final HttpServletRequest request, final HttpServletResponse response) throws Exception {
        logger.debug("=== ComposeAction.execute() begin ===");
        ActionsUtil.checkSession(request);

        final Long uid = (Long)PropertyUtils.getSimpleProperty(form, "uid");
        final HttpSession session = request.getSession();
        final ComposeForm compForm = (ComposeForm)form;
        final User user = Util.getUser(session);
        final String composeKey = Util.generateComposeKey( session );
        logger.info("compose key = " + composeKey);

        // If form has UID, we are editing a draft message
        if( uid != null ) {
            Folder folder = ActionsUtil.fetchFolder( form, request );
            try {
                // get message from draft folder
                Message message = ActionsUtil.fetchMessage( form, folder );
                
                // populate form fields from draft message
                compForm.setSubject( message.getSubject() );

                Address[] to = message.getRecipients( Message.RecipientType.TO );
                Address[] cc = message.getRecipients( Message.RecipientType.CC );
                Address[] bcc = message.getRecipients( Message.RecipientType.BCC );

                String toStr = "";
                if( to != null )
                    for( Address adr : to ) toStr += adr.toString() + ",";

                String ccStr = "";
                if( cc != null )
                    for( Address adr : cc ) ccStr += adr.toString() + ",";

                String bccStr = "";
                if( cc != null )
                    for( Address adr : bcc ) bccStr += adr.toString() + ",";

                compForm.setTo( toStr );
                compForm.setCc( ccStr );
                compForm.setBcc( bccStr );

                // messages have the following topology
                //              multipart (content)
                //                  |
                //      -----------------------------
                //      |                           |
                //  alternativeMultipart         attachments (if any)
                //  |                  |
                // text               html
                MimeMultipart content = (MimeMultipart)message.getContent();
                MimeMultipart alternative = (MimeMultipart)content.getBodyPart(0).getContent();
                // html message part
                compForm.setBody( (String)alternative.getBodyPart(1).getContent() );
                compForm.setComposeKey( Util.generateComposeKey(session) );

                // deal with attachments if any
                if( content != null && content.getCount() > 1 ) {
                    final Integer messageNumber = compForm.getMessageNumber();
                    AttachList attachList = Util.getAttachList(composeKey, session);
                    for( int i = 1; i < content.getCount(); ++i ) 
                    {
                        MimeBodyPart part = ((MimeBodyPart)content.getBodyPart( i ));
                        AttachObj attachObj = new AttachObj( part, true );
                        attachList.addAttachment( attachObj, attachObj.getObjData() );
                        logger.info( "added " + part.getContentType() + " attachment to attachlist");
                    }
                }
                
                // delete message from draft folder
                message.setFlag( Flags.Flag.DELETED, true );
                folder.expunge();
                ActionsUtil.flushMailStoreGroupCache( session );
            } finally {
                Util.releaseFolder( folder );
            }
        } 
        // otherwise, set up blank message
        else {
            // requirement 6: web protocol handler. requires the url
            // to be .../compose.do?extsrc=mailto&url=%s
            if ((request.getParameter("extsrc") != null)
                && (request.getParameter("extsrc").equals("mailto")))
            {
                logger.debug("handling mailto protocol handler");
                String protocolurl =  request.getParameter("url");
                if (protocolurl != null) {
                    // HACKFIXME. for some reason, mailto's with
                    // spaces get encoded as "%2520" instead of "%20",
                    // so after translation, there's a "%20" in our
                    // string. This turns them into spaces.
                    logger.debug("url: " + protocolurl);
                    protocolurl = protocolurl.replaceAll("%20", " ");
                    logger.debug("url AFTER HACK: " + protocolurl);
                    String address = protocolurl.replaceAll("^mailto:([\\.\\w]+@[\\.\\w]*).*$", "$1");
                    String subject = protocolurl.replaceAll("^mailto:.*\\?subject=(.*)$", "$1");
                    logger.warn("address, subject: " + address + " " + subject);
                    compForm.setTo(address);
                    // only set subject if was able to parse one out
                    // of protocolurl
                    if (!protocolurl.equals(subject))
                        compForm.setSubject(subject);
                } else {
                    logger.warn("extscr set to mailto, but no url!");
                }
            }

            // add signature to blank message body
            final PreferencesProvider pp = (PreferencesProvider)getServlet().getServletContext().getAttribute(Constants.PREFERENCES_PROVIDER);
            compForm.setBody("<br /><br />" + pp.getPreferences(user, session).getProperty("compose.signature"));

            // generate unique compose key for this view
            compForm.setComposeKey(Util.generateComposeKey(session));

            // Default CopyToSent to true.
            compForm.setCopyToSent(true);
        }

        logger.debug("=== ComposeAction.execute() end ===");
        return mapping.findForward("success");
    }

}
