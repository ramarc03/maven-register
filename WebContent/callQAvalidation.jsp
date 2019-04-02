<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>

$(document).ready(function () {
	var count = 0;
    $("#click").click(function () {
        name = $("#name").val();
        age = $("#age").val();
        $.ajax({
            type: "POST",
            url: "qaresultlocal.jsp",
            data: {"name":name,"age":age},
            success: function (data) {
            if(data="SUCCESS")
            	count++;
                $("#response").html(count);
            }
        });
        return false;
    });
});
</script>
<%
		response.setHeader("Cache-Control","no-cache,no-store, must-revalidate"); //$NON-NLS-1$ 
		response.setHeader("Pragma","no-cache"); //$NON-NLS-1$
		response.setDateHeader("Expires", 0); //$NON-NLS-1$
%>
<body>
    Name:<input type="text" id="name" name="name">
    <br /><br /> 
    Age :<input type="text" id="age" name="age">
    <br /><br />
    <button id="click">Click Me</button>
    <div id="response"></div>
</body>

</html>