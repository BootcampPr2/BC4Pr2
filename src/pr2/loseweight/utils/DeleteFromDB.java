package pr2.loseweight.utils;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;


public abstract class DeleteFromDB {
	
	// Method that takes a list of IDs and deletes the Private Messages with those IDs from the DB
	// Button "delete incoming/sent messages" in mail.jsp
	public static void deleteSelectedMessages(SessionFactory sessionFactory, String[] listOfIdsString) {
		// Converts the array of Strings to a list of the IDs
		List<Integer> listOfIdsInt = new ArrayList<Integer>();
		for (int i=0;i<listOfIdsString.length;i++) {
			listOfIdsInt.add(Integer.parseInt(listOfIdsString[i]));
		}
		//
		Session session = sessionFactory.openSession();
		Query q = session.createQuery("DELETE FROM PrivateMessage WHERE privateMessageID IN (:list)");
		q.setParameter("list", listOfIdsInt);
		session.beginTransaction();
		q.executeUpdate();
		session.getTransaction().commit();
		session.close();
	} // end deleteSelectedMessages()

	public static void deleteSelectedBmis(SessionFactory sessionFactory, String[] listOfIdsString) {
		List<Integer> listOfIdsInt = new ArrayList<Integer>();
		for (int i=0;i<listOfIdsString.length;i++) {
			listOfIdsInt.add(Integer.parseInt(listOfIdsString[i]));
		} 
		Session session = sessionFactory.openSession();
		Query q = session.createQuery("DELETE FROM Bmi WHERE bmiID IN (:list)");
		q.setParameter("list", listOfIdsInt);
		session.beginTransaction();
		q.executeUpdate();
		session.getTransaction().commit();
		session.close();			
	} // end deleteSelectedBmis()

} // end of class