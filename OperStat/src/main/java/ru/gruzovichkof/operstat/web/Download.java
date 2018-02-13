package ru.gruzovichkof.operstat.web;

import ru.gruzovichkof.operstat.core.AbstractServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Download")
public class Download extends AbstractServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        String query, from, to, city, line, add_func, cost, load_capacity;

        from = request.getParameter("from").replace('T', ' ').concat(":00");
        to = request.getParameter("to").replace('T', ' ').concat(":59");
        city = request.getParameter("city");request.getSession().setAttribute("city", city);
        line = request.getParameter("line");request.getSession().setAttribute("line", line);
        add_func = request.getParameter("add_func"); request.getSession().setAttribute("add_func", add_func);
        cost = request.getParameter("cost"); request.getSession().setAttribute("cost", cost);
        load_capacity = request.getParameter("load_capacity"); request.getSession().setAttribute("load_capacity", load_capacity);

        if (from != null && !"null".equals(from)) request.getSession().setAttribute("from", from);
        if (to != null && !"null".equals(to)) request.getSession().setAttribute("to", to);
        
        query = "select calls.id, regtime, line, surname, name, city, calls_type, add_func, cost, load_capacity from calls left outer join users on calls.LINE = users.LOGIN where regtime >= '" 
                + from + "' and regtime <= '" + to + "'";
        
        if (city != null && !"null".equals(city)) query += " and city = '" + city + "'"; 
        if (line != null && !"".equals(line)) query += " and line = '" + line + "'";  
        if (add_func != null && !"".equals(add_func) && !"null".equals(add_func)) query += " and add_func = '" + add_func + "'";   
        if (cost != null && !"".equals(cost)) query += " and cost = '" + cost + "'";   
        if (load_capacity != null && !"null".equals(load_capacity)) query += " and load_capacity = '" + load_capacity + "'";  
        
        request.getSession().setAttribute("queryForAdminPanel", query);
        System.out.println("DOWNLOAD: " + query);
        
        if (!isUserAuthenticated()) redirect("/os/sign-in");
        else forward("/adminpanel.jsp");
        
    }
}