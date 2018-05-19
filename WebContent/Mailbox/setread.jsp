<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="pr2.loseweight.utils.*"%>

<% 
DBUtils.setRead(Integer.parseInt(request.getParameter("messageID"))); %>
