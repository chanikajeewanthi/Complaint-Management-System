<%--
  Created by IntelliJ IDEA.
  User: Chanika
  Date: 6/18/2025
  Time: 12:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.example.DBCPListener" %>
<%@ page import="org.example.model.Complaint" %>
<%@ page import="org.example.dao.ComplaintDAO" %>
<%@ page import="org.example.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="org.example.dao.UserDAO" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    if (complaints == null) {
        complaints = new java.util.ArrayList<>(); // empty list fallback
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Complaints - Admin View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">All Complaints</h2>

    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Remarks</th>
            <th>Created At</th>
            <th>Updated At</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Complaint c : complaints) {
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getUserId() %></td>
            <td><%= c.getTitle() %></td>
            <td><%= c.getDescription() %></td>
            <td><%= c.getStatus() %></td>
            <td><%= c.getRemarks() %></td>
            <td><%= c.getCreatedAt() %></td>
            <td><%= c.getUpdatedAt() %></td>
            <td>
                <a href="update-complaint?id=<%= c.getId() %>" class="btn btn-sm btn-warning">Update</a>

                <form method="post" action="delete-complaint" style="display:inline;" onsubmit="return confirm('Are you sure?');">
                    <input type="hidden" name="id" value="<%= c.getId() %>"/>
                    <button class="btn btn-sm btn-danger">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="admin.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
<script src="./lib/jquery-3.7.1.min.js"></script>

</body>
</html>
