package pr2.loseweight.dbtables;

import javax.persistence.*;

@Entity
@Table(name = "role")
public class Role {
	
	private int roleID;
	private String roleName;
	
	public Role() {}
	
	@Id
	@Column(name = "roleID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getRoleID() {
		return roleID;
	}
	public void setRoleID(int roleID) {
		this.roleID = roleID;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	@Override
	public String toString() {
		return "Role [roleID=" + roleID + ", roleName=" + roleName + "]";
	}
	
	
}
