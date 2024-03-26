<%@page import="bean.Result"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Comparator" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>The Best Strategy</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<style type="text/css">
		    body{
		    background-color:#E55858;
		    }
			.card-img-top {
				height: 12vw;
			}
			.centered-card {
				display: flex;
				justify-content: center;
				align-items: center;
				height: 100vh;
				
			}
			
			.card{
				transition : transform 0.2sec ease-in-out;
				margin-top:30px;
				border-radius: 20px;
			}
			.card:hover{
				transform : scale(1.1);
				border-width: 5px;
				border-color: #15edd8;
				box-shadow: 5px 5px 0px 0px #06095c;
				}
			#gobtn{
				width:100px;
			}
		</style>
	</head>
	<body>
		<%
		Object attribute = session.getAttribute("resultList");
		List<Result> resultList = null;
		if(attribute instanceof List){
		List<?> tempResultList = (List<?>)attribute;
		if(tempResultList!=null && tempResultList.get(0) instanceof Result)
		resultList = (List<Result>) tempResultList;		
		}
		%>
		
		<div class="container">
			<div class="container text-center">
				<div class="row justify-content-md-center">
						 
					<div class="col">
						<div class="card h-100" style="width: 18rem;">
							<img src="images/SJFimg.png" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title">Shortest Job First</h5>
								<table class="table">
									<tbody>
										<tr>
											<td scope="row">1</td>
											<td>Process Execution Order</td>
											<th><%= resultList.get(0).getProcessOrder() %></th>
										</tr>
						
										<tr>
											<td scope="row">2</td>
											<td>Average Waiting Time</td>
											<th><%= resultList.get(0).getAverageWaitingTime()%></th>
										</tr>
										
										<tr>
											<td scope="row">3</td>
											<td>Total Process Completion Time</td>
											<th><%= resultList.get(0).getCompletionTime() %></th>
										</tr>
									</tbody>
								</table>
						</div>
						<form id="form-1" action="Servlet3">
							<input  type="hidden" value="0" name="index" />
							<input type="submit" value="Go" id="gobtn" class="btn btn-primary"></input>
						</form>
					</div>
				</div>
				
				<div class="col">
					<div class="card h-100" style="width: 18rem;">
						<img src="images/fcfs.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">First Comes First Scheduled</h5>
							<table class="table">
								<tbody>
									<tr>
										<td scope="row">1</td>
										<td>Process Execution Order</td>
										<th><%= resultList.get(1).getProcessOrder() %></th>
									</tr>
									
									<tr>
										<td scope="row">2</td>
										<td>Average Waiting Time</td>
										<th><%= resultList.get(1).getAverageWaitingTime()%></th>
									</tr>
									
									<tr>
										<td scope="row">3</td>
										<td>Total Process Completion Time</td>
										<th><%= resultList.get(1).getCompletionTime() %></th>
									</tr>	
								</tbody>
							</table>
						</div>
						<form id="form-1" action="Servlet3">
							<input  type="hidden" value="1" name="index" />
							<input type="submit" value="Go" id="gobtn" class="btn btn-primary"/>
						</form>
					</div>
				</div>

				<div class="col">
					<div class="card h-100" style="width: 18rem;">
						<img src="images/priorityimg.jpg" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">Priority Scheduling</h5>
							<table class="table">
								<tbody>
									<tr>
										<td scope="row">1</td>
										<td>Process Execution Order</td>
										<th><%= resultList.get(3).getProcessOrder() %></th>
									</tr>
									
									<tr>
										<td scope="row">2</td>
										<td>Average Waiting Time</td>
										<th><%= resultList.get(3).getAverageWaitingTime()%></th>
								   </tr>
								   
									<tr>
										<td scope="row">3</td>
										<td>Total Process Completion Time</td>
										<th><%= resultList.get(3).getCompletionTime() %></th>
									</tr>
								</tbody>
							</table>
						</div>
						<form id="form-1" action="Servlet3">
							<input  type="hidden" value="3" name="index" />
							<input type="submit" value="Go" id="gobtn" class="btn btn-primary"/>
						</form>
					</div>
				</div>
				
				<div class="col">
					<div class="card h-100" style="width: 18rem;">
						<img src="images/RR.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">Round Robin Scheduling</h5>
							<table class="table">
								<tbody>
									<tr>
										<td scope="row">1</td>
										<td>Process Execution Order</td>
										<th><%= resultList.get(2).getProcessOrder() %></th>
									</tr>
									
									<tr>
										<td scope="row">2</td>
										<td>Average Waiting Time</td>
										<th><%= resultList.get(2).getAverageWaitingTime()%></th>
									</tr>
									
									<tr>
										<td scope="row">3</td>
										<td>Total Process Completion Time</td>
										<th><%= resultList.get(2).getCompletionTime() %></th>
									</tr>		
								</tbody>
							</table>
						</div>
						<form id="form-1" action="Servlet3">
							<input  type="hidden" value="2" name="index" />
							<input type="submit" value="Go" id="gobtn" class="btn btn-primary"/>
						</form>
					</div>
				</div>
				<%
					resultList.sort(Comparator.comparingInt(r -> r.getCompletionTime()));
				%>
				<div class="row">
					<div class="centered-card">
						<div class="card" style="width: 18rem;">
							<img src="images/solution.gif" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title"><%= resultList.get(0).getAlgorithm() %></h5>
								<table class="table">
									<tbody>
										<tr>
											<td scope="row">1</td>
											<td>Process Execution Order</td>
											<th><%= resultList.get(0).getProcessOrder() %></th>
										</tr>
												
										<tr>
											<td scope="row">2</td>
											<td>Average Waiting Time</td>
											<th><%= resultList.get(0).getAverageWaitingTime()%></th>
										</tr>
										
										<tr>
											<td scope="row">3</td>
											<td>Total Process Completion Time</td>
											<th><%= resultList.get(0).getCompletionTime() %></th>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>			
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>
<!-- We use the index of the resulList to display the result of various algorithms -->