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
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
    <a class="navbar-brand" href="#">Complaint System</a>
    <div class="ms-auto">
        <a href="logout.jsp" class="btn btn-danger btn-sm">Logout</a>
    </div>
</nav>

<div class="container mt-5">
    <h2>Welcome, <%= user.getUsername() %> </h2>
    <p>This is your Employee Dashboard.</p>

    <div class="mt-4">
        <a href="submit-complaint.jsp" class="btn btn-primary">Submit New Complaint</a>
        <a href="view-my-complaints" class="btn btn-secondary">View My Complaints</a>
        <a href="logout.jsp" class="btn btn-secondary">Logout</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
<script src="./lib/jquery-3.7.1.min.js"></script>

</body>
</html>
