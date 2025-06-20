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

@WebServlet("/employee-update-complaint")
public class EmployeeUpdateComplaintServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("../login.jsp");
            return;
        }

        String id = req.getParameter("id");
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplaintDAO dao = new ComplaintDAO(ds);

        try {
            Complaint c = dao.getComplaintById(id);
            if (c == null || !c.getUserId().equals(user.getId())) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            req.setAttribute("complaint", c);
            req.getRequestDispatcher("employee-update-complaint.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("../login.jsp");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String description = req.getParameter("description");

        Complaint complaint = new Complaint();
        complaint.setId(id);
        complaint.setTitle(title);
        complaint.setDescription(description);

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplaintDAO dao = new ComplaintDAO(ds);

        try {
            Complaint existing = dao.getComplaintById(String.valueOf(id));
            if (existing == null || !existing.getUserId().equals(user.getId())) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            dao.updateComplaint(complaint);
            resp.sendRedirect(req.getContextPath() + "/view-my-complaints");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
