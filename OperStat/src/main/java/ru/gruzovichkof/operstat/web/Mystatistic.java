package ru.gruzovichkof.operstat.web;

import ru.gruzovichkof.operstat.core.AbstractServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Mystatistic")
public class Mystatistic extends AbstractServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        forward("/mystatistic.jsp");
    }
}