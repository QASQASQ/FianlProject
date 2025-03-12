package kr.or.ddit.pay.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/hrms")
@Controller
public class PayStubPageController {

  @GetMapping("/payStub")
  public String main() {
      return "pay/payStub";
  }

  @GetMapping("/payStub/myPage")
  public String sub() {
      return "pay/myPayStub";
  }
}
