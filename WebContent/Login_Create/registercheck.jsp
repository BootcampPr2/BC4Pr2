<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%
	HttpSession httpSession = request.getSession();
	SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
	httpSession.setAttribute("sessionFactory",sessionFactory);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 T

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register</title>
</head>
<body onload="changeVisibility()">
	<%
	if (request.getParameter("username0") != "" 
			&& request.getParameter("password0") != null
			&& Double.parseDouble(request.getParameter("weight")) != 0
			&& Double.parseDouble(request.getParameter("height")) != 0
			&& Integer.parseInt(request.getParameter("age")) != 0 
			&& request.getParameter("RG") != null
			&& Integer.parseInt(request.getParameter("RE")) != 0) {
		String username = request.getParameter("username0");
		String password = request.getParameter("password0");
		double weight = Double.parseDouble(request.getParameter("weight"));
		double height = Double.parseDouble(request.getParameter("height"));
		int age = Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("RG");
		int exercise = Integer.parseInt(request.getParameter("RE"));
		User existingUser = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), username);
		if (existingUser != null) {
%>
	<jsp:include page="login-create-menu.jsp" flush="true">
		<jsp:param name="errorLog" value="Username is already taken!" />
		<jsp:param name="username0" value="<%=username %>" />
		<jsp:param name="weight" value="<%=weight %>" />
		<jsp:param name="height" value="<%=height %>" />
		<jsp:param name="age" value="<%=age %>" />
	</jsp:include>
	<%
	} else {
			String pattern = "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+$).{8,}";
			if (password.matches(pattern)) {
				DBUserUtils.registerUser((SessionFactory)httpSession.getAttribute("sessionFactory"), username, password, weight, height, age, gender, exercise);
				httpSession.setAttribute("loggedUserUsername",request.getParameter("username0"));
				response.sendRedirect("../User_Profile/user_main.jsp");
			}else {
				%>
	<jsp:include page="login-create-menu.jsp" flush="true">
		<jsp:param name="errorLog" value="Password is not fulfilling all the requirements!" />
		<jsp:param name="username0" value="<%=username %>" />
		<jsp:param name="weight" value="<%=weight %>" />
		<jsp:param name="height" value="<%=height %>" />
		<jsp:param name="age" value="<%=age %>" />
	</jsp:include>
	<%
			}

		}
	}
%>

</body>
</html>