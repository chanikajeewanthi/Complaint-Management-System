<%--<%@ page import="org.example.model.Complaint" %>--%>
<%--<%@ page import="java.util.List" %>--%>
<%--<%@ page import="org.example.model.User" %>--%>
<%--<%--%>
<%--    User user = (User) session.getAttribute("user");--%>
<%--    if (user == null) {--%>
<%--        response.sendRedirect("login.jsp");--%>
<%--        return;--%>
<%--    }--%>

<%--    List<Complaint> myComplaints = (List<Complaint>) request.getAttribute("myComplaints");--%>
<%--%>--%>

<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>My Complaints</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container mt-5">--%>
<%--    <h2 class="mb-4">My Complaints</h2>--%>

<%--    <table class="table table-bordered">--%>
<%--        <thead>--%>
<%--        <tr>--%>
<%--            <th>ID</th>--%>
<%--            <th>Title</th>--%>
<%--            <th>Description</th>--%>
<%--            <th>Status</th>--%>
<%--            <th>Remarks</th>--%>
<%--            <th>Created At</th>--%>
<%--            <th>Updated At</th>--%>
<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <%--%>
<%--            if (myComplaints != null && !myComplaints.isEmpty()) {--%>
<%--                for (Complaint c : myComplaints) {--%>
<%--        %>--%>
<%--        <tr>--%>
<%--            <td><%= c.getId() %></td>--%>
<%--            <td><%= c.getTitle() %></td>--%>
<%--            <td><%= c.getDescription() %></td>--%>
<%--            <td><%= c.getStatus() %></td>--%>
<%--            <td><%= c.getRemarks() != null ? c.getRemarks() : "N/A" %></td>--%>
<%--            <td><%= c.getCreatedAt() %></td>--%>
<%--            <td><%= c.getUpdatedAt() %></td>--%>
<%--        </tr>--%>
<%--        <%--%>
<%--            }--%>
<%--        } else {--%>
<%--        %>--%>
<%--        <tr>--%>
<%--            <td colspan="7" class="text-center text-muted">You haven't submitted any complaints yet.</td>--%>
<%--        </tr>--%>
<%--        <%--%>
<%--            }--%>
<%--        %>--%>
<%--        </tbody>--%>
<%--    </table>--%>

<%--    <a href="employee.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>--%>
<%--</div>--%>

<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"--%>
<%--        integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"--%>
<%--        crossorigin="anonymous"></script>--%>
<%--<script src="./lib/jquery-3.7.1.min.js"></script>--%>

<%--</body>--%>
<%--</html>--%>

<%@ page import="org.example.model.Complaint" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Complaint> myComplaints = (List<Complaint>) request.getAttribute("myComplaints");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Complaints</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>My Complaints</h2>
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>ID</th>
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
            if (myComplaints != null && !myComplaints.isEmpty()) {
                for (Complaint c : myComplaints) {
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getTitle() %></td>
            <td><%= c.getDescription() %></td>
            <td><%= c.getStatus() %></td>
            <td><%= c.getRemarks() != null ? c.getRemarks() : "N/A" %></td>
            <td><%= c.getCreatedAt() %></td>
            <td><%= c.getUpdatedAt() %></td>
            <td>
                <a href="employee-update-complaint?id=<%= c.getId() %>" class="btn btn-sm btn-warning">Edit</a>
                <form method="post" action="employee/delete-complaint" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                    <input type="hidden" name="id" value="<%= c.getId() %>"/>
                    <button type="submit" class="btn btn-sm btn-danger">
                        Delete</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="8" class="text-center text-muted">You have not submitted any complaints.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <a href="employee.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="./lib/jquery-3.7.1.min.js"></script>
</body>
</html>



