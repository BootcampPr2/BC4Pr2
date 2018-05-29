package pr2.loseweight.utils;

import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

// Hibernate class designed as Singleton
public class HibernateUtil {
	
    public static SessionFactory sessionFactory;

    private HibernateUtil() {
    	// do nothing
    }

    // Generate Session Factory if one is not created yet
    public static synchronized SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
      		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
    		try {
    			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
    		} catch(Exception ex) {
    			StandardServiceRegistryBuilder.destroy(registry);
    		}
        }
        return sessionFactory;
    }
}