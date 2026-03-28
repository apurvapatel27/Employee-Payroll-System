package model;

import java.math.BigDecimal;

public class Payroll {
    private int id;
    private int employeeId;
    private String employeeName;
    private String empCode;
    private String departmentName;
    private String designation;
    private int month;
    private int year;
    private BigDecimal basicSalary;
    private BigDecimal hra;
    private BigDecimal da;
    private BigDecimal grossSalary;
    private BigDecimal pf;
    private BigDecimal tax;
    private BigDecimal netSalary;

    public Payroll() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getEmployeeId() { return employeeId; }
    public void setEmployeeId(int employeeId) { this.employeeId = employeeId; }

    public String getEmployeeName() { return employeeName; }
    public void setEmployeeName(String employeeName) { this.employeeName = employeeName; }

    public String getEmpCode() { return empCode; }
    public void setEmpCode(String empCode) { this.empCode = empCode; }

    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }

    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }

    public int getMonth() { return month; }
    public void setMonth(int month) { this.month = month; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public BigDecimal getBasicSalary() { return basicSalary; }
    public void setBasicSalary(BigDecimal basicSalary) { this.basicSalary = basicSalary; }

    public BigDecimal getHra() { return hra; }
    public void setHra(BigDecimal hra) { this.hra = hra; }

    public BigDecimal getDa() { return da; }
    public void setDa(BigDecimal da) { this.da = da; }

    public BigDecimal getGrossSalary() { return grossSalary; }
    public void setGrossSalary(BigDecimal grossSalary) { this.grossSalary = grossSalary; }

    public BigDecimal getPf() { return pf; }
    public void setPf(BigDecimal pf) { this.pf = pf; }

    public BigDecimal getTax() { return tax; }
    public void setTax(BigDecimal tax) { this.tax = tax; }

    public BigDecimal getNetSalary() { return netSalary; }
    public void setNetSalary(BigDecimal netSalary) { this.netSalary = netSalary; }

    public String getMonthName() {
        String[] months = {"January","February","March","April","May","June",
                           "July","August","September","October","November","December"};
        return (month >= 1 && month <= 12) ? months[month - 1] : String.valueOf(month);
    }
}
