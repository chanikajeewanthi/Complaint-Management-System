package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dao.UserDAO;
import org.example.model.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        UserDAO userDAO = new UserDAO(ds);
        try {
            if (userDAO.getUserByUsername(username) != null) {
                req.setAttribute("error", "Username already exists");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        try {
            User newUser = new User(id, username, password, role);
            boolean result = userDAO.createUser(newUser);
            if (result) {
                req.setAttribute("success", "User registered successfully");
                resp.sendRedirect("login.jsp");
                return;
            } else {
                req.setAttribute("error", "Registration failed");
                req.getRequestDispatcher("register.jsp").forward(req, resp);            }
        } catch (SQLException e) {
            req.setAttribute("error", "An error occurred: " + e.getMessage());
            e.printStackTrace();
        }

        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }
}
