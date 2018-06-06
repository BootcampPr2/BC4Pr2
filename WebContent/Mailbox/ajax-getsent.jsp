<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>
<%
HttpSession httpSession = request.getSession();
User loggedUser = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), session.getAttribute("loggedUserUsername").toString()); 
%>
<%!public static String trimMessage(String myMessage) {
		final int limit = 60;
		myMessage = myMessage.replace("&nbsp;", " ");
		String newMessage;
		if (!myMessage.contains("<br>")) {
			if (myMessage.length() <= limit)
				return myMessage;
			else
				return myMessage.substring(0, limit) + "...";
		} else {
			int brFoundOn = myMessage.indexOf("<br>");
			if (brFoundOn > limit) {
				return myMessage.substring(0, limit) + "...";
			} else {
				return myMessage.substring(0, brFoundOn) + "...";
			}
		}
	}
%>

<table class="table table-inbox table-hover">
	<tbody>
		<tr class="readInb"
			style="font-weight: bold; background-color: #00A8B3; color: white">
			<td></td>
			<td>RECEIVER</td>
			<td>MESSAGE</td>
			<td class="view-message  text-right">DATE & TIME</td>
		</tr>
		<%
			List<PrivateMessage> sentMessages = DBUtils.displaySentMessages((SessionFactory)httpSession.getAttribute("sessionFactory"), loggedUser);
			PrivateMessage myMessage;
			SimpleDateFormat myFormat = new SimpleDateFormat ("dd/MM/yyyy HH:mm");
			for (int i = 0; i < sentMessages.size(); i++) {
				myMessage = sentMessages.get(i);
				String user = myMessage.getReceiver().getUsername();
				String message = myMessage.getMessageData();
				String messageReplaceQuotes = message.replace("&#39;","\\'");
				Timestamp date = myMessage.getDateSubmission();
				String formattedDate = myFormat.format(date);
				int id = myMessage.getPrivateMessageID();
		%>
				<tr class="readSent">
					<td class="inbox-small-cells"><input type="checkbox"
						class="mail-checkbox mail-sent" name="CS" value="<%=id%>"></td>
					<td class="view-message 1 dont-show"
						onclick="openSentMessage('<%=user%>','<%=messageReplaceQuotes%>','<%=formattedDate%>', <%=id%>)"><%=user%></td>
					<td class="view-message 1 messageStyle"
						onclick="openSentMessage('<%=user%>','<%=messageReplaceQuotes%>','<%=formattedDate%>', <%=id%>)"><%=trimMessage(message)%></td>
					<td class="view-message 1 text-right"
						onclick="openSentMessage('<%=user%>','<%=messageReplaceQuotes%>','<%=formattedDate%>', <%=id%>)"><%=formattedDate%></td>
				</tr>
		<%
			}
		%>

	</tbody>
</table>
<%
if (sentMessages.size()==0){
	
%>
	<h3 style="text-align: center">You have sent no messages yet!</h3>
<%
}
%>