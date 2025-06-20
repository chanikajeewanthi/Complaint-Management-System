package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dao.ComplaintDAO;
import org.example.model.Complaint;
import org.example.model.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/employee/delete-complaint")
public class EmployeeDeleteComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int complaintId = Integer.parseInt(req.getParameter("id"));
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplaintDAO dao = new ComplaintDAO(ds);

        try {
            Complaint existing = dao.getComplaintById(String.valueOf(complaintId));

            // Security check: only allow the owner to delete
            if (existing == null || !existing.getUserId().equals(user.getId())) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            dao.deleteComplaint(complaintId);
            resp.sendRedirect(req.getContextPath() + "/view-my-complaints");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
