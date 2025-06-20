package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dao.ComplaintDAO;
import org.example.dao.UserDAO;
import org.example.model.Complaint;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/view-all-complaints")
public class ViewAllComplaintsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplaintDAO complaintDAO = new ComplaintDAO(ds);
        try {
            List<Complaint> complaints = complaintDAO.getAllComplaints();

            req.setAttribute("complaints", complaints);
            req.getRequestDispatcher("view-all-complaints.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
