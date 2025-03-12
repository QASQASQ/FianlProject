package kr.or.ddit.message.web.chat;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/*
 * Writer: 백승권
 * @return 채팅 페이지 접근 컨트롤러 
 */
@RequestMapping("/hrms")
@Controller
public class ChatPageController {
  
  @PreAuthorize("hasAnyAuthority('ROLE_GENERAL', 'ROLE_ADMIN', 'ROLE_MANAGER')")
  @GetMapping("/chat")
  public String main() {
    return "message/chat";
  }
}
