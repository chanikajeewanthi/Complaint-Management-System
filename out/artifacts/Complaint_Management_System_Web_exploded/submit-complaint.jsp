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
<html>
<head>
    <title>Submit Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<h2>Submit New Complaint</h2>

<form method="post" action="submit-complaint">
    <label for="title">Complaint Title:</label><br>
    <input type="text" id="title" name="title" required><br><br>

    <label for="description">Complaint Description:</label><br>
    <textarea id="description" name="description" rows="5" cols="40" required></textarea><br><br>

    <input type="submit" value="Submit Complaint">
</form>

<p><a href="employee.jsp">Back to Dashboard</a></p>

<% if (request.getAttribute("message") != null) { %>
<p style="color: green;"><%= request.getAttribute("message") %></p>
<% } %>

<% if (request.getAttribute("error") != null) { %>
<p style="color: red;"><%= request.getAttribute("error") %></p>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
<script src="./lib/jquery-3.7.1.min.js"></script>

</body>
</html>
