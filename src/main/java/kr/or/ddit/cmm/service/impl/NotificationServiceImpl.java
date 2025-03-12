package kr.or.ddit.cmm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import kr.or.ddit.cmm.mapper.INotificationMapper;
import kr.or.ddit.cmm.service.INotificationService;
import kr.or.ddit.cmm.vo.NotificationVO;

@Service
public class NotificationServiceImpl implements INotificationService{

	private final SimpMessagingTemplate messagingTemplate;
	
	@Autowired
	INotificationMapper notificationMapper;
	
	public NotificationServiceImpl(SimpMessagingTemplate messagingTemplate) {
		this.messagingTemplate = messagingTemplate;
	}
	
	@Override
	public void sendNotification(String ntcnRecp, String ntcnContent, String ntCode) {
		NotificationVO notificationVO = new NotificationVO();
		notificationVO.setNtcnRecp(ntcnRecp);
		notificationVO.setNtcnContent(ntcnContent);
		notificationVO.setNtCode(ntCode);
		int result = notificationMapper.insertNotification(notificationVO);
		messagingTemplate.convertAndSend("/queue/notifications-" + ntcnRecp, notificationVO);
	}

	@Override
	public List<NotificationVO> selectNotificationList(String emplNo) {
		return notificationMapper.selectNotificationList(emplNo);
	}
}


