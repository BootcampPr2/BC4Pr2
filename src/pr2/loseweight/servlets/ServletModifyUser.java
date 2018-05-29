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


// Servlet called from the control panel of an admin (or god), used to change the Role of a user, ban them, or delete them
@WebServlet("/ServletModifyUser")
public class ServletModifyUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletModifyUser() {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession httpSession = request.getSession();
		User loggedUser = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), httpSession.getAttribute("loggedUserUsername").toString());
		
		// SU are the ticked checkboxes when selecting the users
		if (request.getParameter("SU") != null) {
			String[] idList = request.getParameterValues("SU");

			if (request.getParameter("assign") != null) {
				DBAdminUtils.toggleRole((SessionFactory)httpSession.getAttribute("sessionFactory"),idList);
			} else if (request.getParameter("ban") != null) {
				DBAdminUtils.toggleBanStatus((SessionFactory)httpSession.getAttribute("sessionFactory"),idList);
			} else if (request.getParameter("delete") != null) {
				DBAdminUtils.deleteUser((SessionFactory)httpSession.getAttribute("sessionFactory"),idList);
			}
		}
		
		// Depending on whether the user is god or an administrator, they are redirected to the appropriate page.
		if (loggedUser.getRole().getRoleID() == 1)
		    response.sendRedirect("../GodMenu/control-panel_godMenu_users.jsp"); 
		else
			response.sendRedirect("../GodMenu/control-panel_adminMenu_users.jsp"); 
	} // end doPost()

} // end of class
