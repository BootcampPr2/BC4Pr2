package pr2.loseweight.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.SessionFactory;

import pr2.loseweight.dbtables.PrivateMessage;
import pr2.loseweight.dbtables.User;
import pr2.loseweight.utils.DBUserUtils;
import pr2.loseweight.utils.DBUtils;

// Servlet that generates a txt file with all the messages of the user.
// Used when the "Download All Messages" button in mail.jsp is clicked.
// Allows the user to download all their messages.
@WebServlet("/ServletDisplayMessages")
public class ServletDisplayMessages extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletDisplayMessages() {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setHeader("Content-Disposition","attachment; filename=allmymessages.txt");
		response.setContentType("text/plain;charset=UTF-8");
		String username = request.getParameter("username");
		SessionFactory sessionFactory = (SessionFactory)request.getSession().getAttribute("sessionFactory");
		User myUser = DBUserUtils.getUserByUsername(sessionFactory, username);
		List<PrivateMessage> incoming = DBUtils.displayIncomingMessages(sessionFactory, myUser);
		List<PrivateMessage> sent = DBUtils.displaySentMessages(sessionFactory, myUser);
		PrintWriter out = response.getWriter();
		String allMessages = printAllMessages(incoming,sent);
		out.println(allMessages);
		out.close();
		response.getWriter().write(allMessages); 

	} // end doPost()

	// Generates a String with all the messages of the user (sent and received)
	protected String printAllMessages(List<PrivateMessage> incoming, List<PrivateMessage> sent) {
		String allMessages="";
		allMessages += ("****** ALL INCOMING MESSAGES ******\r\n");
		for (PrivateMessage currentMessage : incoming) {
			allMessages += "--------------------------------------------------------\r\n";
			allMessages += "Sender: " + currentMessage.getSender().getUsername() + "\r\n";
			allMessages += "Date Received: " + currentMessage.getDateSubmission() + "\r\n";
			String replacedMessage = currentMessage.getMessageData().replace("&nbsp;", " ");
			replacedMessage = replacedMessage.replace("<br>", "\r\n");
			allMessages += "Message:\r\n" + replacedMessage + "\r\n";
		}
		allMessages += "\r\n************************* END OF INCOMING MESSAGES *************************\r\n\r\n";
		allMessages += "****** ALL SENT MESSAGES ******\r\n";
		for (PrivateMessage currentMessage : sent) {
			allMessages += "--------------------------------------------------------\r\n";
			allMessages += "Receiver: " + currentMessage.getReceiver().getUsername() + "\r\n";
			allMessages += "Date Sent: " + currentMessage.getDateSubmission() + "\r\n";
			String replacedMessage = currentMessage.getMessageData().replace("&nbsp;", " ");
			replacedMessage = replacedMessage.replace("<br>", "\r\n");
			allMessages += "Message:\r\n" + replacedMessage + "\r\n";
		}
		allMessages += "\r\n************************* END OF SENT MESSAGES *************************\r\n\r\n";
		return allMessages;
	} // end printAllMessages()
} // end of class
