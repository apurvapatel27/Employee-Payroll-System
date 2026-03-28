package dao;

import model.Payroll;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PayrollDAO {

    private Payroll mapRow(ResultSet rs) throws SQLException {
        Payroll p = new Payroll();
        p.setId(rs.getInt("id"));
        p.setEmployeeId(rs.getInt("employee_id"));
        p.setMonth(rs.getInt("month"));
        p.setYear(rs.getInt("year"));
        p.setBasicSalary(rs.getBigDecimal("basic_salary"));
        p.setHra(rs.getBigDecimal("hra"));
        p.setDa(rs.getBigDecimal("da"));
        p.setGrossSalary(rs.getBigDecimal("gross_salary"));
        p.setPf(rs.getBigDecimal("pf"));
        p.setTax(rs.getBigDecimal("tax"));
        p.setNetSalary(rs.getBigDecimal("net_salary"));
        try {
            p.setEmployeeName(rs.getString("employee_name"));
            p.setEmpCode(rs.getString("emp_code"));
            p.setDepartmentName(rs.getString("dept_name"));
            p.setDesignation(rs.getString("designation"));
        } catch (SQLException ex) { /* no join columns */ }
        return p;
    }

    /** Generates (or regenerates) payroll for one employee for a month/year. */
    public boolean generatePayroll(int employeeId, int month, int year, BigDecimal basic) {
        BigDecimal hra   = basic.multiply(new BigDecimal("0.40")).setScale(2, RoundingMode.HALF_UP);
        BigDecimal da    = basic.multiply(new BigDecimal("0.10")).setScale(2, RoundingMode.HALF_UP);
        BigDecimal gross = basic.add(hra).add(da);
        BigDecimal pf    = basic.multiply(new BigDecimal("0.12")).setScale(2, RoundingMode.HALF_UP);
        BigDecimal tax   = gross.multiply(new BigDecimal("0.05")).setScale(2, RoundingMode.HALF_UP);
        BigDecimal net   = gross.subtract(pf).subtract(tax);

        String sql = "INSERT INTO payroll (employee_id,month,year,basic_salary,hra,da,gross_salary,pf,tax,net_salary) "
                   + "VALUES (?,?,?,?,?,?,?,?,?,?) "
                   + "ON DUPLICATE KEY UPDATE basic_salary=?,hra=?,da=?,gross_salary=?,pf=?,tax=?,net_salary=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            // INSERT part
            ps.setInt(1, employeeId); ps.setInt(2, month); ps.setInt(3, year);
            ps.setBigDecimal(4, basic); ps.setBigDecimal(5, hra); ps.setBigDecimal(6, da);
            ps.setBigDecimal(7, gross); ps.setBigDecimal(8, pf);  ps.setBigDecimal(9, tax);
            ps.setBigDecimal(10, net);
            // UPDATE part
            ps.setBigDecimal(11, basic); ps.setBigDecimal(12, hra); ps.setBigDecimal(13, da);
            ps.setBigDecimal(14, gross); ps.setBigDecimal(15, pf); ps.setBigDecimal(16, tax);
            ps.setBigDecimal(17, net);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public List<Payroll> getPayrollByMonthYear(int month, int year) {
        List<Payroll> list = new ArrayList<>();
        String sql = "SELECT p.*, CONCAT(e.first_name,' ',e.last_name) AS employee_name, "
                   + "e.emp_code, d.name AS dept_name, e.designation "
                   + "FROM payroll p "
                   + "JOIN employees e ON p.employee_id = e.id "
                   + "LEFT JOIN departments d ON e.department_id = d.id "
                   + "WHERE p.month = ? AND p.year = ? ORDER BY e.emp_code";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month); ps.setInt(2, year);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Payroll getPayrollById(int id) {
        String sql = "SELECT p.*, CONCAT(e.first_name,' ',e.last_name) AS employee_name, "
                   + "e.emp_code, d.name AS dept_name, e.designation "
                   + "FROM payroll p "
                   + "JOIN employees e ON p.employee_id = e.id "
                   + "LEFT JOIN departments d ON e.department_id = d.id "
                   + "WHERE p.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public BigDecimal getTotalPayrollThisMonth(int month, int year) {
        String sql = "SELECT COALESCE(SUM(net_salary),0) FROM payroll WHERE month=? AND year=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month); ps.setInt(2, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return BigDecimal.ZERO;
    }

    /** Fetch a single payroll record for one employee for a specific month/year. */
    public Payroll getPayrollByEmployeeMonthYear(int employeeId, int month, int year) {
        String sql = "SELECT p.*, CONCAT(e.first_name,' ',e.last_name) AS employee_name, "
                   + "e.emp_code, d.name AS dept_name, e.designation "
                   + "FROM payroll p "
                   + "JOIN employees e ON p.employee_id = e.id "
                   + "LEFT JOIN departments d ON e.department_id = d.id "
                   + "WHERE p.employee_id = ? AND p.month = ? AND p.year = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, employeeId); ps.setInt(2, month); ps.setInt(3, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
}
