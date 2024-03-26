package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Lists;


@WebServlet("/Servlet3")
public class Servlet3 extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int index = Integer.parseInt(request.getParameter("index"));
		List<bean.Process>processList = Lists.resultList.get(index).getProcessList();
		HttpSession session = request.getSession();
		session.setAttribute("processList", processList);
		response.sendRedirect("Show.jsp");
	}

}
//In this page we get the details of the particular algorithm using index and forward to the show page using session.