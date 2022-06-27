package com.lec.ex;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(description = "sumOut", urlPatterns = { "/Ex2_suOut" })
public class Ex2_suOut extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String numStr = request.getParameter("num");
		if (numStr == null || numStr.contentEquals("")) {
			numStr = "1";
		}
		int num = Integer.parseInt(numStr);
		int sum = 0;
		for (int i = 0; i <= num; i++) {
			sum += i;
		}
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<h1>Cumulative sum of numbers 1~" + num + " is: " + sum + "</h1>");
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
