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
import pr2.loseweight.dbtables.User;

public class DBAdminUtils {

	public static List<PrivateMessage> displayAllPrivateMessages(SessionFactory sessionFactory) {
		Session session = sessionFactory.openSession();
		String selectAllMessages = "From PrivateMessage order by dateSubmission DESC";
		Query query = session.createQuery(selectAllMessages);
		List<PrivateMessage> allMessages = query.getResultList();
		session.close();
		return allMessages;
	} //end displayAllPrivateMessages()

	public static void banUnbanUser(SessionFactory sessionFactory, String[] listOfIdsString) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		for (int i=0;i<listOfIdsString.length;i++) {
			int userID = Integer.parseInt(listOfIdsString [i]);
			User user = session.get(User.class, userID);
			if (user.getIsBanned() == 0) {
				user.setIsBanned(1);
			}else {
				user.setIsBanned(0);
			}
			session.update(user);
			session.getTransaction().commit();
		}
		session.close();
	} //end banUnbanUser()

	public static void assignUnassignUser(SessionFactory sessionFactory, String[] listOfIdsString) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		for (int i=0;i<listOfIdsString.length;i++) {
			int userID = Integer.parseInt(listOfIdsString [i]);
			User user = session.get(User.class, userID);
			if (user.getRole().getRoleID() == 3) {
				user.getRole().setRoleID(1);
			}else {
				user.getRole().setRoleID(3);
			}
			session.update(user);
			session.getTransaction().commit();
		}
		session.close();
	} //end assignUnassignUser()

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
