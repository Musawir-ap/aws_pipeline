<!DOCTYPE html>
<html>
  <head>
    <title>Add Product</title>
  </head>
  <body>
    <h1>Add a New Product</h1>
    <form action="addProduct" method="post">
      <label for="product_name">Product Name:</label>
      <input type="text" id="product_name" name="product_name" /><br /><br />
      <label for="price">Price:</label>
      <input type="text" id="price" name="price" inputmode="decimal" pattern="[0-9]*[.,]?[0-9]*" /><br /><br />
      <label for="product_description">Description:</label>
      <input type="text" id="product_description" name="product_description" /><br /><br />
      <input type="submit" value="Add Product" />
    </form>
  </body>
</html>
