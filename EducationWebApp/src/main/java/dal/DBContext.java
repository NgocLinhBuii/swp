package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

//Kết nối DB // đổi lại thành connectionMysql
public class DBContext {

    protected Connection connection;
    private static final String URL = "jdbc:mysql://localhost:3306/db-script";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "1234";

    public DBContext() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("kết nối thành công");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return connection;
    }

    public static void main(String[] args) {
        new DBContext();
    }
}
