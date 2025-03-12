package kr.or.ddit.cmm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.cmm.vo.NotificationVO;

@Mapper
public interface INotificationMapper {

	public int insertNotification(NotificationVO notificationVO);

	public List<NotificationVO> selectNotificationList(String emplNo);

}
