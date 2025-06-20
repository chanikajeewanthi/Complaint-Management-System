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
import java.util.List;

@WebServlet("/view-my-complaints")
public class ViewMyComplaintsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplaintDAO dao = new ComplaintDAO(ds);

        List<Complaint> myComplaints;
        try {
            myComplaints = dao.getComplaintsByUserId(user.getId());
        } catch (SQLException e) {
            throw new ServletException("Unable to fetch complaints", e);
        }

        req.setAttribute("myComplaints", myComplaints);

        // <-- Forward to the JSP that actually exists
        req.getRequestDispatcher("view-my-complaints.jsp")
                .forward(req, resp);
    }
}
