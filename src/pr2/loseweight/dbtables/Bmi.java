package pr2.loseweight.dbtables;

import java.sql.Timestamp;

import javax.persistence.*;

@Entity
@Table(name = "bmi")
public class Bmi {
	private int bmiID;
	private double weight;
	private double height;
	private int age;
	private String gender;
	private double bmi;
	private String classification;
	private double bmr;
	private double emr;
	private Timestamp dateTimePosted;
	private MetaRate metarate;
	private User user;
	
	public Bmi () {} // default constructor
	
	public Bmi(double weight, double height, int age, String gender, MetaRate metarate) {
		this.weight = weight;
		this.height = height;
		this.age = age;
		this.gender = gender;
		this.bmi = calculateBMI();
	}

	@Id
	@Column(name = "bmiID")
	public int getBmiID() {
		return bmiID;
	}

	public void setBmiID(int bmiID) {
		this.bmiID = bmiID;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(double height) {
		this.height = height;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public double getBmi() {
		return bmi;
	}

	public void setBmi(double bmi) {
		this.bmi = bmi;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public double getBmr() {
		return bmr;
	}

	public void setBmr(double bmr) {
		this.bmr = bmr;
	}

	public double getEmr() {
		return emr;
	}

	public void setEmr(double emr) {
		this.emr = emr;
	}

	public Timestamp getDateTimePosted() {
		return dateTimePosted;
	}

	public void setDateTimePosted(Timestamp dateTimePosted) {
		this.dateTimePosted = dateTimePosted;
	}

	@ManyToOne
	@JoinColumn(name="metaID", referencedColumnName="metaID")
	public MetaRate getMetarate() {
		return metarate;
	}
	
	public void setMetarate(MetaRate metarate) {
		this.metarate = metarate;
	}
	
	@ManyToOne
	@JoinColumn(name="userID", referencedColumnName="userID")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public double calculateBMI() {
		return (double)(this.weight/(this.height * this.height));
	}
	
	public double calculateBMR() {
		return 0;
	}
	
	public double calculateEMR() {
		return 0;
	}
	
	public static void main(String[] args) {
		MetaRate myMetaRate = MetaRate.getMetaRateByDescription("Sedentary");
		Bmi newBMI = new Bmi(70,1.75,50,"F",myMetaRate);
		
	}
}
