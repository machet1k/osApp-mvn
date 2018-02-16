package ru.gruzovichkof.operstat.web;

import ru.gruzovichkof.operstat.core.AbstractServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Call")
public class Call extends AbstractServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String login = String.valueOf(request.getSession().getAttribute("login"));
        String city = request.getParameter("city");
        String type = request.getParameter("callsType");
        String add_func = request.getParameter("add_func");
        String cost = request.getParameter("cost");
        String load_capacity = request.getParameter("load_capacity");
        request.getSession().setAttribute("add_func", add_func);

        String url = "jdbc:derby://localhost:1527/osdb";
        String username = "root";
        String password = "hermes";

        String query = "insert into calls(line, city, calls_type, add_func";
        if (!"".equals(cost) && "Заказ".equals(type)) {
            query += ", cost";
        }
        if (!"".equals(load_capacity) && "Большегрузы".equals(add_func)) {
            query += ", load_capacity";
        }
        query += ") values('" + login + "', '" + city + "', '" + type + "', '" + add_func + "'";
        if (!"".equals(cost) && "Заказ".equals(type)) {
            query += ", " + cost;
        }
        if (!"".equals(load_capacity) && "Большегрузы".equals(add_func)) {
            query += ", '" + load_capacity + "'";
        }
        query += ")";

        if (!isUserAuthenticated() || "null".equals(login) || login == null) {
            redirect("/os/sign-in");
        } else {
            try (
                    Connection connection = DriverManager.getConnection(url, username, password);
                    Statement statement = connection.createStatement();) {
                statement.executeUpdate(query);
                System.out.println("Call: " + query);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            redirect("/os");
        }
    }
}
