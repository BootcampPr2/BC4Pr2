package pr2.loseweight.utils;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.query.Query;

import pr2.loseweight.dbtables.*;

public abstract class DBUserUtils {

	public static void registerUser (String username, String password, double weight, double height, int age, String gender, int exerciseID) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		MetaRate myMetaRate = session.get(MetaRate.class, exerciseID);
		User user = new User (username, password);
		Bmi bmi = new Bmi (weight, height, age, gender, myMetaRate, user);
		session.beginTransaction();
		session.save(user);
		session.save(bmi);
		session.getTransaction().commit();
		session.close();		
	} //end registerUser()

	public static void updatePassword (User user, String password) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		user.setPassword(password);
		session.beginTransaction();
		session.update(user);
		session.getTransaction().commit();
		session.close();		
	} //end updatePassword()
	
	public static void updateUser (User user, double weight, double height, int age, String gender, int exerciseID) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		MetaRate metaRate = session.get(MetaRate.class, exerciseID);
		Bmi bmi = new Bmi (weight, height, age, gender, metaRate, user);
		session.beginTransaction();
		session.save(bmi);
		session.getTransaction().commit();
		session.close();		
	} //end updateUser()
	
	// Validate login
	public static boolean login(String username, String password) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();

		User myUser = getUserByUsername(username);
		if (myUser == null)
			return false;
		else {
			if (myUser.getPassword().equals(password))
				return true;
			else return false;
		}
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
		List<User> usersRetrieved = query.getResultList();
		User myUser;
		if (usersRetrieved.size() != 0)
			myUser = usersRetrieved.get(0);
		else
			myUser = null;
		session.close();
		sessionFactory.close();
		return myUser;
	}
	
	
	public static Bmi getUserBmiByUsername(String username) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		User user = getUserByUsername(username);
		String getUserBmi = "SELECT b FROM Bmi b WHERE b.user like :user order by dateTimePosted DESC" ;
		Query query = session.createQuery(getUserBmi).setParameter("user", user);
		List<Bmi> bmiRetrieved = query.getResultList();
		Bmi bmi;
		if (bmiRetrieved.size() != 0)
			bmi = bmiRetrieved.get(0);
		else
			bmi = null;
		session.close();
		sessionFactory.close();
		return bmi;
	}

	public static List<Bmi> bmiHistory(User user) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		String getBmiByUserId = "SELECT b FROM Bmi b WHERE b.user like :user order by dateTimePosted DESC";
		Query query = session.createQuery(getBmiByUserId).setParameter("user", user);
		List<Bmi> bmiRetrieved = query.getResultList();
		if (bmiRetrieved.size() != 0) {
			session.close();
			sessionFactory.close();
			return bmiRetrieved;
		}else {
			session.close();
			sessionFactory.close();
			return null;
		}
	}
	
	public static List<User> retrieveAllUsers(){
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		String retriveAllUsers = "from User";
		Query query = session.createQuery(retriveAllUsers);
		return query.getResultList();
	}
	
	public static void main(String[] args) {
		registerUser ("maria", "123", 72.8, 1.64, 29, "F", 1);
	}
	
} // end of class