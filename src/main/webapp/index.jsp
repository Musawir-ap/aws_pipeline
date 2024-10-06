<!DOCTYPE html>
<html>
<head>
    <title>ABC Store</title>
    <script type="text/javascript">
        function navigateTo(url) {
            window.location.href = url;
        }
    </script>
</head>
<body>
    <h1>Welcome to the ABC Store</h1>
    
    <button type="button" onclick="navigateTo('addProduct')">Add Product</button>
    <span>   </span>
    <button type="button" onclick="navigateTo('products')">View Products</button>

</body>
</html>
