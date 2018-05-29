package pr2.loseweight.dbtables;

import javax.persistence.*;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.query.Query;


// Metabolic rate is defined by a modifier, which in turn is defined by the level of weekly exercise of the user
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
	
	@Override
	public String toString() {
		return "MetaRate [metaID=" + metaID + ", description=" + description + ", modifier=" + modifier + "]";
	}
}