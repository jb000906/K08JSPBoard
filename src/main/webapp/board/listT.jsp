<%@page import="java.util.List"%>
<%@page import="utils.BoardPage"%>
<%@page import="java.util.HashMap"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="java.util.Map"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//DAO 객체 생성 및 DB연결
BoardDAO dao =new BoardDAO(application);

//검색어가 있는 경우 파라미터를 저장하기 위한 Map컬렉션 생성
Map<String,Object> param =new HashMap<String,Object>();
//검색 파라미터를 request 내장객체를 통해 얻어온다.
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
//검색어가 있는 경우에만
if(searchWord !=null){
	//Map컬렉션에 파라미터 값을 추가한다.
	param.put("searchField", searchField);//검색필드명(title,content 등)
	param.put("searchWord", searchWord);//검색어
}
//board테이블에 저장된 게시물의 갯수 카운트
int totalCount = dao.selectCount(param);



/***페이지 처리 start***/
//컨텍스트 초기화 파라미터를 얻어온 후 사칙연산을 위한 정수로 변경한다.
int pageSize=Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage=Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
//전체 페이지 수를 계산한다. 소수점을 얻기 위해 double로 형변환 후 나눈다.
int totalPage= (int)Math.ceil((double)totalCount/pageSize);
/*  
목록에 첫 진입시에는 페이지 관련 파라미터가 없으므로 무조건 1page로 지정한다.
만약 pageNum이 있다면 파라미터를 받아와서 정수로 변경한 후 페이지수로 지정한다.
*/
int pageNum=1;
//pageTemp에 잠깐 저장
String pageTemp = request.getParameter("pageNum");
if(pageTemp != null&&!pageTemp.equals(""))
	pageNum=Integer.parseInt(pageTemp);
//게시물의 구간을 계산한다.
int start=(pageNum-1)*pageSize+1;//구간의 시작
int end=pageNum*pageSize;//구간의 끝
param.put("start",start);//Map컬렉션에 저장 후 DAO로 전달함
param.put("end", end);
/***페이지 처리 end***/





//출력할 레코드 추출
List<BoardDTO> boardLists = dao.selectListPage(param);//게시물 목록 받기
//DB작업 끝났으므로 자원 해제
dao.close();
%>
<%@ include file="./commons/header.jsp" %>
<body>
<div class="container">
    <!-- Top영역 -->
    <%@ include file = "./commons/top.jsp" %>
    <!-- Body영역 -->
    <div class="row">
        <!-- Left메뉴영역 -->
        <%@ include file = "./commons/left.jsp" %>
        <!-- Contents영역 -->
        <div class="col-9 pt-3">
            <h3>게시판 목록 - <small>자유게시판</small></h3>
            <!-- 검색 -->
            <div class="row">
                <form method="get">
                    <div class="input-group ms-auto" style="width: 400px;">
                        <select name="searchField" class="form-control">
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                        </select>
                        <input type="text" class="form-control" placeholder="Search" name="searchWord" style="width: 200px;">
                        <button class="btn btn-success" type="submit">
                            <i class="bi-search" style="font-size: 1rem; color: white;"></i>
                        </button>
                    </div>
                </form>
            </div>
            <!-- 게시판 리스트 -->
            <div class="row mt-3 mx-1">
                <table class="table table-bordered table-hover table-striped">
                <thead>
                    <tr class="text-center">
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th>첨부</th>
                    </tr>
                </thead>
                <tbody>
<%
if(boardLists.isEmpty()){
%>
	<tr class="text-center">
		<td colspan="6" align="center">
			등록된 게시물이 없습니다^^*
		</td>
	</tr>
<%
}
else{
	//게시물이 있을때
	int virtualNum=0;//게시물의 출력번호(가상번호)
	int countNum=0;
	//확장 for문을 통해 List컬렉션에 저장된 레코드의 갯수만큼 반복한다.
	for(BoardDTO dto:boardLists)
	{
		//전체 레코드 수를 1씩 차감하면서 번호를 출력
		//virtualNum = totalCount--;
		virtualNum = totalCount-(((pageNum-1)*pageSize)+countNum++);
%>
		<tr align="center">
			<td><%=virtualNum %></td>
			<td class="text-start">
				<a href="viewT.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle()%></a>
			</td>
			<td align="center"><%=dto.getId()%></td>
			<td align="center"><%=dto.getPostdate()%></td>
			<td align="center"><%=dto.getVisitcount()%></td>
			<td><i class="bi-pin-angle-fill" style="font-size: 1rem;"></i></td>
		</tr>
<%
	}
}
%>
    </table>
                </tbody>
                </table>
            </div>
            <!-- 각종버튼 -->
            <div class="row">
                <div class="col d-flex justify-content-end">
                    <button type="button" class="btn btn-primary" onclick="location.href='writeT.jsp';">글쓰기</button>
                    <button type="button" class="btn btn-secondary">수정하기</button>
                    <button type="button" class="btn btn-success">삭제하기</button>
                    <button type="button" class="btn btn-info">답글쓰기</button>
                    <button type="button" class="btn btn-warning">목록보기</button>
                    <button type="button" class="btn btn-danger">전송하기</button>
                    <button type="button" class="btn btn-dark">다시쓰기</button>
                </div>
            </div>
            <!-- 페이지 번호 -->
            <div class="row mt-3">
                <div class="col">
                    <ul class="pagination justify-content-center">
                        <%=BoardPage.pagingStr(totalCount,pageSize,
        				blockPage, pageNum, request.getRequestURI()) %>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- Copyright영역 -->
    <%@ include file="./commons/copyright.jsp" %>
</div>
</body>
</html>








