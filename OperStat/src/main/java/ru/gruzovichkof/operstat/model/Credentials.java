package ru.gruzovichkof.operstat.model;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class Credentials {

    @NotNull @Pattern(regexp = "\\w{3,}")
    private final String login;
    @NotNull
    private final String password;

    public Credentials(String login, String password) throws ServletException {
        this.login = login;
        this.password = password;
    }
    
    public Credentials(HttpServletRequest request) throws ServletException {
        this(request.getParameter("login"), request.getParameter("password"));
    }

    @Override
    public int hashCode() {
        return (login + password).hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Credentials && obj.hashCode() == hashCode();
    }

    public String getLogin() {
        return login;
    }

    public String getPassword() {
        return password;
    }   
}