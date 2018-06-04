package pr2.loseweight.servlets;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.SessionFactory;

import pr2.loseweight.dbtables.User;
import pr2.loseweight.utils.DBUserUtils;

// Servlet used to upload a profile picture
public class ServletUploadProfilePic extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	final long MAX_FILE_SIZE = 2 * 1024 * 1024;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		HttpSession httpSession = request.getSession();
		User loggedUser = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), httpSession.getAttribute("loggedUserUsername").toString());
		Boolean uploaded = false;
		if (isMultipart) {
			// Create a factory for disk-based file items
			FileItemFactory factory = new DiskFileItemFactory();

			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			
			// if max size is exceeded, process fails
			upload.setSizeMax(MAX_FILE_SIZE);
			try {
				// Parse the request
				List items = upload.parseRequest(request);
				Iterator iterator = items.iterator();
				while (iterator.hasNext()) {
					FileItem item = (FileItem) iterator.next();
					if (!item.isFormField()) {
							String fileExtension = FilenameUtils.getExtension(item.getName());
							// Using hashCode() to make sure that the final filename will depend on the user's username (which is unique)
							String fileName = Integer.toString(loggedUser.getUsername().hashCode()) + "." + fileExtension;    
							String root = getServletContext().getRealPath("/");
							File path = new File(root + "/Images/profilepics");
							if (!path.exists()) {
								boolean status = path.mkdirs();
							}
	
							File uploadedFile = new File(path + "/" + fileName);
							System.out.println(uploadedFile.getAbsolutePath());
							item.write(uploadedFile);
							DBUserUtils.updateProfilePic((SessionFactory)httpSession.getAttribute("sessionFactory"), loggedUser, "http://localhost:8080/BC4Pr2/" + "/Images/profilepics/" + fileName);						
							uploaded = true;
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		request.setAttribute("picUploaded", uploaded);
		RequestDispatcher rd;
		rd = getServletContext().getRequestDispatcher("/User_Profile/user_update.jsp");
		rd.forward(request, response);
	} // end doPost()
	
} // end of class

