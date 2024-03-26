package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Process;
import bean.Lists;

@WebServlet("/Servlet1")
public class Servlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String processName = request.getParameter("processName");
		int arrivalTime = Integer.parseInt(request.getParameter("arrivalTime"));
		int burstTime = Integer.parseInt(request.getParameter("burstTime"));
		int priority = Integer.parseInt(request.getParameter("priority"));
		Process process = new Process(processName,arrivalTime,burstTime,priority);
		Lists.processList.add(process);
		response.sendRedirect("Home.jsp");
	}

}
/*
 * In this page we fill the process details from the redirected page and create a process object and store it in the list.
 */
