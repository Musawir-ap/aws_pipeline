<!-- <html>
<body>
<h2>Welcome to ABC technologies</h2>
<h3>This is retail portal</h3>
<button name="Add Product" value="Add Product" type="button" onclick="addProduct()">Add Product</button>  
<script>  
function addProduct(){  
alert("You will be navigated to Add module");  
}  
</script>  
    <button name="View Product" value="View Product" type="button" onclick="viewProduct()">View Product</button>  
<script>  
function viewProduct(){  
alert("You will be navigated to view module");  
}
</script>
</body>
</html>
 -->

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
    
    <!-- Button to navigate to Add Product page -->
    <button type="button" onclick="navigateTo('addProduct')">Add Product</button>
    <span>   </span>
    <!-- Button to navigate to View All Products page -->
    <button type="button" onclick="navigateTo('products')">View Products</button>

</body>
</html>
