package com.abc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import java.io.InputStream;

public class DatabaseConnection {

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Load properties file
            Properties props = new Properties();
            InputStream input = DatabaseConnection.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(input);

            // Get connection details
            String url = props.getProperty("db.url");
            String user = props.getProperty("db.username");
            String password = props.getProperty("db.password");
            String driver = props.getProperty("db.driver");

            // Load the JDBC driver
            Class.forName(driver);

            // Establish the connection
            connection = DriverManager.getConnection(url, user, password);
            System.out.println("Connection Successful");

        } catch (Exception e) {
            System.err.println("Connection error: " + e.getMessage());
        }
        return connection;
    }
}



// package com.abc.util;

// import java.sql.Connection;
// import java.sql.DriverManager;
// import java.sql.SQLException;

// public class DatabaseConnection {

//     private static final String DB_URL = "jdbc:mysql://localhost:3306/product_db"; // Change to your actual database URL
//     private static final String DB_USER = "root"; // Change to your MySQL username
//     private static final String DB_PASSWORD = "MySqlRoot@001";
//     private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
//     private static Connection connection = null;

//     public static Connection getConnection() {
//         if (connection == null) {
//             try {
//                 Class.forName(DB_DRIVER);
//                 connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
//                 if (connection != null) {
//                     System.out.println("Database connection successful");
//                 } else {
//                     System.out.println("Failed to establish database connection");
//                 }
//             } catch (ClassNotFoundException | SQLException e) {
//                 System.err.println("Error while connecting to the database: " + e.getMessage());
//             }
//         }
//         return connection;
//     }
// }
