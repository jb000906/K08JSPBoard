<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../member/IsLoggedIn.jsp" %>
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
            
            <form action="WriteProcess.jsp" 
            name="writeFrm" method="post" onsubmit="return validateForm(this);">
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
                            <input type="text" class="form-control" name="title" />
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">내용</th>
                        <td>
                            <textarea name="content" rows="5" class="form-control"></textarea>
                        </td>
                    </tr>
                </tbody>
                </table>

                <!-- 각종버튼 -->
                <div class="row mb-3">
                    <div class="col d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">작성완료</button>
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