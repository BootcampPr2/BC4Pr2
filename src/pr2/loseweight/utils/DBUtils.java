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

// Class with methods related to users' private messages
public abstract class DBUtils {
	
	// once a message is opened by a user, it is set as read in the database
	public static void setRead(SessionFactory sessionFactory, int privateMessageID) {
		Session session = sessionFactory.openSession();
		PrivateMessage myMessage = session.get(PrivateMessage.class, privateMessageID);
		session.beginTransaction();
		myMessage.setIsRead(1);
		session.update(myMessage);
		session.getTransaction().commit();
		session.close();
	} // end setRead()
	
	public static List<PrivateMessage> displayIncomingMessages(SessionFactory sessionFactory, User receiver) {
		Session session = sessionFactory.openSession();
		String selectIncomingMessages = "SELECT p From PrivateMessage p"
				+ " where p.receiver like :receiver"
				+ " order by p.dateSubmission DESC";
		Query query = session.createQuery(selectIncomingMessages).setParameter("receiver", receiver);
		List<PrivateMessage> incomingMessages = query.getResultList();
		session.close();
		return incomingMessages;
	} // end displayIncomingMessages()
	
	public static List<PrivateMessage> displaySentMessages(SessionFactory sessionFactory, User sender) {
		Session session = sessionFactory.openSession();
		String selectSentMessages = "SELECT p From PrivateMessage p"
				+ " where p.sender like :sender"
				+ " order by p.dateSubmission DESC";
		Query query = session.createQuery(selectSentMessages).setParameter("sender", sender);
		List<PrivateMessage> sentMessages = query.getResultList();
		session.close();
		return sentMessages;
	} // end displaySentMessages
	
	public static List<PrivateMessage> getAllMessagesByUser(SessionFactory sessionFactory, User user) {
		Session session = sessionFactory.openSession();
		String selectSentMessages = "SELECT p From PrivateMessage p"
				+ " where p.sender like :user or p.receiver like :user"
				+ " order by p.dateSubmission DESC";
		Query query = session.createQuery(selectSentMessages).setParameter("user", user);
		List<PrivateMessage> sentMessages = query.getResultList();
		session.close();
		return sentMessages;
	} // end getAllMessagesByUser()
	
	public static boolean composeNewPrivateMessage(SessionFactory sessionFactory, User sender, User receiver, String messageData) {
		Session session = sessionFactory.openSession();
		PrivateMessage newPrivateMessage = new PrivateMessage();
		messageData = messageData.replaceAll("[\r\n]", "&nbsp;<br>");
		messageData = messageData.replaceAll(" ", "&nbsp;");
		messageData = messageData.replaceAll("'", "&#39;");
		messageData = messageData.replaceAll("\"", "&#34;");
		newPrivateMessage.setMessageData(messageData);
		newPrivateMessage.setSender(sender);
		newPrivateMessage.setReceiver(receiver);		
		boolean successfullySent;
		try {
		session.beginTransaction();
		session.save(newPrivateMessage);
		session.getTransaction().commit();
		successfullySent = true;
		}catch(Exception e) {
			e.printStackTrace();
			successfullySent = false;
		}
		finally{
			session.close();
		}
		return successfullySent;
	} // end composeNewPrivateMessage()
}
