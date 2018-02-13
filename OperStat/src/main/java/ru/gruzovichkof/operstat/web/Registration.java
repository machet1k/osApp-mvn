package ru.gruzovichkof.operstat.web;

import ru.gruzovichkof.operstat.core.AbstractServlet;
import ru.gruzovichkof.operstat.helpers.Sender;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet("/Registration")
public class Registration extends AbstractServlet {

    private static final Sender SENDER = new Sender("neutrinoteammachet1k@gmail.com", "decbblec0olP");
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String line = request.getParameter("line");
        String pass = request.getParameter("password");
        String repass = request.getParameter("repassword");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String department = request.getParameter("department");
        
        if (!pass.equals(repass)) {
            forward("/differentPasswords.html");
        } else {

            String url = "jdbc:derby://localhost:1527/osdb";
            String username = "root";
            String password = "hermes";

            String queryCheckExist = "SELECT email FROM users WHERE login = '" + request.getParameter("line") + "'";
            
            try (Connection connection = DriverManager.getConnection(url, username, password);
                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery(queryCheckExist)){
                if (rs.next()) {
                    request.getSession().setAttribute("email", rs.getString(1));
                    forward("/isExist.jsp");
                    return;
                } else {  
                    String query = "insert into users(login, password, email, name, surname, department) values('" + line + "', '" + pass + "', '" + email + "', '" + name + "', '" + surname + "', '" + department + "')";
                    statement.executeUpdate(query);       
                    forward("/successReg.html");
                    SENDER.send("Регистрационные данные от Operator's Statistic App", 
                                "Добрый день!"
                              + "\nВы успешно зарегистрировались на сервисе статистики для оператора контакт-центра Грузовичкоф."
                              + "\nВ качестве логина для входа используйте Ваш номер линии: " + line + ", – и Ваш пароль: " + pass, 
                                email);
                }
            } catch (IOException | ServletException | SQLException e) { e.printStackTrace(); }
        }
    }
}