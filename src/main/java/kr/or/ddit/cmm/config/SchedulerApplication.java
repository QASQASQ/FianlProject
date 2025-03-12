package kr.or.ddit.cmm.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

// 시간을 기준으로 결근처리할때 필요한 스케줄러
@SpringBootApplication
@EnableScheduling
public class SchedulerApplication {
	public static void main(String[] args) {
		SpringApplication.run(SchedulerApplication.class, args);
	}
}
