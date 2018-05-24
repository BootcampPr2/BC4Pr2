<%@ page import="pr2.loseweight.utils.DeleteFromDB" %>
<%@ page import="org.hibernate.SessionFactory"%>
<%

HttpSession httpSession = request.getSession();

String checkedIdsString = request.getParameter("checked");
checkedIdsString = checkedIdsString.replace("\"","");
checkedIdsString = checkedIdsString.replace("[","");
checkedIdsString = checkedIdsString.replace("]","");
String[] checkedIds = checkedIdsString.split(",");
/* for (int i=0;i<checkedIds.length;i++){
	System.out.println(checkedIds[i]);
} */
DeleteFromDB.deleteSelectedMessages((SessionFactory)httpSession.getAttribute("sessionFactory"), checkedIds);
%>
