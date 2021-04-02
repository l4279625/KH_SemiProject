<%@page import="com.login.dto.RegistDto"%>
<%@page	import="org.apache.commons.collections.bag.SynchronizedSortedBag"%>
<%@page import="com.mypage.dto.IndividualDto"%>
<%@page import="java.util.List"%>
<%@page import="com.mypage.common.Util"%>
<%@page import="com.mypage.biz.IndividualBizImpl"%>
<%@page import="com.mypage.biz.IndividualBiz"%>
<%@page import="com.mypage.dao.IndividualDao"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	request.setCharacterEncoding("UTF-8");%>
<%	response.setContentType("text/html; charset=UTF-8");%>
<%
	Calendar cal = Calendar.getInstance();

	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1;

	
	String paramYear = request.getParameter("year");
	String paramMonth = request.getParameter("month");
	
	if (paramYear != null) {
		year = Integer.parseInt(paramYear);
	}
	if (paramMonth != null) {
		month = Integer.parseInt(paramMonth);
	}

	if (month > 12) {
		month = 1;
		year++;
	}

	if (month < 1) {
		month = 12;
		year--;
	}

	cal.set(year, month - 1, 1);
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="./assets/css/mypage.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="assets/js/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<% RegistDto Ldto = (RegistDto) session.getAttribute("Ldto"); %>
<style type="text/css">
	#profile-img{
		width: 150px;
		height: 150px;
	}
</style>
</head>
<body>
<%--마이페이지! --%>


	<div class="mypage-main-div">
		<div class="mypage-second-div1">
			<div class="mypage-profile-div">
				<table border="1">
					<tr>
						<td colspan="2">
							<c:choose>
								<c:when test="${dto.getMember_picture_path() == null}">
									대표 프로필 사진이 존재하지 않습니다<br>프로필 사진을 등록해주세요!
								</c:when>
								<c:otherwise>
 
									<img src="../../profileimg/<%=Ldto.getMember_picture_path()%>?" id="profile-img" />

								</c:otherwise>
							</c:choose>
						</td>
						<td rowspan="4">
							<form action="../../profile.do?member_email=<%=Ldto.getMember_email()%>" method="post" enctype="multipart/form-data">
								<input type="file" name="filename" size='20'><br>
								<input type="submit" value="프사변경">
							</form>
						</td>
					</tr>
					<tr>
						<th colspan="2" align="center"><%=Ldto.getMember_id() %></th>
					</tr>
					<tr>
						<th>회원등급</th>
						<th>매너점수</th>
					</tr>
					<tr>
						<td align="center"><%=Ldto.getMember_role() %></td>
						<td align="center">
							<c:choose>
								<c:when test="${Ldto.getMember_review() == 0}">
									----------
								</c:when>
								<c:otherwise>
									<%=Ldto.getMember_review() %>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td colspan="3">자기소개란!</td>
					</tr>

				</table>
			</div>
			<div class="mypage-list-div">
				<table>
					<tr>
						<th>계정 관리</th>
					</tr>
					<tr>
						<td>
							<ul>
								<li><a href="../../mypage.do?command=registUpdate">회원정보 수정</a></li>
								<li><a href="../../payment.do?command=paymentRoleUp&member_role=<%=Ldto.getMember_role()%>">프리미엄 등록</a></li>
								<li><a href="../../payment.do?command=paymentRoleDown&member_role=<%=Ldto.getMember_role()%>">프리미엄 탈퇴</a></li>
								<li><a href="../../payment.do?command=paymentListMy&member_email=<%=Ldto.getMember_email()%>">나의 결제내역</a>
								<li><a href="../../payment.do?command=paymentList">모든회원결제내역(admin)</a>
							</ul>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="mypage-second-div2">
		
		
			<div style="width:800px" style="float: left;">
				<canvas id="myChart"></canvas>
			</div>
			
			
			
			
			
			<div class="mypage-calendar-div">





				<table id="calendar">
					<caption>
						<a href="mypage.jsp?year=<%=year - 1%>&month=<%=month%> ">◁</a>
						<a href="mypage.jsp?year=<%=year%>&month=<%=month - 1%> ">◀</a> 
						<span class="y"><%=year%></span>년 
						<span class="m"><%=month%></span>월 
						<a href="mypage.jsp?year=<%=year%>&month=<%=month + 1%> ">▶</a>
						<a href="mypage.jsp?year=<%=year + 1%>&month=<%=month%> ">▷</a>
					</caption>

					<tr>
						<th>일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th>토</th>
					</tr>

					<tr>
						<%
							for (int i = 0; i < dayOfWeek - 1; i++) {
								out.print("<td></td>");
							}
						for (int i = 1; i <= lastDay; i++) {
						%>
						<td class="countBackground"><a class="countview"
							href="../../individual.do?command=individualList&individual_id=<%=Ldto.getMember_id()%>&year=<%=year%>&month=<%=month%>&date=<%=i%>"
							style="color: <%=Util.fontColor(i, dayOfWeek)%>"><%=i%></a></td>
						<%
							if ((dayOfWeek - 1 + i) % 7 == 0) {
								out.print("</tr><tr>");
							}
						}

						for (int i = 0; i < (7 - (dayOfWeek - 1 + lastDay) % 7) % 7; i++) {
							out.print("<td></td>");
						}
						%>
					</tr>

				</table>

			</div>
		</div>
		
		
		
		
		<div class="mypage-second-div3">
			<div class="mypage-basket-div">찜한게시물</div>
			<div class="mypage-follw-div">팔로우</div>
		</div>
	</div>
	
<script type="text/javascript">
	function isTwo(n){
		n = n+'';
		return (n.length<2)?"0"+n:n;
	}
	
	$(function(){
		var individual_id = "<%=Ldto.getMember_id()%>";
		var today = new Date();
		var date = today.getDate();
		var month = today.getMonth()+1 ;
		var year = today.getFullYear();
		var yyyyMMdd = '' + year + isTwo(month) + isTwo(date);
		
		$.ajax({
			type: "post",
			url: "../../chart.do?command=healthRecord&individual_id="+individual_id,
			dataType: "json",
			success: function(msg){
				var todayHealth = msg.todayHealth;
				var yesterdayHealth = msg.yesterdayHealth;
				var twoAgodayHealth = msg.twoAgodayHealth;
				var threeAogdayHealth = msg.threeAogdayHealth;
				var fourAgodayHealth = msg.fourAgodayHealth;
				var fiveAgodayHealth = msg.fiveAgodayHealth;
				var sixAgodayHealth = msg.sixAgodayHealth;
				
				console.log(todayHealth);
				console.log(yesterdayHealth);

				var today = new Date();
				var todayDate = today.getFullYear()+'.'+(today.getMonth()+1)+'.'+today.getDate();

				new Date(today.setDate(today.getDate() - 1));
				var yesterdayDate = today.getFullYear()+'.'+(today.getMonth()+1)+'.'+today.getDate();

				new Date(today.setDate(today.getDate() - 1));
				var twoAgoDate = today.getFullYear()+'.'+(today.getMonth()+1)+'.'+today.getDate();
				
				new Date(today.setDate(today.getDate() - 1));
				var threeAgoDate = today.getFullYear()+'.'+(today.getMonth()+1)+'.'+today.getDate();
				
				new Date(today.setDate(today.getDate() - 1));
				var fourAgoDate = today.getFullYear()+'.'+(today.getMonth()+1)+'.'+today.getDate();
				
				new Date(today.setDate(today.getDate() - 1));
				var fiveAgoDate = today.getFullYear()+'.'+(today.getMonth()+1)+'.'+today.getDate();
				
				new Date(today.setDate(today.getDate() - 1));
				var sixAgoDate = today.getFullYear()+'.'+(today.getMonth()+1)+'.'+today.getDate();
				
				var ctx = document.getElementById("myChart").getContext('2d');
				/*
				- Chart를 생성하면서, 
				- ctx를 첫번째 argument로 넘겨주고, 
				- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줌
				*/
				var myChart = new Chart(ctx, {
				    type: 'line',
				    data: {
				        labels: [sixAgoDate, fiveAgoDate, fourAgoDate, threeAgoDate, twoAgoDate, yesterdayDate, todayDate],
				        datasets: [{
				            label: '운동시간(분)',
				            data: [sixAgodayHealth, fiveAgodayHealth, fourAgodayHealth, threeAogdayHealth, twoAgodayHealth, yesterdayHealth, todayHealth],
				            backgroundColor: [
				                'rgba(255, 99, 132, 0.2)'
				            ],
				            borderColor: [
				                'rgba(255,99,132,1)'
				            ],
				            borderWidth: 1
				        }]
				    },
				    options: {
				        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
				        scales: {
				            yAxes: [{
				                ticks: {
				                    beginAtZero:true
				                }
				            }]
				        }
				    }
				});
				
			},
			error: function(){
				alert("통신실패");
			}
		});
	});
</script>

<%--
	<%@ include file="../common/footer.jsp" %>
 --%>
</body>
</html>
