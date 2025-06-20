<%@ page import="org.example.model.Complaint" %>
<%
    Complaint c = (Complaint) request.getAttribute("complaint");
    if (c == null) {
        response.sendRedirect("view-my-complaints");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Complaint #<%= c.getId() %></h2>

    <form method="post" action="employee-update-complaint">
        <input type="hidden" name="id" value="<%= c.getId() %>"/>

        <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" id="title" name="title" value="<%= c.getTitle() %>" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="4" required><%= c.getDescription() %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="view-my-complaints" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
