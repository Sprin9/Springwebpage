package kr.co.vo;

import java.util.Date;

public class MemberVO {

	private String userId;
	private String userPass;
	private String ChangeuserPass;
	private String userName;
	private Date regDate;
	private boolean useCookie;
	
	public String getChangeuserPass() {
		return ChangeuserPass;
	}
	public void setChangeuserPass(String changeuserPass) {
		ChangeuserPass = changeuserPass;
	}
	public boolean isUseCookie() {
		return useCookie;
	}
	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPass() {
		return userPass;
	}
	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	@Override
	public String toString() {
		return "MemberVO [userId=" + userId + ", userPass=" + userPass + ", userName=" + userName + ", regDate="
				+ regDate + "]";
	}
	
}