package pr2.loseweight.utils;

import java.util.Arrays;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.query.Query;

// Method that takes a list of IDs and deletes the Private Messages with those IDs from the DB
// Button "delete incoming/sent messages" in mail.jsp
public abstract class DeleteFromDB {
	public static void deleteSelectedMessages(List<Integer> ListOfIds) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		Query q = session.createQuery("DELETE FROM PrivateMessage WHERE privateMessageID IN (:list)");
		q.setParameter("list", ListOfIds);
		session.beginTransaction();
		q.executeUpdate();
		session.getTransaction().commit();
		session.close();			
	} // end of DeleteFromDB()
	
	public static void main (String[] args) {
		List<Integer> list = Arrays.asList(5,7,8);
		DeleteFromDB.deleteSelectedMessages(list);
		
	}
}
