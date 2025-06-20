package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dao.UserDAO;
import org.example.model.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        UserDAO userDAO = new UserDAO(ds);

        try{
            User user = userDAO.validateLogin(username, password);

            if(user != null){
               HttpSession session = req.getSession();
               session.setAttribute("user", user);

               if("ADMIN".equalsIgnoreCase(user.getRole())){
                   resp.sendRedirect("admin.jsp");
               }
               else {
                   resp.sendRedirect("employee.jsp");
               }

            }
            else {
                req.setAttribute("error", "Invalid username or password");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        } catch (IOException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
