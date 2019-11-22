<<%@ page language="java" contentType="text/html; charset=UTF-8"
          pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Insert title here</title>
    <script src="js/jquery-3.1.0.js"></script>
</head>
<body>

<form id="codeForm">

    <input type="text" placeholder="填写手机号" name="phone">
    <button type="button" id="sendCode">发送验证码</button>
    <font id="countdown" color="red"></font>
    <br>

    <input type="text" placeholder="填写验证码" name="verify_code">
    <button type="button" id="verifyCode">确定</button>
    <font id="result" color="green"></font>
    <font id="error" color="red"></font>

</form>

</body>
<script type="text/javascript">
    // 设定倒计时的时间
    var t = 20;
    var id;

    function refer() {
        // 显示倒计时
        $("#countdown").text("请在" + t + "秒内填写验证码");
        // 计数器递减
        t--;

        if (t <= 0) {
            clearInterval(id);
            $("#countdown").text("验证码已失效，请重新发送！！！");
        }
    }

    $(function () {
        $("sendCode").click(function () {
            $.post("sendCode", $("#codeForm").serialize(), function (data) {
                if (data == "success") {
                    // 启动1秒定时
                    id = setInterval("refer()", 1000);
                }
            });
        });

        $("#verifyCode").click(function () {
            $.post("verifyCode", $("#codeForm").serialize(), function (data) {
                if (data == "success") {
                    $("#result").attr("color", "green");
                    $("#result").text("验证成功");
                    clearInterval(id);
                    $("#countdown").text("")
                } else {
                    $("#result").attr("color", "red");
                    $("#result").text("验证失败");
                }
            });
        });
    });
</script>
</html>
