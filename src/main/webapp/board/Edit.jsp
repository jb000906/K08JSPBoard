<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../member/IsLoggedIn.jsp" %>
<%
String num= request.getParameter("num");//게시물의 일련번호
BoardDAO dao = new BoardDAO(application);//DB연결(DAO)
BoardDTO dto = dao.selectView(num);//게시물 조회
//세션영역에 저장된 회원아이디를 얻어와서 문자열의 형태로 변환
String sessionId= session.getAttribute("UserId").toString();
/*  
본인이 작성한 글이 아니어도 URL패턴을 분석하면 수정페이지로 진입할 수
있으므로 페이지 진입전 본인확인을 추가로 하는 것이 안전하다.
*/
if(!sessionId.equals(dto.getId())){
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
	return;
}
%>

<%@ include file="./commons/header.jsp" %>
<script>
function validateForm(form) {
	if(form.title.value==""){
		alert("제목을 입력하세요.");
		form.title.focus();
		return false;
	}
	if(form.content.value==""){
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
</script>
<body>
<div class="container">
    <!-- Top영역 -->
    <%@ include file = "./commons/top.jsp" %>
    <!-- Body영역 -->
    <div class="row">
        <!-- Left메뉴영역 -->
        <%@ include file="./commons/left.jsp" %>
        <!-- Contents영역 -->
        <div class="col-9 pt-3">
            <h3>게시판 작성 - <small>자유게시판</small></h3>
            
            <form action="EditProcess.jsp" name="writeFrm" method="post"
				onsubmit="return validateForm(this);">
				<!--게시물의 일련번호를 서버로 전송하기 위해 hidden타입의 입력상자가 필요하다.(중요)
				일련번호를 통해 입력, 삭제합니당  -->
				<input type="hidden" name="num" value="<%=dto.getNum()%>" />
                <table class="table table-bordered">
                <colgroup>
                    <col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">제목</th>
                        <td>
                            <input type="text" class="form-control" name="title" value="<%=dto.getTitle() %>" />
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">내용</th>
                        <td>
                            <textarea name="content" rows="5" class="form-control"><%=dto.getContent() %></textarea>
                        </td>
                    </tr>
                </tbody>
                </table>

                <!-- 각종버튼 -->
                <div class="row mb-3">
                    <div class="col d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">수정완료</button>
                        <button type="button" class="btn btn-warning" onclick="location.href='listT.jsp';">목록보기</button>
                        <button type="reset" class="btn btn-dark">다시 입력</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- Copyright영역 -->
    <%@ include file="./commons/copyright.jsp" %>
</div>
</body>
</html>