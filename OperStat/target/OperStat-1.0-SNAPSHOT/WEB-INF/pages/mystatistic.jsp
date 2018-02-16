<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Моя статистика</title>
        <link href="css/groundwork.css" type="text/css" rel="stylesheet">
    </head>
    <body>
        <div style="width: 300px; padding: 10px;">
            <a href="javascript:history.back()">Вернуться назад</a>
            <%
                String url = "jdbc:derby://localhost:1527/osdb";
                String username = "root";
                String password = "hermes";
                Connection connection = DriverManager.getConnection(url, username, password);
                Statement statement = connection.createStatement();
                String[] arrAddFunc = {"Линия", "Большегрузы", "VIP линия", "Эвакуаторы", "Транспортная компания", "Сборный груз", "Чат отдела продаж", "Консультации", "Жалобы", "Корпоративный отдел"};
                for (int stat = 0; stat < arrAddFunc.length; stat++) {
                    String query = "select CALLS_TYPE, count(*) from calls where date(regtime) = CURRENT_DATE"
                             + " and line = '" + session.getAttribute("login") + "'"
                             + " and ADD_FUNC = '" + arrAddFunc[stat] + "' group by CALLS_TYPE";
                    ResultSet rs = statement.executeQuery(query);  
                    System.out.println(query);
                    if (rs.next()) {
                        out.print("<br><h2>" + arrAddFunc[stat] + "</h2><table><tr><td><b>Тип звонка</b></td><td><b>Количество</b></td></tr>");
                        do {
                            out.print("<tr>");
                            for (int col = 1; col < 3; col++) {
                                out.print("<td>" + rs.getString(col) + "</td>");
                            }
                            out.print("</tr>");
                        } while (rs.next());
                        out.print("</table>");
                    }
                }
            %>
        </div>
    </body>
</html>