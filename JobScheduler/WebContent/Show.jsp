<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="bean.Process" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Algorithm Details</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<style type="text/css">
			.card-img-top {
				height: 12vw;
			}
			.centered-card {
				display: flex;
				justify-content: center;
				align-items: center;
				height: 100vh;
			}
			.list-group-item{
				border-radius: 5px;
			}
			.card{
				margin-top: 30px;
			}
			body{
				background-color: #e6e2da;
			}
		</style>
	</head>
	
	<body>
		<%
			List<Process>processList = (List<Process>)session.getAttribute("processList");
			request.setAttribute("processList", processList);
		%>
	<div class="container">
		<div class="container text-center">
			<div class="row justify-content-md-center">
				<c:forEach var ="i" items="${processList}">	
					<div class="col">
						<div class="card text-dark bg-info mb-3" style="width: 18rem;">
				  			<img src="images/process.jpg" class="card-img-top" alt="...">
				  			<div class="card-body">
				    			<h5 class="card-title">${i.getProcessName()}</h5>
			  					<ul class="list-group">
			    					<li class="list-group-item list-group-item-primary">Process Name: ${i.getProcessName()} </li>
			    					<li class="list-group-item list-group-item-secondary">Arrival Time: ${i.getArrivalTime()}</li>
								    <li class="list-group-item list-group-item-success">Burst Time: ${i.getBurstTime()}</li>
								    <li class="list-group-item list-group-item-danger">Priority: ${i.getPriority()}</li>
								    <li class="list-group-item list-group-item-warning">Completion Time: ${i.getCompletionTime()}</li>
								    <li class="list-group-item list-group-item-info">Turn Around Time: ${i.getTurnAroundTime()}</li>
								    <li class="list-group-item list-group-item-light">Waiting Time: ${i.getWaitingTime()}</li>
								  </ul>
								</div>
					  		</div>
					  	</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>
<!-- In this page we iterate the values of the particular algorithm process and display it -->