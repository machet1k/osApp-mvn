<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Неверные учётные данные!</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/groundwork.css" type="text/css" rel="stylesheet">
        <link href="css/style.css" type="text/css" rel="stylesheet">
        <link rel="icon" type="image/png" href="https://image.ibb.co/foupj6/favicon.png" sizes="16x16">
    </head>
    <body>
        <a href="https://gruzovichkof.ru/">
            <img class="logimg" src="https://jobfilter.ru/uploaded_files/images/2016/12/13/63189/md_Xq0NTwDY9d_mkr5R.png" alt="logotype">
        </a>
        
        <div class="logo headertext">Operator's Statistic App</div>
        <div class="error box centered two sevenths double-gapped animated fadeInDownBig">
            <h2>Попытка повторной регистрации!</h2>  
            <p class="сentered">
                Если Вы забыли пароль от своей учётной записи, <br>
                проверьте свой email: 
                <%
                    out.print(session.getAttribute("email"));
                %>
                
            </p>
            <button class="button red" onclick="history.back();">Вернуться к регистрации</button>
            <button class="button red" onclick="history.go(-2);">Вернуться к авторизации</button>
        </div>
    </body>
</html>