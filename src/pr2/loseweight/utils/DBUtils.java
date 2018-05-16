package pr2.loseweight.utils;

import java.util.List;
import pr2.loseweight.dbtables.*;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.query.Query;

import pr2.loseweight.dbtables.Role;
import pr2.loseweight.dbtables.User;


public abstract class DBUtils {
	public static SessionFactory sessionFactory;
	

	
	public static List<PrivateMessage> displayIncomingMessages(User receiver) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		String selectIncomingMessages = "SELECT p From PrivateMessage p"
				+ " where p.receiver like :receiver"
				+ " order by p.dateSubmission DESC";
		Query query = session.createQuery(selectIncomingMessages).setParameter("receiver", receiver);
		List<PrivateMessage> incomingMessages = query.list();
		session.close();
		return incomingMessages;
	}
	
	public static List<PrivateMessage> displaySentMessages(User sender) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		String selectSentMessages = "SELECT p From PrivateMessage p"
				+ " where p.sender like :sender"
				+ " order by p.dateSubmission DESC";
		Query query = session.createQuery(selectSentMessages).setParameter("sender", sender);
		List<PrivateMessage> sentMessages = query.list();
		session.close();
		return sentMessages;
	}
	
	public static User getUserByUsername(String username) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		String getUserById = "SELECT u FROM User u WHERE u.username like :username";
		Query query = session.createQuery(getUserById).setParameter("username", username);
		User myUser = (User)query.list().get(0);
		session.close();
		sessionFactory.close();
		return myUser;
	}
	

	public static void composeNewPrivateMessage(User sender, User receiver, String messageData) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		PrivateMessage newPrivateMessage = new PrivateMessage();
		newPrivateMessage.setMessageData(messageData);
		newPrivateMessage.setSender(sender);
		newPrivateMessage.setReceiver(receiver);
		session.beginTransaction();
		session.save(newPrivateMessage);
		session.getTransaction().commit();
		session.close();		
	}

	public static void read() {
		Session session = sessionFactory.openSession();
		int userID = 1;
		User myUser = session.get(User.class, userID);
		System.out.println(myUser);
		// System.out.format("Role: %s", myRole.getRoleName());
	}

	protected void update() {
		Role myRole = new Role();
		myRole.setRoleID(3);
		myRole.setRoleName("STANDARD_USER");
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.update(myRole);
		session.getTransaction().commit();
		session.close();
	}

	protected void delete() {
		Role myRole = new Role();
		myRole.setRoleID(5);
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.delete(myRole);
		session.getTransaction().commit();
		session.close();
	}

	public static void main(String[] args) {	
		User sender = getUserByUsername("user1");
		User receiver = getUserByUsername("admin");
		

		//manager.update();
		//update.delete();
		
		
		/*StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		SessionFactory sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		Session session = sessionFactory.openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			Role myRole = session.get(Role.class,3);
			//By using cascade=all option the address need not be saved explicitly when the student object is persisted the address will be automatically saved.
            //session.save(address);
			User newUser = new User("user1", "123", 0, myRole);
			session.save(newUser);
			newUser = new User("user2", "123", 0, myRole);
			session.save(newUser);
			transaction.commit();
		} catch (HibernateException e) {
			transaction.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}*/

		
		
	}
}

