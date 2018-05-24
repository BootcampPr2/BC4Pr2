<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%
HttpSession httpSession = request.getSession();
User loggedUser = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), session.getAttribute("loggedUserUsername").toString()); 
List<PrivateMessage> receivedMessages = DBUtils.displayIncomingMessages((SessionFactory)httpSession.getAttribute("sessionFactory"), loggedUser);
				int countUnread = 0;
				for (PrivateMessage myMessage : receivedMessages) {
					if (myMessage.getIsRead() == 0) {
						countUnread++;
					}
				}
%>
<span><%=countUnread%></span>