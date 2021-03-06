package com.lec.controller;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.service.EmailConfirmService;
import com.lec.service.IdConfirmService;
import com.lec.service.MAllViewService;
import com.lec.service.ALoginService;
import com.lec.service.ALogoutService;
import com.lec.service.BContentService;
import com.lec.service.BDeleteService;
import com.lec.service.MDeleteService;
import com.lec.service.MJoinService;
import com.lec.service.MLoginService;
import com.lec.service.MLogoutService;
import com.lec.service.MService;
import com.lec.service.BListService;
import com.lec.service.BModifyService;
import com.lec.service.BModifyViewService;
import com.lec.service.BReplyService;
import com.lec.service.BReplyViewService;
import com.lec.service.BWriteService;
import com.lec.service.ModifyService;

@WebServlet("*.do")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private boolean write_view = false;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		actionDo(request, response);
	}
	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String com = uri.substring(conPath.length());
		MService service = null;
		String viewPage = null;
		System.out.println("uri="+uri +" com ="+com);
		if(com.equals("/main.do")) {
			viewPage = "main/main.jsp";
		} else if(com.equals("/list.do")) { //게시판
			service = new BListService();
			service.execute(request, response);
			viewPage = "board/list.jsp";
		} else if(com.equals("/loginView.do")) { //로그인
			viewPage = "member/login.jsp";
		}else if(com.equals("/login.do")) { 
			service = new MLoginService();
			service.execute(request, response);
			viewPage = "main/main.jsp";
			
			
		} else if(com.equals("/adminLoginView.do")) { //ADMIN 로그인
			viewPage = "admin/adminLogin.jsp";
		}else if(com.equals("/adminLogin.do")) { //ADMIN 로그인
			service = new ALoginService();
			service.execute(request, response);
			viewPage = "adminMain.do";
		} else if(com.equals("/adminMain.do")) { 
			service = new MAllViewService();
			service.execute(request, response); 
			viewPage = "main/adminMain.jsp"; 
		} else if(com.equals("/idConfirm.do")) { //아이디 확인
			service = new IdConfirmService();
			service.execute(request, response);
			viewPage = "member/idConfirm.jsp";
		} else if(com.equals("/emailConfirm.do")) { //이메일 확인
			service = new EmailConfirmService();
			service.execute(request, response);
			viewPage = "member/emailConfirm.jsp";
		} else if(com.equals("/joinView.do")) {//회원가입
			viewPage = "member/join.jsp";
		}else if(com.equals("/join.do")) {  
			service = new MJoinService();
			service.execute(request, response); 
			viewPage = "member/login.jsp";
		}else if(com.equals("/logout.do")) { //로그아웃
			service = new MLogoutService();
			service.execute(request, response);
			viewPage = "member/login.jsp";
		}else if(com.equals("/adminLogout.do")) { //ADMIN 로그아웃
			service = new ALogoutService();
			service.execute(request, response);
			viewPage = "main/main.jsp";
		}else if(com.equals("/modifyView.do")) { //회원 정보 수정
			viewPage = "member/modify.jsp";
		}else if(com.equals("/modify.do")){
			service = new ModifyService();
			service.execute(request, response);
			viewPage = "main/main.jsp";
		} else if (com.equals("/contentView.do")) { //게시판 자세히 보기
			service = new BContentService();
			service.execute(request, response);
			viewPage = "board/contentView.jsp";
		} else if (com.equals("/bModifyView.do")) {
			service = new BModifyViewService();
			service.execute(request, response);
			viewPage = "board/bModifyView.jsp";
			
		} else if (com.equals("/bModify.do")) {
			service = new BModifyService();
			service.execute(request, response);
			viewPage = "list.do";
		} else if (com.equals("/reply_view.do")) {
			service = new BReplyViewService();
			service.execute(request, response);
			viewPage = "board/reply_view.jsp";
		} else if (com.equals("/reply.do")) {
			service = new BReplyService();
			service.execute(request, response);
			viewPage = "list.do";
		} else if (com.equals("/bDelete.do")) {
			service = new BDeleteService();
			service.execute(request, response);
			viewPage = "list.do";
		}else if(com.equals("/write_view.do")) { // 글쓰기 view
			viewPage = "board/write_view.jsp";
			write_view = true;
		} else if (com.equals("/write.do")) {
			if (write_view == true) {
				service = new BWriteService();
				service.execute(request, response);
				write_view = false;
			}
			viewPage = "list.do";
		
		 }
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		}
	}

