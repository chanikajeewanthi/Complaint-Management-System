package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dao.ComplaintDAO;
import org.example.model.Complaint;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/update-complaint")
public class UpdateComplaintServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplaintDAO complaintDAO = new ComplaintDAO(ds);
        Complaint complaint = null;
        try {
            complaint = complaintDAO.getComplaintById(id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (complaint == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Complaint not found");
            return;
        }
        req.setAttribute("complaint", complaint);
        req.getRequestDispatcher("update-complaint.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplaintDAO complaintDAO = new ComplaintDAO(ds);

        boolean updated = false;
        try {
            updated = complaintDAO.updateComplaintStatus(Integer.parseInt(id), status, remarks);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (updated) {
            resp.sendRedirect(req.getContextPath() + "/view-all-complaints");
        } else {
            // If update fails, reload complaint for showing in the form again
            try {
                Complaint complaint = complaintDAO.getComplaintById(id);
                req.setAttribute("complaint", complaint);
            } catch (SQLException e) {
                throw new ServletException(e);
            }
            req.setAttribute("error", "Failed to update complaint");
            req.getRequestDispatcher("update-complaint.jsp").forward(req, resp);
        }
    }
}
