<%@ page import="org.example.model.User" %>
<%
    // Session check: only EMPLOYEE can access
    User user = (User) session.getAttribute("user");
    if (user == null || !"EMPLOYEE".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f9f9fb;
        }
        .card {
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.05);
        }
        .form-control, .btn {
            border-radius: 8px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card p-4">
                <h3 class="mb-4 text-center">Submit a New Complaint</h3>

                <% if (request.getAttribute("message") != null) { %>
                <div class="alert alert-success" role="alert">
                    <%= request.getAttribute("message") %>
                </div>
                <% } %>

                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <form method="post" action="submit-complaint">
                    <div class="mb-3">
                        <label for="title" class="form-label">Complaint Title</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Enter complaint title" required>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Complaint Description</label>
                        <textarea class="form-control" id="description" name="description" rows="5" placeholder="Describe the issue in detail" required></textarea>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">Submit Complaint</button>
                        <a href="employee.jsp" class="btn btn-secondary">Back to Dashboard</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
