package kr.or.ddit.cmm.service;

import java.util.List;

import kr.or.ddit.cmm.vo.NotificationVO;

public interface INotificationService {
	
	public void sendNotification(String ntcnRecp, String ntcnContent, String ntCode);

	public List<NotificationVO> selectNotificationList(String emplNo);
}
