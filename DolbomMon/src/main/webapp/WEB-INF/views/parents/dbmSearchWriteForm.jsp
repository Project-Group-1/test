<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/dbmSearchWriteForm.css" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="<%=request.getContextPath()%>/css/bootstrap.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/css/datepicker-ko.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8cff2cbe78d63774a9a2e7f0c1abec87&libraries=services"></script>
</head>
<script>
	$(function(){
		/////////////////// 페이지 로딩 시 //////////////////////
		$(document).ready(function(){
			///////////////////////////// 정기적으로 날짜 설정 요일 //////////////////////////////
			startTime(); // selectBox 설정
			for(var i=1;i<8;i++){
				if($("input[id=rd"+i+"]").is(":checked")){
					$("label[for=rd"+i+"]").css("background-color", "#ff5400").css("color", "white");
				}else{
					$("label[for=rd"+i+"]").css("background-color", "#EFEFEF");
				}
			}
			///////////////////////////// 정기적으로 날짜 설정 요일 //////////////////////////////
			
			for(var i=1;i<9;i++){
				var nowImg = $("label[for=pa"+i+"]").children("img").attr("src");
				if($("input[id=pa"+i+"]").is(":checked")){
					if(i=="2"){
						var changeImg = nowImg.replace("-n@", "-s@"); 
						$("label[for=pa"+i+"]").children("img").attr("src", changeImg);
						$("label[for=pa"+i+"]").css("background-color", "#ff5400");
					}else{
						var changeImg = nowImg.replace("-n.", "-s."); 
						$("label[for=pa"+i+"]").children("img").attr("src", changeImg);
						$("label[for=pa"+i+"]").css("background-color", "#ff5400");
					}
				}else{
					if(i=="2") {
						var changeImg = nowImg.replace("-s@", "-n@"); 
						$("label[for=pa"+i+"]").children("img").attr("src", changeImg);
						$("label[for=pa"+i+"]").css("background-color", "#EFEFEF");
					}else{
						var changeImg = nowImg.replace("-s.", "-n."); 
						$("label[for=pa"+i+"]").children("img").attr("src", changeImg);
						$("label[for=pa"+i+"]").css("background-color", "#EFEFEF");
					}
				}
			}
			
			for(var i=2;i<7;i++){
				if($("input[id="+i+"0]").is(":checked")){
					$("label[for="+i+"0]").parent().css("background-color", "#ff5400").css("color", "white");
				}else{
					$("label[for="+i+"0]").parent().css("background-color", "#EFEFEF").css("color", "black");
				}
			}
			
			for(var i=1;i<5;i++){
				if($("#childrenInfo>input[id=childrenCnt"+i+"]").is(":checked")){
					$("label[for=childrenCnt"+i+"]").css("background-color", "#ff5400");
					$("#childrenDetail").html("");
					var tag = ""
					tag += "<li><span class='cn'>자녀 이름</span><input class='cntext' type='text' name='child_name' /><br/>";
					tag += "<span class='cb'>자녀 생년월일</span><input class='cbtext' type='date' name='child_birth' /></li>";
					for(var j=0;j<i;j++){
						$("#childrenDetail").append(tag);
					}
				}else{
					$("label[for="+i+"]").css("background-color", "#EFEFEF");
				}
			}
			
			
			/////////////////// 페이지 로딩 시 //////////////////////
		});
		
		// 돌봄 유형 선택 시 색상 변경
		$("input[name=pw_activity]").change(function(){
			var selectedData = $(this).attr("id");
			var nowImg = $("label[for="+selectedData+"]").children("img").attr("src");
			if($(this).is(":checked")){
				if(selectedData=="2"){
					var changeImg = nowImg.replace("-n@", "-s@"); 
					$("label[for="+selectedData+"]").children("img").attr("src", changeImg);
					$("label[for="+selectedData+"]").css("background-color", "#ff5400");
				}else{
					var changeImg = nowImg.replace("-n.", "-s."); 
					$("label[for="+selectedData+"]").children("img").attr("src", changeImg);
					$("label[for="+selectedData+"]").css("background-color", "#ff5400");
				}
			}else{
				if(selectedData=="2") {
					var changeImg = nowImg.replace("-s@", "-n@"); 
					$("label[for="+selectedData+"]").children("img").attr("src", changeImg);
					$("label[for="+selectedData+"]").css("background-color", "#EFEFEF");
				}else{
					var changeImg = nowImg.replace("-s.", "-n."); 
					$("label[for="+selectedData+"]").children("img").attr("src", changeImg);
					$("label[for="+selectedData+"]").css("background-color", "#EFEFEF");
				}
			}
		});
		
		$("input[name=wish_age]").change(function(){
			
			var selectedData = $(this).attr("id");
			
			if($("input[id="+selectedData+"]").is(":checked")){
				
				$("label[for="+selectedData+"]").parent().css("background-color", "#ff5400").css("color", "white");
			}else{
				
				$("label[for="+selectedData+"]").parent().css("background-color", "#EFEFEF").css("color", "black");
			}
			
		});
		
		$("#childrenInfo>input[type=radio]").change(function(){
			for(var i=1;i<5;i++){
				if($("input[id=childrenCnt"+i+"]").is(":checked")){
					$("label[for=childrenCnt"+i+"]").css("background-color", "#ff5400");
					$("#childrenDetail").html("");
					var tag = ""
					tag += "<li><span class='cn'>자녀 이름</span><input class='cntext' type='text' name='child_name' /><br/>";
					tag += "<span class='cb'>자녀 생년월일</span><input class='cbtext' type='date' name='child_birth' /></li>";
					for(var j=0;j<i;j++){
						$("#childrenDetail").append(tag);
					}
				}else{
					$("label[for=childrenCnt"+i+"]").css("background-color", "#EFEFEF");
				}
			}
		});
		
		$("#zipcodeBtn").click(function(){
			new daum.Postcode({
		        oncomplete: function(data) {
		        	console.log("우편번호 => " + data.zonecode );
		        	console.log("도로명 주소 " + data.address )
		            console.log("시, 도 =>" + data.sido);
		            console.log("시군구 =>" + data.sigungu);
		            console.log("법정동명(동) => " + data.bname);
		            console.log("법정동명(읍, 면, 리) => " + data.bname1);
		            
		            var dongJuso = data.sido + " " + data.sigungu + " " + data.bname + " " + data.bname1;
		            console.log("동주소 =>" + dongJuso);
		            var geocoder = new kakao.maps.services.Geocoder();
		            
		            geocoder.addressSearch(dongJuso, function(result, status) {

		                // 정상적으로 검색이 완료됐으면 
		                 if (status === kakao.maps.services.Status.OK) {
							
							console.log("경도=> " + result[0].x);
							console.log("위도=> " + result[0].y);
		                	$("#lng").val(result[0].x);
		                	$("#lat").val(result[0].y);
		                } 
		            });
		           	window.close();
		        },theme:{
		        	searchBgColor: "#ff5400", //검색창 배경색
		            queryTextColor: "#FFFFFF" //검색창 글자색
		        }
		    }).open();
		});
		
		$(document).on('keyup','input[inputmode=numeric]',function(event){
			this.value = this.value.replace(/[^0-9]/g,'');  
			this.value = this.value.replace(/,/g,'');  
			if(this.value<8590){
				$(this).css("color", "gray");
				$("#minWage").html("최저시급(8590원)이상의 시급을 입력해주세요");
			}else {
				$(this).css("color", "white");
				$("#minWage").html("")
			}
		});
		
		$("input[id=avgWage]").change(function(){
			if(this.checked){
				$("#desired_wage").val("8600").attr("readonly", "readonly");
			}else{
				$("#desired_wage").prop("readonly", false);
			}
		});
		////////////////////////// 정기적으로 ////////////////////////// 
		$("#regularDateDiv #startDateBtn").datepicker({ // 시작일 데이트피커
			showAnim : "show",
			changeMonth : true,
			changeYear : true,
			yearRange : 'c-100:c',
			dateFormat : "yy-mm-dd",
			onSelect:function(dateText){
				$("#regularDateDiv #start_date").val(dateText);
				$("#regularDateDiv #startDateBtn").val("활동 시작일 선택");
			},
			altFormat:"yyyy-mm-dd"
		});
		
		// 요일 선택 시 색상변경
		$("input[name=yoil]").change(function(){
			var selectedData = $(this).attr("id");
			
			if($("input[id="+selectedData+"]").is(":checked")){
				$("label[for="+selectedData+"]").css("background-color", "#ff5400").css("color", "white");//노랑
			}else{
				$("label[for="+selectedData+"]").css("background-color", "#EFEFEF").css("color", "black");//회색
			}
		});
		////////////////////////// 정기적으로 ////////////////////////// 
		
		////////////////////////// 특정날선택 //////////////////////////
		
		$("#specificDateDiv #specificDateCal").datepicker({ // 고정 데이트피커
			showAnim : "show",
			maxDate : "+6m",
			minDate : "0", 
			yearRange : 'c-100:c',
			dateFormat : "yy-mm-dd",
			onSelect:function(dateText){
				$("#specificDateDiv #test").val(dateText);
			},
			altFormat:"yyyy-mm-dd"
		});
		
		
		
		
		
		
		
		
		
		/////////////////////////// 등록하기 버튼 누를 시 ////////////////////////
		$("#writeFrm").submit(function(){
			var wage = $("#desired_wage").val();
			if(wage==null || wage==""){
				alert("시급을 입력해주세요");
				return false;
			}else if(wage<8590){
				alert("시급은 최소 8590원 이상이어야합니다.");
				return false;
			}
			return true;
		});
		
		// 포커스 없애기
		$(":focus").blur();
	});

</script>

<script>
	function startTime(){ // 시작 시간
		var time = new Date(2020, 0, 1);
		var tag="";
		for(var i=1;i<=48;i++){
			if(time.getHours()<10 && time.getMinutes()==0) {
				tag += "<option id='rt"+i+"'>0"+time.getHours()+":0"+time.getMinutes()+"</option>";
			}else if(time.getHours()<10 && time.getMinutes()!=0){
				tag += "<option id='rt"+i+"'>0"+time.getHours()+":"+time.getMinutes()+"</option>";
			}else if(time.getHours()>10 && time.getMinutes()==0){
				tag += "<option id='rt"+i+"'>"+time.getHours()+":0"+time.getMinutes()+"</option>";
			}else if(time.getHours()>10 && time.getMinutes()!=0){
				tag += "<option id='rt"+i+"'>"+time.getHours()+":"+time.getMinutes()+"</option>";
			}
			time.setMinutes(time.getMinutes()+30);
		}
		document.getElementById("start_time").innerHTML = tag;
	}
	
	$(function(){
		$("#start_time").on('change' ,function(){
			var test = $("#start_time").val();
			var i=1;
			for(i;i<=48;i++){
				if($("#start_time option[id=rt"+i+"]").val()==test){
					endTime(i);
				}
			}
		});
	});
	
	function endTime(i){ // 종료 시간
		var time = new Date(2020, 0, 1);
		var tag="";
		time.setMinutes(time.getMinutes()+30*i);
		for(i;i<48;i++){
			if(time.getHours()<10 && time.getMinutes()==0) {
				tag += "<option>0"+time.getHours()+":0"+time.getMinutes()+"</option>";
			}else if(time.getHours()<10 && time.getMinutes()!=0){
				tag += "<option>0"+time.getHours()+":"+time.getMinutes()+"</option>";
			}else if(time.getHours()>10 && time.getMinutes()==0){
				tag += "<option>"+time.getHours()+":0"+time.getMinutes()+"</option>";
			}else if(time.getHours()>10 && time.getMinutes()!=0){
				tag += "<option>"+time.getHours()+":"+time.getMinutes()+"</option>";
			}else if(time.getHours()>=24){
				break;
			}
			time.setMinutes(time.getMinutes()+30);
		}
		document.getElementById("end_time").innerHTML = tag;
	}
</script>
<style>
 	.ui-datepicker:nth-of-type(1){width:50%;}
</style>
<body>
	<div class="container">
		<form id="writeFrm" method="post" action="<%=request.getContextPath()%>/dbmSearchWriteFormOk">
			<div id="header">
				<a href="<%=request.getContextPath()%>/"><img src="<%=request.getContextPath()%>/img/logo.png"/></a>
			</div>
			<div class="title">어떤 돌봄을 원하세요?</div>
			<input type="checkbox" id="pa1" name="pw_activity" value="실내놀이"/>		
			<input type="checkbox" id="pa2" name="pw_activity" value="등하원돕기"/>		
			<input type="checkbox" id="pa3" name="pw_activity" value="영어놀이"/>	
			<input type="checkbox" id="pa4" name="pw_activity" value="한글놀이"/>		
			<input type="checkbox" id="pa5" name="pw_activity" value="학습지도"/>	
			<input type="checkbox" id="pa6" name="pw_activity" value="야외활동"/>	
			<input type="checkbox" id="pa7" name="pw_activity" value="밥챙겨주기"/>	
			<input type="checkbox" id="pa8" name="pw_activity" value="책읽기"/>
			<div id="activityListDiv">
				<div><label for="pa1" ><img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/joinNew/p-membership-2-indooricon-n.svg"/></label><span>실내놀이</span></div>
				<div><label for="pa2" ><img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/joinNew/p-membership-2-guideicon-n@3x.png" style="width:38px; height:38px;"/></label><span>등하원돕기</span></div>
				<div><label for="pa3" ><img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/joinNew/p-membership-2-englishicon-n.svg"/></label><span>영어놀이</span></div>
				<div><label for="pa4" ><img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/joinNew/p-membership-2-koreanicon-n.svg"/></label><span>한글놀이</span></div>
				<div><label for="pa5" ><img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/joinNew/p-membership-2-koreanicon-n.svg"/></label><span>학습지도</span></div>
				<div><label for="pa6" ><img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/joinNew/p-membership-2-ousideicon-n.svg"/></label><span>야외활동</span></div>
				<div><label for="pa7" ><img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/joinNew/p-membership-2-eaticon-n.svg"/></label><span>밥챙겨주기</span></div>
				<div><label for="pa8" ><img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/joinNew/p-membership-2-readicon-n.svg"/></label><span>책읽기</span></div>
			</div>
			
			<div id="ageDiv">
				<div class="title">	어느 나이대의 돌봄몬을 원하시나요?</div>
				<input type="checkbox" id="20" name="wish_age" value="20대" checked="checked"/>
				<input type="checkbox" id="30" name="wish_age" value="30대" checked="checked"/>
				<input type="checkbox" id="40" name="wish_age" value="40대" checked="checked"/>
				<input type="checkbox" id="50" name="wish_age" value="50대" />
				<input type="checkbox" id="60" name="wish_age" value="60대" />
				<ul>
					<li><label for="20">20</label></li>
					<li><label for="30">30</label></li>
					<li><label for="40">40</label></li>
					<li><label for="50">50</label></li>
					<li><label for="60">60</label></li>
				</ul>
			</div>
			
			<div class="title" >자녀의 정보를 입력해주세요</div>
			<div>
				<div id="childrenInfo">
					<input type="radio" id="childrenCnt1" name="childrenCnt"/>
					<input type="radio" id="childrenCnt2" name="childrenCnt"/>
					<input type="radio" id="childrenCnt3" name="childrenCnt"/>
					<input type="radio" id="childrenCnt4" name="childrenCnt"/>
					<div id=childrenCnt>
						<div><label for="childrenCnt1">1명</label></div>
						<div><label for="childrenCnt2">2명</label></div>
						<div><label for="childrenCnt3">3명</label></div>
						<div><label for="childrenCnt4">4명</label></div>
					</div>
					<div id="childrenDetailDiv">
						<ul id="childrenDetail"></ul>
					</div>
				</div>
			</div>
			
			<div class="title">
				돌봄 장소를 입력해주세요<br/>
				<span style="color:gray;font-size:14px;">매칭이 되기전까지 자세한 위치는 보여지지 않습니다.</span>
			</div>
			<div>
				<div>
					
				</div>
				<div id="zidcodeBtnDiv">
					<input type="button" id="zipcodeBtn" value="돌봄 장소를 입력해주세요" />
				</div>
			</div>
			
			<div class="title">언제 돌봐드릴까요?</div>
			<div id="timeTypeDiv">
				<input type="radio" id="timeType1" name="timeType"/>
				<input type="radio" id="timeType2" name="timeType"/>
				<label for="timeType1">정기적으로</label>
				<label for="timeType2">특정날에만</label>
				<div id="specificDateDiv">
					<div class="title">특정날에만</div>
					<div id="specificDateCal"></div>
					<input type="text" id="test" />
				</div>
				<div id="regularDateDiv">
					<div class="title">정기적으로</div>
					<div id="startDateDiv">
						<input type="button" id="startDateBtn" value="활동 시작일 선택" />
						<input type="text" id="start_date" name="start_date" readonly="readonly" />
					</div>
					<div id="selectDayDiv">
						<input type="checkbox" id="rd1" name="yoil" value="월" />
						<input type="checkbox" id="rd2" name="yoil" value="화" />
						<input type="checkbox" id="rd3" name="yoil" value="수" />
						<input type="checkbox" id="rd4" name="yoil" value="목" />
						<input type="checkbox" id="rd5" name="yoil" value="금" />
						<input type="checkbox" id="rd6" name="yoil" value="토" />
						<input type="checkbox" id="rd7" name="yoil" value="일" />
						<ul>
							<li><label for="rd1">월</label></li>
							<li><label for="rd2">화</label></li>
							<li><label for="rd3">수</label></li>
							<li><label for="rd4">목</label></li>
							<li><label for="rd5">금</label></li>
							<li><label for="rd6">토</label></li>
							<li><label for="rd7">일</label></li>
						</ul>
					</div>
					<div id="timeDiv">
						<div id="startDiv">
							<span>시작 시간</span><br/>		
							<select id="start_time" name="start_time" onselect="endTime();">
							
							</select>
						</div>
						<div id="endDiv">
							<span>종료 시간</span><br/>
							<select id="end_time" name="end_time">
								<option>종료시간</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			
			<div class="title">희망시급을 입력해주세요.</div>
			<div id="paymentDiv">
				<img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/joinNew/s-membership-07-mainimage.svg" />
				<div>
					<input type="number" inputmode="numeric" id="desired_wage" name="desired_wage" maxlength="6" value="8590" style="color:white;"/><span>원/1시간</span>
				</div>
				<span id="minWage" style="color:orange">
					
				</span>
				<label for="avgWage" style="width:100%;"><input type="checkbox" id="avgWage"  style="width:10%;"/><span style="width:90%;">평균시급 적용</span></label>
				<p>
					아이 1명을 돌보는 경우 - 최저시급 8590원 이상 필수<br/>
					아이 2명을 돌보는 경우 - 희망시급의 1.5배 수준으로 합의
				</p>
			</div>
			
			<div class="title">돌봄몬이 알아야 할 내용이 있나요?</div>
			<div id="descriptionDiv">
				<textarea name="content" placeholder="아이의  성격, 특이사항 등을 적어주세요."></textarea>
				<div id="warningDiv"><img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/joinNew/s-membership-09-nono-icon.svg"/><p>자기소개 내용에 연락처, 이메일, 카카오ID 등을 작성할 경우 회원 자격을 영구적으로 잃게 됩니다.</p></div>
			</div>
			
			<div class="title">입력한 정보를 확인 후 등록해주세요</div>
			<div style="text-align:center;"><input type="submit" value="등록하기" /></div>
			
			<div id="footer"></div>
		</form>
	</div>
</body>
</html>