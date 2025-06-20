package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dao.ComplaintDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/delete-complaint")
public class DeleteComplaintServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplaintDAO complaintDAO = new ComplaintDAO(ds);

        try {
            boolean deleted = complaintDAO.deleteComplaint(Integer.parseInt(id));
            if (deleted) {
                resp.sendRedirect(req.getContextPath() + "/view-all-complaints");
            } else {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete complaint");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
