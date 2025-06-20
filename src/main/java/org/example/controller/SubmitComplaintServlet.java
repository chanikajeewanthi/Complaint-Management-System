package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dao.ComplaintDAO;
import org.example.model.Complaint;
import org.example.model.User;

import java.io.IOException;
import java.sql.SQLException;
@WebServlet("/submit-complaint")
public class SubmitComplaintServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !"employee".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");

        Complaint complaint = new Complaint();
        complaint.setTitle(title);
        complaint.setDescription(description);
        complaint.setUserId(user.getId());
        complaint.setStatus("Open"); // <-- Set default status

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplaintDAO complaintDAO = new ComplaintDAO(ds);

        try {
            if (complaintDAO.submitComplaint(complaint)) {
                req.setAttribute("message", "Complaint submitted successfully.");
            } else {
                req.setAttribute("error", "Failed to submit complaint.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        req.getRequestDispatcher("submit-complaint.jsp").forward(req, resp);
    }
}
