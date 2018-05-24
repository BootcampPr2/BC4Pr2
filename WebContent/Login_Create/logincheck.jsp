<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pr2.loseweight.utils.DBUserUtils"%>
<%@ page import="pr2.loseweight.utils.HibernateUtil"%>
<%@ page import="pr2.loseweight.dbtables.User"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%
	HttpSession httpSession = request.getSession();
	SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
	httpSession.setAttribute("sessionFactory",sessionFactory);
	boolean loginSuccessful = DBUserUtils.login((SessionFactory)httpSession.getAttribute("sessionFactory"), request.getParameter("username"), request.getParameter("password"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
</head>
<body>

	<%
		if (loginSuccessful) {
			User user = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), request.getParameter("username").toString());
			if (user.getIsBanned() != 1) {
				httpSession.setAttribute("loggedUserUsername", request.getParameter("username"));
				response.sendRedirect("../User_Profile/user_main.jsp");
			} else {
	%>
	<p>
		<script type="text/javascript">
			alert("Your account is banned.");
		</script>
	</p>
	<jsp:include page="login-create-menu.jsp"></jsp:include>
	<%
		}
		} else {
	%>
	<p>
		<script type="text/javascript">
			alert("Invalid Username or Password");
		</script>
	</p>
	<jsp:include page="login-create-menu.jsp"></jsp:include>
	<%
		}
	%>

</body>
</html>