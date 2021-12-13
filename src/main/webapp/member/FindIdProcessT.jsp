<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//로그인 폼에서 사용자가 입력한 아이디, 패스워드 받기
String id=request.getParameter("id");
String name=request.getParameter("name");

//application 내장객체를 통해 web.xml에 저장된 오라클 접속정보를 읽어옴
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

//JDBC를 통해 오라클 접속
MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
String findId=dao.findIdView(name);
//받아온 아이디,패스워드를 매개변수로 getMemberDTO()호출. 회원인증 시도
//자원해제
dao.close();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>아이디찾기</h3>
	<%if(findId !=""){ %>
	<p>아이디는 <%=findId %>입니다.</p>
	<%}else{ %>
	<p>이름을 확인해주세요</p>
	<%} %>
</body>
</html>