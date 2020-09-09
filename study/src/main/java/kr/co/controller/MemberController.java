package kr.co.controller;

import java.sql.Date;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import kr.co.service.MemberService;
import kr.co.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	MemberService service;

	@Inject
	BCryptPasswordEncoder pwdEncoder;

	// 회원가입 get
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() throws Exception {

		logger.info("get register");

	}

	// 회원가입 post
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String postRegister(MemberVO vo) throws Exception {
		logger.info("post register");
		int result = service.idChk(vo);
		try {
			if (result == 1) {
				return "/register";
			} else if (result == 0) {
				String inputPass = vo.getUserPass();
				String pwd = pwdEncoder.encode(inputPass);
				vo.setUserPass(pwd);

				service.register(vo);
			}
			// 요기에서~ 입력된 아이디가 존재한다면 -> 다시 회원가입 페이지로 돌아가기
			// 존재하지 않는다면 -> register
		} catch (Exception e) {
			throw new RuntimeException();
		}
		return "redirect:/";
	}

	// 로그인 get
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void getlogin() throws Exception {
		logger.info("get login");

	}

	// 로그인 post 로그인 처리하는 부분
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpServletResponse response, HttpSession session, RedirectAttributes rttr)
			throws Exception {
		String returnURL = "";
		logger.info("post login");

		if (session.getAttribute("member") != null) {
			session.removeAttribute("member");
		}
		MemberVO login = service.login(vo);

		boolean pwdMatch;
		if (login != null) { // 로그인 정보를 받아왔다면 패스워드 검사
			pwdMatch = pwdEncoder.matches(vo.getUserPass(), login.getUserPass());
		} else {
			pwdMatch = false;
		}

		if (login != null && pwdMatch == true) { // 로그인 성공
			session.setAttribute("member", login);
			returnURL = "redirect:/list";

			// 세션 추가
			if (vo.isUseCookie()) {
				// 쿠키 사용한다는게 체크되어 있으면...
				// 쿠키를 생성하고 현재 로그인되어 있을 때 생성되었던 세션의 id를 쿠키에 저장한다.
				Cookie cookie = new Cookie("loginCookie", session.getId());
				// 쿠키를 찾을 경로를 컨텍스트 경로로 변경해 주고...
				cookie.setPath("/");
				int amount = 60 * 60 * 24 * 7;
				cookie.setMaxAge(amount);// 단위는 (초)임으로 7일정도로 유효시간을 설정해 준다.
				// 쿠키를 적용해 준다.
				response.addCookie(cookie);

				// currentTimeMills()가 1/1000초 단위임으로 1000곱해서 더해야함
				Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
				// 현재 세션 id와 유효시간을 사용자 테이블에 저장한다.
				service.keepLogin(vo.getUserId(), session.getId(), sessionLimit);
			}

		} else { // 로그인 실패
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			returnURL = "redirect:/member/login";
		}

		return returnURL;

	}

	// 로그아웃 post
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Object obj = session.getAttribute("member");
		if (obj != null) {
			MemberVO vo = (MemberVO) obj;
			// null이 아닐 경우 제거
			session.removeAttribute("member");
			session.invalidate();// 세션 전체를 날려버림
			// 쿠키를 가져와보고
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if (loginCookie != null) {
				// null이 아니면 존재하면!
				loginCookie.setPath("/");
				// 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
				loginCookie.setMaxAge(0);
				// 쿠키 설정을 적용한다.
				response.addCookie(loginCookie);

				// 사용자 테이블에서도 유효기간을 현재시간으로 다시 세팅해줘야함.
				Date date = new Date(System.currentTimeMillis());
				service.keepLogin(vo.getUserId(), "none", date);
			}
		}

		return "redirect:/list";
	}

	// 회원정보 수정 get
	@RequestMapping(value = "/memberUpdateView", method = RequestMethod.GET)
	public String registerUpdateView() throws Exception {
		return "member/memberUpdateView";
	}

	// 회원정보 수정 post
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String registerUpdate(MemberVO vo, HttpSession session) throws Exception {

		/*
		 * MemberVO login = service.login(vo);
		 * 
		 * boolean pwdMatch = pwdEncoder.matches(vo.getUserPass(), login.getUserPass());
		 * if(pwdMatch) { service.memberUpdate(vo); session.invalidate(); }else { return
		 * "member/memberUpdateView"; }
		 */

		String inputPass = vo.getChangeuserPass();
		String pwd = pwdEncoder.encode(inputPass);
		vo.setUserPass(pwd);
		System.out.println(pwd);
		service.memberUpdate(vo);
		session.invalidate();
		return "redirect:/";
	}

	// 회원 탈퇴 get
	@RequestMapping(value = "/memberDeleteView", method = RequestMethod.GET)
	public String memberDeleteView() throws Exception {
		return "member/memberDeleteView";
	}

	// 회원 탈퇴 post
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {

		service.memberDelete(vo);
		session.invalidate();

		return "redirect:/";
	}

	// 패스워드 체크
	@ResponseBody
	@RequestMapping(value = "/passChk", method = RequestMethod.POST)
	public boolean passChk(MemberVO vo) throws Exception {

		MemberVO login = service.login(vo);
		boolean pwdChk = pwdEncoder.matches(vo.getUserPass(), login.getUserPass());
		return pwdChk;
	}

	// 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value = "/idChk", method = RequestMethod.POST)
	public int idChk(MemberVO vo) throws Exception {
		int result = service.idChk(vo);
		return result;
	}
}
