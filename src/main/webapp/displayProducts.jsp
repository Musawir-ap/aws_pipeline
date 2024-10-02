<%@ page import="java.util.List" %>
<%@ page import="com.abc.model.RetailModule" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Products</title>
</head>
<body>
    <h1>All Products</h1>

    <table border="2">
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Product Description</th>
        </tr>

        <!-- Loop through the product list -->
        <%
            List<RetailModule> products = (List<RetailModule>) request.getAttribute("products");
            if (products != null) {
                for (RetailModule product : products) {
        %>
        <tr>
            <td><%= product.getProduct_id() %></td>
            <td><%= product.getProduct_name() %></td>
            <td><%= product.getPrice() %></td>
            <td><%= product.getProduct_description() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4">No products available</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
