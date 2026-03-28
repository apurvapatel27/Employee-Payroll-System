package dao;

import model.Employee;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    private Employee mapRow(ResultSet rs) throws SQLException {
        Employee e = new Employee();
        e.setId(rs.getInt("id"));
        e.setEmpCode(rs.getString("emp_code"));
        e.setFirstName(rs.getString("first_name"));
        e.setLastName(rs.getString("last_name"));
        e.setEmail(rs.getString("email"));
        e.setPhone(rs.getString("phone"));
        e.setDepartmentId(rs.getInt("department_id"));
        e.setDesignation(rs.getString("designation"));
        e.setBasicSalary(rs.getBigDecimal("basic_salary"));
        e.setJoinDate(rs.getDate("join_date"));
        e.setStatus(rs.getString("status"));
        try { e.setDepartmentName(rs.getString("dept_name")); } catch (SQLException ex) { /* no join column */ }
        return e;
    }

    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT e.*, d.name AS dept_name FROM employees e " +
                     "LEFT JOIN departments d ON e.department_id = d.id ORDER BY e.emp_code";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Employee getEmployeeById(int id) {
        String sql = "SELECT e.*, d.name AS dept_name FROM employees e " +
                     "LEFT JOIN departments d ON e.department_id = d.id WHERE e.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean addEmployee(Employee emp) {
        String sql = "INSERT INTO employees (emp_code,first_name,last_name,email,phone," +
                     "department_id,designation,basic_salary,join_date,status) VALUES (?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, emp.getEmpCode());
            ps.setString(2, emp.getFirstName());
            ps.setString(3, emp.getLastName());
            ps.setString(4, emp.getEmail());
            ps.setString(5, emp.getPhone());
            ps.setInt(6, emp.getDepartmentId());
            ps.setString(7, emp.getDesignation());
            ps.setBigDecimal(8, emp.getBasicSalary());
            ps.setDate(9, emp.getJoinDate());
            ps.setString(10, emp.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean updateEmployee(Employee emp) {
        String sql = "UPDATE employees SET emp_code=?,first_name=?,last_name=?,email=?,phone=?," +
                     "department_id=?,designation=?,basic_salary=?,join_date=?,status=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, emp.getEmpCode());
            ps.setString(2, emp.getFirstName());
            ps.setString(3, emp.getLastName());
            ps.setString(4, emp.getEmail());
            ps.setString(5, emp.getPhone());
            ps.setInt(6, emp.getDepartmentId());
            ps.setString(7, emp.getDesignation());
            ps.setBigDecimal(8, emp.getBasicSalary());
            ps.setDate(9, emp.getJoinDate());
            ps.setString(10, emp.getStatus());
            ps.setInt(11, emp.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean deleteEmployee(int id) {
        String sql = "DELETE FROM employees WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public int getTotalEmployees() {
        String sql = "SELECT COUNT(*) FROM employees";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public int getActiveEmployees() {
        String sql = "SELECT COUNT(*) FROM employees WHERE status = 'Active'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    /** Used by employee login — matches emp_code + password, only Active employees. */
    public Employee validateEmployeeLogin(String empCode, String password) {
        String sql = "SELECT e.*, d.name AS dept_name FROM employees e " +
                     "LEFT JOIN departments d ON e.department_id = d.id " +
                     "WHERE e.emp_code = ? AND e.password = ? AND e.status = 'Active'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, empCode);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
}
