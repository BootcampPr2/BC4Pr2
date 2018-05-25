package pr2.loseweight.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.SessionFactory;

import pr2.loseweight.dbtables.User;
import pr2.loseweight.utils.DBAdminUtils;
import pr2.loseweight.utils.DBUserUtils;



@WebServlet("/ServletModifyUser")
public class ServletModifyUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletModifyUser() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession httpSession = request.getSession();
		User loggedUser = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), httpSession.getAttribute("loggedUserUsername").toString());
		if (request.getParameter("SU") != null) {
			String[] idList = request.getParameterValues("SU");

			if (request.getParameter("assign") != null) {
				DBAdminUtils.assignUnassignUser((SessionFactory)httpSession.getAttribute("sessionFactory"),idList);
			} else if (request.getParameter("ban") != null) {
				DBAdminUtils.banUnbanUser((SessionFactory)httpSession.getAttribute("sessionFactory"),idList);
			} else if (request.getParameter("delete") != null) {
				DBAdminUtils.deleteUser((SessionFactory)httpSession.getAttribute("sessionFactory"),idList);
			}
		}
		
		if (loggedUser.getRole().getRoleID() == 1)
		    response.sendRedirect("../GodMenu/control-panel_godMenu_users.jsp"); 
		else
			response.sendRedirect("../GodMenu/control-panel_adminMenu_users.jsp"); 
	}

}
