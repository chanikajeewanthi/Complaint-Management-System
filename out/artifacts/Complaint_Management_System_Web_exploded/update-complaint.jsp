<%--
  Created by IntelliJ IDEA.
  User: Chanika
  Date: 6/18/2025
  Time: 4:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.example.model.Complaint" %>
<%
    Complaint complaint = (Complaint) request.getAttribute("complaint");
    if (complaint == null) {
        response.sendRedirect("viewAll");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container mt-5">
    <h2>Update Complaint</h2>

    <form method="post" action="update-complaint">
        <input type="hidden" name="id" value="<%= complaint.getId() %>"/>

        <div class="mb-3">
            <label>Title</label>
            <input type="text" name="title" class="form-control" value="<%= complaint.getTitle() %>" required/>
        </div>

        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control" required><%= complaint.getDescription() %></textarea>
        </div>

        <div class="mb-3">
            <label>Status</label>
            <select name="status" class="form-control" required>
                <option value="PENDING" <%= "PENDING".equals(complaint.getStatus()) ? "selected" : "" %>>PENDING</option>
                <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(complaint.getStatus()) ? "selected" : "" %>>IN_PROGRESS</option>
                <option value="RESOLVED" <%= "RESOLVED".equals(complaint.getStatus()) ? "selected" : "" %>>RESOLVED</option>
            </select>
        </div>

        <div class="mb-3">
            <label>Remarks</label>
            <textarea name="remarks" class="form-control"><%= complaint.getRemarks() != null ? complaint.getRemarks() : "" %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update Complaint</button>
        <a href="viewAll" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
<script src="./lib/jquery-3.7.1.min.js"></script>

</body>
</html>