<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Process Scheduler</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<style>
        .custom-center {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .submit{
        	margin-top : 7vh;
        	margin-left: 25vh;
        	width: 150px;
        	height: 50px;
        	font-size: 16px;
        }
        body {
 			 background-image: url('images/process.jpg');
            background-size: cover;
		}
        </style>
	</head>
	<body>
		<div class="container custom-center">
	  		<div class="card" style="width: 30rem;">
	  			<img src="images/bg.gif" class="card-img-top" alt="...">
	  			<div class="card-body">
	    			<h5 class="card-title">Enter the Process Details</h5>
	    			<form action="Servlet1" autocomplete="off">
		    			<div class="mb-3">
							  <label for="processName" class="form-label">Process Name</label>
							  <input type="text" class="form-control" id="processName" name="processName" >
						</div>
						<div class="mb-3">
							  <label for="arrivalTime" class="form-label">Arrival Time of the Process</label>
							  <input type="text" class="form-control" id="processName" name="arrivalTime" min ="0">
						</div>
						<div class="mb-3">
							  <label for="burstTime" class="form-label">Burst Time of the Process</label>
							  <input type="text" class="form-control" id="burstTime" name="burstTime" min ="0">
						</div>
						<div class="mb-3">
							  <label for="priority" class="form-label">Priority of the Process</label>
							  <input type="text" class="form-control" id="priority" name="priority" min ="0">
						</div>
						<button type="submit" class="btn btn-primary">Add Process</button>
					</form>
					<div class = "submit">
						<form action="Servlet2">
							<button type="submit" class="btn btn-primary">Schedule</button>
						</form>
	    			</div>
	  			</div>
			</div>
		</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>