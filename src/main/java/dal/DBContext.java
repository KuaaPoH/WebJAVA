package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
            // Edit URL, USER, PASSWORD according to your SQL Server setup
            String user = "sa";
            String password = "123";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=Travel1;encrypt=true;trustServerCertificate=true";
            
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
    }
}
