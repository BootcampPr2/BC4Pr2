<%@ page import="pr2.loseweight.utils.*" %>
<%@ page import="org.hibernate.SessionFactory"%>

<%
HttpSession httpSession = request.getSession();
DBUtils.setRead((SessionFactory)httpSession.getAttribute("sessionFactory"), Integer.parseInt(request.getParameter("messageID")));
%>
