package kr.or.ddit.pay.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.pay.service.IPayStubService;
import kr.or.ddit.pay.vo.PayStubVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/hrms")
@RestController
public class PayStubController {


    @Autowired
    private IPayStubService service;

    /**
     * 📌 급여명세서 보기
     */
    @PostMapping("payStub/view/{emplNo}")
    public ResponseEntity<?> viewPayStub(@PathVariable String emplNo) {
        try {
            Map<String, Object> payStub = service.getPayStub(emplNo);
            return ResponseEntity.ok(payStub);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("message", "❌ 서버 오류 발생: " + e.getMessage()));
        }
    }


    /**
     * 📌 선택된 사원의 급여 지급 확정 처리
     * ✅ - PAY_AT 값을 'Y'로 변경
     * ✅ - 기존 미리보기 데이터 삭제
     */
    @PostMapping("/payStub")
    public ResponseEntity<Map<String, Object>> paySalary(@RequestBody Map<String, List<String>> requestData) {
        List<String> emplNos = requestData.get("emplNos");
        Map<String, Object> response = new HashMap<>();

        if (emplNos == null || emplNos.isEmpty()) {
            response.put("message", "⚠️ 사원이 선택되지 않았습니다.");
            return ResponseEntity.badRequest().body(response);
        }

        try {
            service.paySalary(emplNos);
            response.put("message", "✅ 급여 지급이 성공적으로 확정되었습니다.");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("message", "❌ 급여 지급 중 오류 발생: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    @GetMapping("/payStub/mylist")
    @ResponseBody
    public List<PayStubVO> getMyPayStubs(
        @RequestParam(value = "yearr", required = false) String yearr,
        @RequestParam(value = "monthh", required = false) String monthh,
        @RequestParam(value = "dayy", required = false) String dayy,
        HttpSession session) {
        String emplNo = (String) session.getAttribute("userId");
        return service.getMyPayStubs(emplNo, yearr, monthh, dayy);
    }
}
