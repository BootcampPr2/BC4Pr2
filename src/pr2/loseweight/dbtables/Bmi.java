package pr2.loseweight.dbtables;

import java.sql.Timestamp;
import javax.persistence.*;

import pr2.loseweight.utils.*;

// Class that corresponds to the BMI (Body Mass Index) table of the database
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
	private double bmr; // Basal Metabolic Rate
	private double emr; // Exercise Metabolic Rate
	private Timestamp dateTimePosted;
	private MetaRate metarate; // Modifer based on exercise/activity
	private User user;
	
	public Bmi () {} // default constructor
	
	public Bmi(double weight, double height, int age, String gender, MetaRate metarate) {
		this.weight = weight;
		this.height = height;
		this.age = age;
		this.gender = gender;
		this.bmi = calculateBMI();
	}
	
	public Bmi(double weight, double height, int age, String gender, MetaRate metarate, User user) {
		this.weight = weight;
		this.height = height;
		this.age = age;
		this.gender = gender;
		this.metarate = metarate;
		this.user = user;
		this.bmi = calculateBMI();
		this.classification = calculateClassification();
		this.bmr = calculateBMR();	
		this.emr = calculateEMR();
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
	
	// calculation of BMI based on weight and height of user
	public double calculateBMI() {
		double bmi = this.weight/(this.height * this.height);
		return Math.round(bmi * 100.0) / 100.0;
	}
	
	public String calculateClassification() {
		String classification;
		if (this.bmi<18.5) {
			classification  = "Underweight";
		} else if (this.bmi<25) {
			classification  = "Optimal";
		} else if (this.bmi<30){
			classification  = "Overweight";
		} else {
			classification  = "Obese";
		}
		return classification; 
	}
	
	// calculation of BMR based on gender, weight, height and age of user
	public double calculateBMR() {
		double bmr;
		if (this.gender.equals("F")) {
			bmr = 655+(9.6*this.weight)+(1.8*100*this.height)-(4.7*this.age);
		}else {
			bmr = 66+(13.7*this.weight)+(5*100*this.height)-(6.8*this.age);
		}
		return Math.round(bmr * 100.0) / 100.0;
	}
	
	
	// calculation of EMR based on modifier and BMR
	public double calculateEMR() {
		double emr = this.bmr * metarate.getModifier();
		return Math.round(emr * 100.0) / 100.0;
	}
	

	@Override
	public String toString() {
		return "Bmi [bmiID=" + bmiID + ", weight=" + weight + ", height=" + height + ", age=" + age + ", gender="
				+ gender + ", bmi=" + bmi + ", classification=" + classification + ", bmr=" + bmr + ", emr=" + emr
				+ ", dateTimePosted=" + dateTimePosted + ", metarate=" + metarate.toString() + ", user=" + user.toString() + "]";
	}
}
