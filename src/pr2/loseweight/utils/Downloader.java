package pr2.loseweight.utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.RandomAccessFile;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import pr2.loseweight.dbtables.PrivateMessage;
import pr2.loseweight.dbtables.User;

public class Downloader {
	
	private static final String FILENAME = "messages.txt";
	private static final String sp = File.separator;
	
	public static void writeMessageToFile(List<PrivateMessage> allIncoming, List<PrivateMessage> allSent) {
		String jarPath = "";
		try {
			jarPath = URLDecoder.decode(Downloader.class.getProtectionDomain().getCodeSource().getLocation().getPath(), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String completePath = jarPath.substring(0, jarPath.lastIndexOf("/")) 
				+ sp + FILENAME;
		File f = new File(completePath);
		BufferedWriter writer;
		try {
			if (!f.exists() && !f.createNewFile()) {
				System.out.println("File doesn't exist, and creating file with path: " + completePath + " failed. ");

			} else {
				// Removing all contents of existing file
				RandomAccessFile myFile = new RandomAccessFile(f,"rwd");
				myFile.setLength(0);
				//
				writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(completePath,true), "UTF8"));
				writer.write("****** ALL INCOMING MESSAGES ******\r\n\r\n");
				for (PrivateMessage currentMessage : allIncoming) {
					writer.write("--------------------------------------------------------\r\n");
					writer.write("Sender: " + currentMessage.getSender().getUsername() + "\r\n");
					writer.write("Date Received: " + currentMessage.getDateSubmission() + "\r\n");
					writer.write("Message: " + currentMessage.getMessageData() + "\r\n");
				}
				writer.write("************************* END OF INCOMING MESSAGES *************************\r\n\r\n");
				writer.write("****** ALL SENT MESSAGES ******\r\n\r\n");
				for (PrivateMessage currentMessage : allSent) {
					writer.write("--------------------------------------------------------\r\n");
					writer.write("Receiver: " + currentMessage.getReceiver().getUsername() + "\r\n");
					writer.write("Date Sent: " + currentMessage.getDateSubmission() + "\r\n");
					writer.write("Message: " + currentMessage.getMessageData() + "\r\n");
				}
				writer.write("************************* END OF SENT MESSAGES *************************\r\n\r\n");
				writer.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	} // end writeMessageToFile()
	
	public static void main (String[] args) {
		User myUser = DBUtils.getUserByUsername("user1");
		List<PrivateMessage> incoming = DBUtils.displayIncomingMessages(myUser);
		List<PrivateMessage> sent = DBUtils.displaySentMessages(myUser);
		writeMessageToFile(incoming,sent);
	}
	
} // end of class