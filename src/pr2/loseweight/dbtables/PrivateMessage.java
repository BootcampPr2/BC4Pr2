package pr2.loseweight.dbtables;

import java.sql.Timestamp;
import javax.persistence.*;

@Entity
@Table(name = "private_message")
public class PrivateMessage {
	
	private int privateMessageID;
	private Timestamp dateSubmission;
	private String messageData;
	private int isRead;
	private User sender;
	private User receiver;
	
	@Id
	@Column(name = "private_messageID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getPrivateMessageID() {
		return privateMessageID;
	}
	public void setPrivateMessageID(int privateMessageID) {
		this.privateMessageID = privateMessageID;
	}
	public Timestamp getDateSubmission() {
		return dateSubmission;
	}
	public void setDateSubmission(Timestamp dateSubmission) {
		this.dateSubmission = dateSubmission;
	}
	public String getMessageData() {
		return messageData;
	}
	public void setMessageData(String messageData) {
		this.messageData = messageData;
	}
	public int getIsRead() {
		return isRead;
	}
	public void setIsRead(int isRead) {
		this.isRead = isRead;
	}
	
	@ManyToOne
	@JoinColumn (name = "senderID", referencedColumnName = "userID")
	public User getSender() {
		return sender;
	}
	public void setSender(User sender) {
		this.sender = sender;
	}
	
	@ManyToOne
	@JoinColumn (name = "receiverID", referencedColumnName = "userID")
	public User getReceiver() {
		return receiver;
	}
	public void setReceiver(User receiver) {
		this.receiver = receiver;
	}
	@Override
	public String toString() {
		return "PrivateMessage [privateMessageID=" + privateMessageID + ", dateSubmission=" + dateSubmission
				+ ", messageData=" + messageData + ", isRead=" + isRead + ", sender=" + sender + ", receiver="
				+ receiver + "]";
	}
	
}
