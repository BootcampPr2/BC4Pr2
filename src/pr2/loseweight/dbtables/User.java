package pr2.loseweight.dbtables;

import javax.persistence.*;

@Entity
@Table(name = "user")
public class User {
	private int userID;
	private String username;
	private String password;
	private int isBanned;
	private String profilePicUrl;
	private Role role;
	
	public User() {}
		
	public User(String username, String password, int isBanned, Role role) {
		super();
		this.username = username;
		this.password = password;
		this.isBanned = isBanned;
		this.role = role;
	}
	
	public User(String username, String password) {
		super();
		this.username = username;
		this.password = password;
		this.role = new Role(3);
	}

	@Id
	@Column(name = "userID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getIsBanned() {
		return isBanned;
	}
	public void setIsBanned(int isBanned) {
		this.isBanned = isBanned;
	}
	
		
	public String getProfilePicUrl() {
		return profilePicUrl;
	}

	public void setProfilePicUrl(String profilePicUrl) {
		this.profilePicUrl = profilePicUrl;
	}

	@ManyToOne
	@JoinColumn(name="roleID", referencedColumnName="roleID")
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "User [userID=" + userID + ", username=" + username + ", password=" + password + ", isBanned=" + isBanned
				+ ", role=" + role + "]";
	}
	
	
}