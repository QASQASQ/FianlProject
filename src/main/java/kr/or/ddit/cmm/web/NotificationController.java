package kr.or.ddit.cmm.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.cmm.service.INotificationService;
import kr.or.ddit.cmm.vo.NotificationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hrms/notification")
public class NotificationController {

	@Autowired
	INotificationService notifiService;
	
	@PostMapping("/getNotification")
	public ResponseEntity<Map<String,Object>> getNotification(@RequestBody Map<String, String> paramMap){
		Map<String, Object> resultMap = new HashMap<>();
		String emplNo = paramMap.get("emplNo");
		log.info("emplNo emplNoemplNoemplNoemplNo : " + emplNo);
		List<NotificationVO> notificationList = notifiService.selectNotificationList(emplNo);
		if(notificationList != null && notificationList.size() > 0) {
			resultMap.put("notificationList", notificationList);
		}else {
			resultMap.put("notificationList", "알림이 없습니다.");
		}
		return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.OK);
	}
}
