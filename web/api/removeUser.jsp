<%@ page import="java.util.Map" %>
<%@ page import="moe.xinmu.jsp.*" %><%--
  Created by IntelliJ IDEA.
  User: zhang
  Date: 4/28/2019
  Time: 3:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(!SQLiteHelper.check(request,response)){
        return;
    }
    MasterSQLHelper sql=SQLiteHelper.INSTANCE.getMasterSQLHelper();
    int code=0;
    final String[] message=new String[]{
            "成功","您未登录","您无权删除用户","传入值非法"
    };
    User user=sql.login(request,response);
    Map<String,String> map= Utils.MapperGet(request);
    if(user==null){
        code=1;
    }
    if(code==0){
        if(!user.privilegeLevel(Security.userlevel.admin))
            code=2;
    }
    if(code==0){
        if(!map.containsKey("userid"))
        code=3;
    }
    if(code==0){
        sql.removeUserInAllGroup(Integer.parseInt(map.get("userid")),request,response);
        sql.removeUser(Integer.parseInt(map.get("userid")),request,response);
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

<script>
    alert("信息：<%
    out.print(message[code]);
%>返回值：<%
    out.print(code);
%>。");
    window.location.href="<%
    out.print("/sub/UserManagement.jsp");
    %>";
</script>
</body>
</html>
