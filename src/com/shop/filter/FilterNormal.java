//package com.shop.filter;
//import java.io.IOException;
//import java.io.PrintWriter;
//import javax.servlet.Filter;
//import javax.servlet.FilterChain;
//import javax.servlet.FilterConfig;
//import javax.servlet.ServletException;
//import javax.servlet.ServletRequest;
//import javax.servlet.ServletResponse;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.annotation.WebInitParam;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//@WebFilter(filterName="FilterNormal",urlPatterns="/jsp/book/*", initParams={@WebInitParam(name="allowPath",value="jsp/book/reg.jsp?type=login;cart.jsp;header.jsp;footer.jsp;index.jsp;reg.jsp;bookdetailed;BookList;CartServlet;CodeServlet;GetCatalog;ShopIndex;UserServlet?action=login;UserServlet?action=ajlogin;UserServlet?action=reg;UserServlet?action=yanzheng;UserServlet?action=findNumber;images;css")})
//public class FilterNormal implements Filter {
//	private String allowPath;
//	public void destroy() {
//		// TODO Auto-generated method stub
//	}
//	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//		HttpServletRequest httpRequest=(HttpServletRequest) request;
//		HttpServletResponse httpResponse=(HttpServletResponse) response;
//		String urlPath=httpRequest.getServletPath();
//		if(httpRequest.getSession().getAttribute("User")!=null){
//			chain.doFilter(request, response);
//			return;
//		}
//		String[] urls=this.allowPath.split(";");
//		for(String url:urls){
//			if(urlPath.indexOf(url)>0){
//				chain.doFilter(request, response);
//				return;
//			}
//		}
//		String noPath= httpRequest.getScheme()+"://"+httpRequest.getServerName()+":"
//				+httpRequest.getServerPort() +httpRequest.getContextPath()+"/jsp/book/reg.jsp";
//
//		PrintWriter pw=httpResponse.getWriter();
//		pw.println("<script>top.location.href='"+noPath+"'</script>");
//	}
//
//	public void init(FilterConfig fConfig) throws ServletException {
//		this.allowPath=fConfig.getInitParameter("allowPath");
//	}
//
//}
