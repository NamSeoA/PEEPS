package com.gnjk.chat.domain;

import java.sql.Timestamp;

public class Message {

	private String user; 	// 사용자 
	private String to; 		// 받는사람 
	private Timestamp time; // 채팅시간
	// private Timestamp time = new Timestamp(System.currentTimeMillis()); // 채팅시간 
	private String message; // 채팅내용
	
	public Message(String user, String to, Timestamp time, String message) {
		this.user = user;
		this.to = to;
		this.time = time;
		this.message = message;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "Message [user=" + user + ", to=" + to + ", time=" + time + ", message=" + message + "]";
	}
	
}