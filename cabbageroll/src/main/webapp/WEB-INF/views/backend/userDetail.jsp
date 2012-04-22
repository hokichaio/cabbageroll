<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="./com/meta.jsp"%>	
</head>
<body>
	<%@ include file="./com/header.jsp"%>
	<div class="container">
	
		<h2><img src="https://graph.facebook.com/${user.id}/picture" />${user.name}</h2>
		<hr/>
		<div class="tabbable">
			<ul class="nav nav-tabs" >
				<li class="active"><a href="#basicInfo" data-toggle="tab">BasicInfo</a></li>
			    <li><a href="#education" data-toggle="tab">Education</a></li>
			    <li><a href="#work" data-toggle="tab">Work</a></li>
			    <li><a href="#interest" data-toggle="tab">Interest</a></li>
			</ul>
			<div class="tab-content right" >
				<div class="tab-pane active" id="basicInfo">
			    	<p>Gender: ${user.gender}</p>
			    	<p>Birthday: ${user.birthday}</p>
			    	<p>Languages:
			    		<c:forEach var="l" items="${user.languages}" >
			    		${l.name},
			    		</c:forEach>
			    	</p>
			    	<p>Locale: ${user.locale}</p>
			    	<p>Link: <a href="${user.link}">${user.link}</a></p>
			    	<p>Website: ${user.website}</p>
			    	<p>Email: ${user.email}</p>
			    	<p>ThirdPartyId: ${user.thirdPartyId}</p>
			    	<p>Timezone: ${user.timezone}</p>
			    	<p>UpdatedTime: ${user.updatedTime}</p>
			    	<p>About: ${user.about}</p>
			    	<p>Bio: ${user.bio}</p>
			    	<p>Location: ${user.location.name}</p>
			    	<p>Hometown: ${user.hometown.name}</p>
			    	<p>Religion: ${user.religion}</p>
			    	<p>Political: ${user.political}</p>
			    	<p>Quotes: ${user.quotes}</p>
			    	<p>RelationshipStatus: ${user.relationshipStatus}</p>
			    	<p>SignificantOther: ${user.significantOther.name}</p>
			    	
			    </div>
			    <div class="tab-pane" id="education">
			    	<c:forEach var="e" items="${user.education}" >
				    	<p>School: ${e.school.name}</p>
				    	<p>Year: ${e.year.name}</p>
				    	<p>Type: ${e.type}<p>
				    	<p>Concentration: 
				    		<c:forEach var="c" items="${e.concentration}" >
				    			${c.name},
				    		</c:forEach>
				    	</p>
				    	<br/>
			    	</c:forEach>
			    </div>
			    <div class="tab-pane" id="work">
			    	<c:forEach var="w" items="${user.work}" >
				    	<p>Employer: ${w.employer.name}</p>
				    	<p>StartDate: ${w.startDate}</p>
				    	<p>EndDate: ${w.endDate}<p>
				    	<br/>
			    	</c:forEach>
			    </div>
			     <div class="tab-pane" id="interest">
			    	<p>InterestedIn: 
			    	<c:forEach var="i" items="${user.interestedIn}" >
			    		${i}
			    	</c:forEach>
			    	</p>
			    	<p>InspirationalPeople:
			    	<c:forEach var="ip" items="${user.inspirationalPeople}" >
			    		${ip.name},
			    	</c:forEach>
			    	</p>
			    	<p>Sports:
			    	<c:forEach var="s" items="${user.sports}" >
			    		${s.name},
			    	</c:forEach>
			    	</p>
			    	<p>FavoriteTeams:
			    	<c:forEach var="f" items="${user.favoriteTeams}" >
			    		${f.name},
			    	</c:forEach>
			    	</p>
			    	<p>FavoriteAthletes:
			    	<c:forEach var="a" items="${user.favoriteAthletes}" >
			    		${a.name},
			    	</c:forEach>
			    	</p>
			    </div>
			</div>
		</div>
	</div>
</body>
</html>




