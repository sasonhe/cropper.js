<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set value="${pageContext.request.contextPath}" var="ctx"></c:set>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>演示项目Demo</title>
    <meta name="keywords" />
    <meta name="description" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="${ctx}/pub/de-css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/pub/de-css/return.css">
    <script src="${ctx}/pub/de-js/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="${ctx}/pub/de-js//bootstrap.min.js"></script>
</head>
<body>
  <div class="mainBox">
    <form id="myform" name="form-apply">
      <input name="personGuId" id="personGuId" type="hidden" value="${guid}"/>
      <!-- logo -->
      <div><img src="${ctx}/pub/de-img/logo1.jpg" alt="" class="img-respone"></div>
      <!-- 姓名 -->
      <div class="headName border-1px">
        <span class="name">姓名</span>
        <span style="color:#337ab7;">${uiName}</span>
      </div>
      <%-- 注册码 --%>
      <div class="headName border-1px">
        <span class="name">注册码</span>
        <span style="color:red;">${euCode}</span>
      </div>
      <%-- 状态 --%>
      <div class="headName border-1px">
        <span class="name">人像状态</span>
        <c:choose>
          <c:when test="${state== '1'}">
            <span style="color:#e50080;">上传中</span>
          </c:when>
          <c:when test="${state== '2'}">
            <span style="color:#e50080;">注册中</span>
          </c:when>
          <c:when test="${state== '3'}">
            <span style="color:#1ab394;">注册成功</span>
          </c:when>
          <c:when test="${state== '4'}">
            <span style="color:red;">注册失败!</span>
            <span style="padding-left:25px;" onclick="restBut();" id="restBut"><a href="javascript:;" style="text-decoration: underline;">重新拍照</a></span>
          </c:when>
          <c:otherwise>
            <span style="color:#e50080;">校检失败</span>
          </c:otherwise>
        </c:choose>
      </div>
      <!-- 二维码 头像-->
      <div class="codeBox  border-1px">
        <%-- 头像 --%>
        <div class="item-img">
          <div class="img-wrapper">
            <img src="${ctx}/qrCode/${guid}.jpg" alt="" class="img-respone">
          </div>
        </div>
        <%-- 二维码 --%>
        <div class="item-eucode">
          <img width="200" height="200" src="${ctx}/register/sourcePhoneImg.html?code=${euCode}" />
        </div>
      </div>
    </form>
    <!-- 文字说明 -->
    <div class="descInfo  border-1px">
      <p>请向工作人员出示二维码，即可快速打证入场！</p>
      <p>温馨提示：长按二维码可保存至手机。</p>
      <p>仅限本人使用，转发无效。</p>
    </div>
    
    <footer class="foot"><a href="javascript:;">数展科技提供技术支持</a></footer>
  </div>
<script>
   //重新拍照
   function restBut(){
      $('#myform').attr('action','${ctx}/register/restResult.html');
	    $('#myform').submit();
   }
</script>
</body>
</html>
