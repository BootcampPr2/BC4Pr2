package pr2.loseweight.utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.xml.bind.DatatypeConverter;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.query.Query;

import pr2.loseweight.dbtables.*;

// Class that contains methods used by users
public abstract class DBUserUtils {

	public static void registerUser (SessionFactory sessionFactory, String username, String password, double weight, double height, int age, String gender, int exerciseID) {
		Session session = sessionFactory.openSession();
		MetaRate myMetaRate = session.get(MetaRate.class, exerciseID);
		MessageDigest digest = null;
		try {
			digest = MessageDigest.getInstance("SHA-256");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
	    String hex = DatatypeConverter.printHexBinary(hash);
	    
		User user = new User (username, hex);
		
		Bmi bmi = new Bmi (weight, height, age, gender, myMetaRate, user);
		session.beginTransaction();
		session.save(user);
		session.save(bmi);
		session.getTransaction().commit();
		session.close();		
	} //end registerUser()

	public static boolean updatePassword (SessionFactory sessionFactory, User user, String password) {	
		MessageDigest digest = null;
		try {
			digest = MessageDigest.getInstance("SHA-256");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
	    String hex = DatatypeConverter.printHexBinary(hash);
	    
		user.setPassword(hex);
		Session session = sessionFactory.openSession();
		boolean updateSuccessful;
		try {
			session.beginTransaction();
			session.update(user);
			session.getTransaction().commit();
			updateSuccessful = true;
		}catch(Exception e){
			updateSuccessful = false;
		}
		finally{
			session.close();		
		}
		return updateSuccessful;
	} //end updatePassword()

	// updates related column in database to point to the location of the user's picture
	public static boolean updateProfilePic (SessionFactory sessionFactory, User user, String profilePicUrl) {
		user.setProfilePicUrl(profilePicUrl);
		boolean updateSuccessful;
		Session session = sessionFactory.openSession();
		try {
			session.beginTransaction();
			session.update(user);
			session.getTransaction().commit();
			updateSuccessful = true;
		}catch(Exception e){
			updateSuccessful = false;
		}
		finally{
			session.close();		
		}
		return updateSuccessful;
	} // end updateProfilePic()

	// creates new BMI
	public static boolean updateUser (SessionFactory sessionFactory, User user, double weight, double height, int age, String gender, int exerciseID) {
		Session session = sessionFactory.openSession();
		MetaRate metaRate = session.get(MetaRate.class, exerciseID);
		Bmi bmi = new Bmi (weight, height, age, gender, metaRate, user);
		boolean updateSuccessful;
		try {
			session.beginTransaction();
			session.save(bmi);
			session.getTransaction().commit();
			updateSuccessful = true;
		}catch(Exception e) {
			updateSuccessful = false;
		}
		finally{
			session.close();		
		}
		return updateSuccessful;
	} //end updateUser()

	// Validate login
	public static boolean login(SessionFactory sessionFactory, String username, String password) {
		MessageDigest digest = null;
		try {
			digest = MessageDigest.getInstance("SHA-256");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
	    String hex = DatatypeConverter.printHexBinary(hash);
		
		
		User myUser = getUserByUsername(sessionFactory, username);
		if (myUser == null)
			return false;
		else {
			if (myUser.getPassword().equals(hex))
				return true;
			else return false;
		}
	} // end login()

	public static User getUserByUsername(SessionFactory sessionFactory, String username) {
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
		return myUser;
	} // end getUserByUsername()


	public static Bmi getUserBmiByUsername(SessionFactory sessionFactory, String username) {
		Session session = sessionFactory.openSession();
		User user = getUserByUsername(sessionFactory, username);
		String getUserBmi = "SELECT b FROM Bmi b WHERE b.user like :user order by dateTimePosted DESC" ;
		Query query = session.createQuery(getUserBmi).setParameter("user", user);
		List<Bmi> bmiRetrieved = query.getResultList();
		Bmi bmi;
		if (bmiRetrieved.size() != 0)
			bmi = bmiRetrieved.get(0);
		else
			bmi = null;
		session.close();
		return bmi;
	} // end getUserBmiByUsername()

	public static List<Bmi> bmiHistory(SessionFactory sessionFactory, User user) {
		Session session = sessionFactory.openSession();
		String getBmiByUserId = "SELECT b FROM Bmi b WHERE b.user like :user order by dateTimePosted DESC";
		Query query = session.createQuery(getBmiByUserId).setParameter("user", user);
		List<Bmi> bmiRetrieved = query.getResultList();
		if (bmiRetrieved.size() != 0) {
			session.close();
			return bmiRetrieved;
		}else {
			session.close();
			return null;
		}
	} // end bmiHistory()

	public static List<User> retrieveAllUsers(SessionFactory sessionFactory){
		Session session = sessionFactory.openSession();
		String retrieveAllUsers = "from User";
		Query query = session.createQuery(retrieveAllUsers);
		return query.getResultList();
	} // end retrieveAllUsers()

} // end of class