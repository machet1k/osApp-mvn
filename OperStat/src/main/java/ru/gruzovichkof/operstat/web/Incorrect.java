package ru.gruzovichkof.operstat.web;

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
import ru.gruzovichkof.operstat.core.AbstractServlet;

@WebServlet("/Incorrect")
public class Incorrect extends AbstractServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String login = String.valueOf(request.getSession().getAttribute("login"));
        String query = "select id, regtime, city, calls_type, add_func, cost, load_capacity from calls where date(regtime) = CURRENT_DATE and line='" + login + "' order by id desc";
        getSession().setAttribute("queryIncorrect", query);        
        forward("/correct.jsp");
    }
}
