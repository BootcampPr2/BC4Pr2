package pr2.loseweight.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.SessionFactory;
import pr2.loseweight.utils.DBAdminUtils;



@WebServlet("/ServletGodModifyUser")
public class ServletGodModifyUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletGodModifyUser() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession httpSession = request.getSession();
		DBAdminUtils function = new DBAdminUtils();
		if (request.getParameter("SU") != null) {
			String[] idList = request.getParameterValues("SU");

			if (request.getParameter("assign") != null) {
				function.assignUnassignUser((SessionFactory)httpSession.getAttribute("sessionFactory"),idList);
			} else if (request.getParameter("ban") != null) {
				function.banUnbanUser((SessionFactory)httpSession.getAttribute("sessionFactory"),idList);
			} else if (request.getParameter("delete") != null) {
				function.deleteUser((SessionFactory)httpSession.getAttribute("sessionFactory"),idList);
			}
		}
	}

}
