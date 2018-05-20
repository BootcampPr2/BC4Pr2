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
	
	public static List<PrivateMessage> displayAllPrivateMessages() {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		String selectAllMessages = "From PrivateMessage order by dateSubmission DESC";
		Query query = session.createQuery(selectAllMessages);
		List<PrivateMessage> allMessages = query.getResultList();
		session.close();
		return allMessages;
	}
	
	public static void main(String[] args) {
		List<PrivateMessage> allMessages = displayAllPrivateMessages();
		for (int i=0;i<allMessages.size();i++)
			System.out.println(allMessages.get(i).toString());
	}
}
