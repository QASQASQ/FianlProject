package kr.or.ddit.cmm.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import kr.or.ddit.cmm.mapper.ISecurityMapper;
import kr.or.ddit.cmm.vo.CustomUser;
import kr.or.ddit.employee.mapper.IEmployeeMapper;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	private ISecurityMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("## CustomUserDetailsService.loadUserByUsername() 실행...");
		log.info("## username : " + username);
		
		EmployeeVO emp = mapper.selectEmployee(username);
		return emp == null ? null : new CustomUser(emp);
	}

}
