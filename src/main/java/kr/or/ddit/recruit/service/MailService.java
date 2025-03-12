package kr.or.ddit.recruit.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class MailService {

    @Autowired
    private JavaMailSender mailSender;

    // 💌 사번 포함 HTML 형식의 합격 메일 전송 메서드
    public void sendAcceptanceMail(String toEmail, String applicantName, String employeeId) {
        try {
            if (toEmail == null || toEmail.trim().isEmpty()) {
                throw new IllegalArgumentException("❌ 수신자 이메일 주소가 유효하지 않습니다.");
            }

            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(toEmail);
            helper.setSubject("[ H E R M E S 회사 최종 합격 안내] " + applicantName + "님, 진심으로 축하드립니다!");
            helper.setText(getHtmlContent(applicantName, employeeId), true); // 📜 HTML 본문 사용
            ClassPathResource resource = new ClassPathResource("static/assets/img/logoStart.png");
            helper.addInline("logoImage", resource);


            mailSender.send(message);

        } catch (MailAuthenticationException e) {
            log.error("❌ 메일 서버 인증 실패: {}", e.getMessage());
            throw new RuntimeException("❌ 메일 서버 인증 실패: SMTP 설정을 확인하세요.", e);
        } catch (MessagingException | MailException e) {
            log.error("❌ 메일 전송 중 오류 발생: {}", e.getMessage());
            throw new RuntimeException("❌ 메일 전송 중 오류가 발생했습니다.", e);
        }
    }

    // 🌟 HTML 메일 템플릿 (사번 포함)
    private String getHtmlContent(String applicantName, String employeeId) {
        return """
                <div style="font-family: Arial, sans-serif; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;">
                    <img src='cid:logoImage' alt='HERMES Logo' style='width: 150px; margin-bottom: 20px;'>
                    <h2 style="color: #FF5722;">🎉 <strong>%s</strong> 님, [ H E R M E S ] 최종 합격을 축하드립니다!</h2>
                    <p>안녕하세요, <strong>%s</strong> 님.</p>
                    <p>
                        귀하께서는 <strong>[ H E R M E S ]</strong>의 채용 절차에서 최종 합격하셨습니다.<br>
                        함께 일할 수 있게 되어 매우 기쁩니다.<br><br>
                        <strong>사번:</strong> <span style="color: #FF5722; font-weight: bold;">%s</span><br>
                        <strong>입사일자:</strong> 추후 개별 안내<br>
                        <strong>근무지:</strong> 본사 [ H E R M E S ]<br>
                        <strong>출근 시간:</strong> 오전 9시<br>
                    </p>
                    <p>
                        ✉️ 추가 문의 사항이 있으시면 <a href="mailto:support@hermes.com">support@hermes.com</a> 으로 연락 바랍니다.<br>
                    </p>
                    <p style="color: #888;">감사합니다.<br><strong>[ H E R M E S ] 대표이사 김 동 준 드림</strong></p>
                    <hr>
                    <small style="color: #999;">※ 본 메일은 발신 전용입니다.</small>
                </div>
                """.formatted(applicantName, applicantName, employeeId);
    }
}
