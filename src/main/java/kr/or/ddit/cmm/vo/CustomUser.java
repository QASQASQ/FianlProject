package kr.or.ddit.cmm.vo;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.Getter;

@Getter
public class CustomUser extends User{
	
	private EmployeeVO emp;

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(EmployeeVO emp) {
		super(emp.getEmplNo(), emp.getEmplPwd(), emp.getAuthList().stream().map(
				auth -> new SimpleGrantedAuthority(auth.getAuthCode())).collect(Collectors.toList())
		);
		this.emp = emp;
		
	}
}
