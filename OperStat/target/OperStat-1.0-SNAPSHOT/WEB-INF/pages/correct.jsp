<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Мои звонки</title>
        <link href="css/groundwork.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        <div style="width: 900px; padding: 10px;">
            <a href="/os">Вернуться назад</a>
            <form action="Remove" method="post">
                <h2>Мои звонки</h2> 
                <table>
                    <tr class="bold">
                        <td>Время звонка</td>
                        <td>Город</td>
                        <td>Тип звонка</td>
                        <td>Функционал</td>
                        <td>Цена</td>
                        <td>Тип авто</td>
                        <td></td>
                    </tr>
                    <%
                        String url = "jdbc:derby://localhost:1527/osdb";
                        String username = "root";
                        String password = "hermes";
                        ResultSet rs = null;
                        String query = (String) session.getAttribute("queryIncorrect");
                        try {
                            Connection connection = DriverManager.getConnection(url, username, password);
                            Statement statement = connection.createStatement();
                            rs = statement.executeQuery(query);
                            System.out.println("Incorrect: " + query);
                            while (rs.next()) {
                                out.print("<tr>");
                                String s = rs.getString(2);
                                int space = s.indexOf(" ") + 1;
                                int point = s.indexOf(".");
                                out.print("<td>" + s.substring(space, point) + "</td>");
                                for (int i = 3; i < 8; i++) {
                                    if (rs.getString(i) == null) {
                                        out.print("<td></td>");
                                    } else {
                                        out.print("<td>" + rs.getString(i) + "</td>");
                                    }
                                }
                                out.print("<td><button name='id4removal' value='" + rs.getString(1) + "' type='submit' class='btn-danger'>Удалить</button></td>");
                                out.print("</tr>");
                            }
                            statement.close();
                            connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </table>
            </form>
        </div>
    </body>
</html>