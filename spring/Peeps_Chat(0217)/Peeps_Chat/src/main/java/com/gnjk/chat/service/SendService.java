package com.gnjk.chat.service;

import com.gnjk.chat.domain.Message;

public interface SendService {
	
	public void insertMessage(Message message) throws Exception;
	
	//public List<Message> getMessageData(String str) throws Exception;

}