package com.gnjk.chat.domain;

import lombok.Data;

@Data
public class Alarm {
	
	public String type;	// 댓글, 좋아요, 팔로우
	public int sender;		// ~한 사람
	public int receiver;	// 알람 받는 사람

}