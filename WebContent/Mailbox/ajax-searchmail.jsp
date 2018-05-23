<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>
<%
User loggedUser = DBUserUtils.getUserByUsername(session.getAttribute("loggedUserUsername").toString()); 
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
			<td>FROM</td>
			<td>TO</td>
			<td>MESSAGE</td>
			<td class="view-message  text-right">DATE & TIME</td>
		</tr>
		<%
			List<PrivateMessage> sentMessages = DBUtils.getAllMessagesByUser(loggedUser);
			PrivateMessage myMessage;
			String from;
			String to;
			String message;
			Timestamp date;
			int id;
			int count=0;
			for (int i = 0; i < sentMessages.size(); i++) {
				myMessage = sentMessages.get(i);
				from = myMessage.getSender().getUsername();
				to = myMessage.getReceiver().getUsername();
				message = myMessage.getMessageData();
				date = myMessage.getDateSubmission();
				id = myMessage.getPrivateMessageID();
				if ((myMessage.getReceiver().getUsername().contains(request.getParameter("filterTerm"))) || ((myMessage.getSender().getUsername().contains(request.getParameter("filterTerm"))))){
					count++;
					if ((myMessage.getIsRead() == 0) && (to.equals(loggedUser.getUsername()))) {
		%>
						<tr class="unread" id="<%=id%>">
		<%
					}else{
		%>
						<tr class="readInb">
		<%
					}
		%>			
						<td class="inbox-small-cells"><input type="checkbox"
							class="mail-checkbox mail-filtered" name="CF" value="<%=id%>"></td>
						<td class="view-message  dont-show"
		<%					
							if (to.equals(loggedUser.getUsername())){
							%>onclick="openInboxMessage('<%=from%>','<%=message%>','<%=date%>', <%=id%>, <%=myMessage.getIsRead()%>)"<%
							}
							else{
							%>onclick="openSentMessage('<%=to%>','<%=message%>','<%=date%>', <%=id%>, 0)"<%
							}
		%>
						>
						<%=from%>
						</td>
						<td class="view-message  dont-show"
		<%					
							if (to.equals(loggedUser.getUsername())){
							%>onclick="openInboxMessage('<%=from%>','<%=message%>','<%=date%>', <%=id%>, <%=myMessage.getIsRead()%>)"<%
							}
							else{
							%>onclick="openSentMessage('<%=to%>','<%=message%>','<%=date%>', <%=id%>, 0)"<%
							}
		%>
						><%=to%></td>
						<td class="view-message  dont-show"
		<%					
							if (to.equals(loggedUser.getUsername())){
							%>onclick="openInboxMessage('<%=from%>','<%=message%>','<%=date%>', <%=id%>, <%=myMessage.getIsRead()%>)"<%
							}
							else{
							%>onclick="openSentMessage('<%=to%>','<%=message%>','<%=date%>', <%=id%>, 0)"<%
							}
		%>
						><%=trimMessage(message)%></td>
						<td class="view-message  dont-show text-right"
		<%					
							if (to.equals(loggedUser.getUsername())){
							%>onclick="openInboxMessage('<%=from%>','<%=message%>','<%=date%>', <%=id%>, <%=myMessage.getIsRead()%>)"<%
							}
							else{
							%>onclick="openSentMessage('<%=to%>','<%=message%>','<%=date%>', <%=id%>, 0)"<%
							}
		%>
						><%=date%></td>
					</tr>

		<%
				}
			}
		%>
	</tbody>
</table>
<%
if (count==0){
	
%>
	<h3 style="text-align: center">No messages found from or to that user! -Sniff, sniff- :-(</h3>
<%
}
%>