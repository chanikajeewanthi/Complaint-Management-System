<%@ page import="org.example.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"EMPLOYEE".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .dashboard-card {
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
    <a class="navbar-brand" href="#">Complaint System</a>
    <div class="ms-auto">
        <a href="logout.jsp" class="btn btn-danger btn-sm">Logout</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="card dashboard-card p-4">
        <h3 class="text-primary mb-3">Welcome, <%= user.getUsername() %></h3>
        <p class="mb-4">This is your Employee Dashboard. You can submit new complaints or view your complaint history.</p>

        <div class="d-grid gap-3 d-md-flex justify-content-md-start">
            <a href="submit-complaint.jsp" class="btn btn-outline-primary btn-lg px-4">Submit New Complaint</a>
            <a href="view-my-complaints" class="btn btn-outline-secondary btn-lg px-4">View My Complaints</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
