<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%
User loggedUser = DBUserUtils.getUserByUsername(session.getAttribute("loggedUserUsername").toString()); 
List<PrivateMessage> receivedMessages = DBUtils.displayIncomingMessages(loggedUser);
				int countUnread = 0;
				for (PrivateMessage myMessage : receivedMessages) {
					if (myMessage.getIsRead() == 0) {
						countUnread++;
					}
				}
%>
<span><%=countUnread%></span>