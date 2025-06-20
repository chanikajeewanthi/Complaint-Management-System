<%@ page import="org.example.model.Complaint" %>
<%@ page import="org.example.model.User" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    if (complaints == null) {
        complaints = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - All Complaints</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f2f5fa;
        }

        .card {
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
        }

        .table th {
            background-color: #0d6efd;
            color: white;
            vertical-align: middle;
        }

        .table td, .table th {
            text-align: center;
        }

        .btn {
            border-radius: 6px;
        }

        h2 {
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="card p-4">
        <h2 class="mb-4 text-center text-primary">All Complaints</h2>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
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
                    <td><span class="badge bg-info text-dark"><%= c.getStatus() %></span></td>
                    <td><%= c.getRemarks() != null ? c.getRemarks() : "-" %></td>
                    <td><%= c.getCreatedAt() %></td>
                    <td><%= c.getUpdatedAt() %></td>
                    <td>
                        <a href="update-complaint?id=<%= c.getId() %>" class="btn btn-sm btn-warning mb-1">Update</a>
                        <form method="post" action="delete-complaint" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                            <input type="hidden" name="id" value="<%= c.getId() %>"/>
                            <button class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <div class="text-center mt-3">
            <a href="admin.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
