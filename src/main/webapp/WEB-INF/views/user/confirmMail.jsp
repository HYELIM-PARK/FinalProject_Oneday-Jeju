<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<link rel="stylesheet" type="text/css" href="/resources/css/join.css" />

<script type="text/javascript">
alert("회원가입이 최종적으로 완료되었습니다. 이제 로그인이 가능합니다.")
document.location.href="/member/login";
</script>

<c:import url="/WEB-INF/views/layout/footer.jsp" />
