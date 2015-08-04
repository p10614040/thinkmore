<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<input id="basePath" type="hidden" value="<%=basePath%>"/>
<script type="text/javascript">
   	var basePath = document.getElementById("basePath").value;
</script> 
