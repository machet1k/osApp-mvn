package ru.gruzovichkof.operstat.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ru.gruzovichkof.operstat.core.AbstractServlet;

@WebServlet("/Remove")
public class Remove extends AbstractServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String url = "jdbc:derby://localhost:1527/osdb";
        String username = "root";
        String password = "hermes";

        String login = String.valueOf(request.getSession().getAttribute("login"));
        String id = request.getParameter("id4removal");
        String query = "delete from calls where id = " + id + " and line = '" + login + "'";
        
        try (
                Connection connection = DriverManager.getConnection(url, username, password);
                Statement statement = connection.createStatement();) {
            statement.executeUpdate(query);
            System.out.println("Remove: " + query);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        forward("/correct.jsp");
    }
}
