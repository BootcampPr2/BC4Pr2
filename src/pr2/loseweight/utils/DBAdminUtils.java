package pr2.loseweight.utils;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.query.Query;

import pr2.loseweight.dbtables.MetaRate;
import pr2.loseweight.dbtables.PrivateMessage;
import pr2.loseweight.dbtables.Role;
import pr2.loseweight.dbtables.User;

// class that contains methods to be used by Admins and God
public abstract class DBAdminUtils {

	// method that returns ALL private messages in the database (from all users)
	public static List<PrivateMessage> displayAllPrivateMessages(SessionFactory sessionFactory) {
		Session session = sessionFactory.openSession();
		String selectAllMessages = "From PrivateMessage order by dateSubmission DESC";
		Query query = session.createQuery(selectAllMessages);
		List<PrivateMessage> allMessages = query.getResultList();
		session.close();
		return allMessages;
	} //end displayAllPrivateMessages()

	// Toggles ban status. If user is banned, they get unbanned, and vice versa
	public static void toggleBanStatus(SessionFactory sessionFactory, String[] listOfIdsString) {
		Session session = sessionFactory.openSession();
		User user;
		int userID;
		// Notice that beginTransaction and commit can be outside the for loop
		session.beginTransaction();
		for (int i=0;i<listOfIdsString.length;i++) {
			userID = Integer.parseInt(listOfIdsString [i]);
			user = session.get(User.class, userID);
			if (user.getIsBanned() == 0) {
				user.setIsBanned(1);
			}else {
				user.setIsBanned(0);
			}
			session.update(user);
		}
		session.getTransaction().commit();
		session.close();
	} //end toggleBanStatus()

	// Toggles Role status between Administrator and Standard User. Can only be used by god. Admins cannot promote/demote others
	public static void toggleRole(SessionFactory sessionFactory, String[] listOfIdsString) {
		Session session = sessionFactory.openSession();
		int userID;
		User user;
		// Preparing objects with the two possible roles
		Role newRoleAdmin = session.get(Role.class, 2);
		Role newRoleStandardUser = session.get(Role.class, 3);
		session.beginTransaction();
		for (int i=0;i<listOfIdsString.length;i++) {
			userID = Integer.parseInt(listOfIdsString [i]);
			user = session.get(User.class, userID);
			if (user.getRole().getRoleID() == 3) {
				user.setRole(newRoleAdmin);
			}else {
				user.setRole(newRoleStandardUser);
			}
			session.update(user);
		}
		session.getTransaction().commit();
		session.close();
	} //end toggleRole()

	// Deletes all the selected users. Uses HQL statement
	public static void deleteUser(SessionFactory sessionFactory, String[] listOfIdsString) {
		List<Integer> listOfIdsInt = new ArrayList<Integer>();
		for (int i=0;i<listOfIdsString.length;i++) {
			listOfIdsInt.add(Integer.parseInt(listOfIdsString[i]));
		}
		Session session = sessionFactory.openSession();
		Query q = session.createQuery("DELETE FROM User WHERE userID IN (:list)");
		q.setParameter("list", listOfIdsInt);
		session.beginTransaction();
		q.executeUpdate();
		session.getTransaction().commit();
		session.close();
	} //end deleteUser()
}
