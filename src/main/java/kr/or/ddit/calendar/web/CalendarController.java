package kr.or.ddit.calendar.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.calendar.service.ICalendarService;
import kr.or.ddit.calendar.vo.CalendarVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/hrms/cal")
public class CalendarController {

	@Autowired
	private ICalendarService service;
	
	@GetMapping("/viewCalendar")
	public String viewCalendar(Model model) {
		log.info("viewCalendar 실행");
		//List<CalendarVO> events = service.findAll();
		//model.addAttribute("events", events);
		return "calendar/calendar";
	}
}
