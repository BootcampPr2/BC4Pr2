package pr2.loseweight.utils;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.query.Query;

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
	}
}
