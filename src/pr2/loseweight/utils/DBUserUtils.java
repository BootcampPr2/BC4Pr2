package pr2.loseweight.utils;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import pr2.loseweight.dbtables.*;

public abstract class DBUserUtils {
	
	public static void registerUser(User newUser, Bmi userBMI) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		session.save(newUser);
		session.save(userBMI);
		session.getTransaction().commit();
		session.close();
	} // end registerUser()
	
	
} // end of class
