<%--
  Created by IntelliJ IDEA.
  User: Chanika
  Date: 6/18/2025
  Time: 1:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            width: 350px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 10px;
        }

        button:hover {
            background-color: #45a049;
        }

        .message {
            text-align: center;
            margin-top: 10px;
        }

        .error {
            color: red;
        }

        .success {
            color: green;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Register</h2>
    <form method="post" action="register">
        <input type="text" name="id" placeholder="User ID" required>
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <select name="role" required>
            <option value="" disabled selected>Select Role</option>
            <option value="EMPLOYEE">Employee</option>
            <option value="ADMIN">Admin</option>
        </select>
        <button type="submit">Register</button>
<%--        <button >Already have an account? Login</button>--%>
        <a href="login.jsp">Already have an account? Login</a>
    </form>



    <div class="message">
        <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
        <% } else if (request.getAttribute("success") != null) { %>
        <p class="success"><%= request.getAttribute("success") %></p>
        <% } %>
    </div>
</div>

</body>
</html>
