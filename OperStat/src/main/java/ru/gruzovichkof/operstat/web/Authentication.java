package ru.gruzovichkof.operstat.web;

import ru.gruzovichkof.operstat.core.AbstractServlet;
import ru.gruzovichkof.operstat.model.Credentials;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebServlet({"/sign-in", "/sign-out"})
public class Authentication extends AbstractServlet {

    @Override
    protected void doGet(String address) throws ServletException, IOException {
        switch (address) {
            case "/sign-in":
                forward("/login.html");
                break;
            case "/sign-out":
                onSignOut(getSession());
                break;
            default:
                super.doGet(address);
        }
    }

    @Override
    protected void doPost(String address) throws ServletException, IOException {
        switch (address) {
            case "/sign-in":
                onSignIn(getRequest(), getSession());
                break;
            default:
                super.doPost(address);
        }
    }

    private void onSignOut(HttpSession session) throws IOException {
        session.invalidate();
        redirect("/os");
    }

    private void onSignIn(HttpServletRequest request, HttpSession session) throws ServletException, IOException {

        String url = "jdbc:derby://localhost:1527/osdb";
        String username = "root";
        String password = "hermes";
        String passFromDB = "";
        String department = "";
        
        Credentials credentials = new Credentials(request);
        
        String query = "SELECT password, department FROM users WHERE login = '" + credentials.getLogin() + "'";
        
        try (Connection connection = DriverManager.getConnection(url, username, password);
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(query)){
            if (rs.next()) {
                passFromDB = rs.getString(1);
                department = rs.getString(2);
            }
            else forward("/notFound.html");
        } catch (IOException | ServletException | SQLException e) { e.printStackTrace(); }
        
        if (credentials.equals(new Credentials(credentials.getLogin(), passFromDB))) {
            session.setAttribute("isAuth", true);
            session.setAttribute("queryForAdminPanel", "select * from calls where date(regtime) = '2000-01-01'");
            session.setAttribute("login", credentials.getLogin());
            session.setAttribute("department", department);
            session.setAttribute("add_func", "Линия");
            session.setAttribute("username", System.getProperties().getProperty("user.name"));
            redirect("/os");
        } else {
            System.out.println(credentials.getLogin() + " " + credentials.getPassword());
            forward("/notFound.html");
        }
    }
}