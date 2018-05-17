package pr2.loseweight.dbtables;

import javax.persistence.*;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.query.Query;

@Entity
@Table (name="metabolic_rate")
public class MetaRate {
	private int metaID;
	private String description;
	private double modifier;
	
	public MetaRate() {} // default constructor
	
	
	@Id
	@Column(name = "metaID")
	public int getMetaID() {
		return metaID;
	}
	public void setMetaID(int metaID) {
		this.metaID = metaID;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getModifier() {
		return modifier;
	}
	public void setModifier(double modifier) {
		this.modifier = modifier;
	}
	
	public static MetaRate getMetaRateByDescription(String description) {
		SessionFactory sessionFactory = null;
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		try {
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
		} catch(Exception ex) {
			StandardServiceRegistryBuilder.destroy(registry);
		}
		Session session = sessionFactory.openSession();
		String getUserById = "SELECT m FROM MetaRate m WHERE m.description like :description";
		Query query = session.createQuery(getUserById).setParameter("description", description);
		MetaRate myMetaRate = (MetaRate)query.getResultList().get(0);
		session.close();
		sessionFactory.close();		
		return myMetaRate;
	}
}