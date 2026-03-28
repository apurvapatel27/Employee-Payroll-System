package controller;

import dao.DepartmentDAO;
import dao.EmployeeDAO;
import dao.PayrollDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Calendar;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final EmployeeDAO   employeeDAO   = new EmployeeDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();
    private final PayrollDAO    payrollDAO    = new PayrollDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Calendar cal         = Calendar.getInstance();
        int currentMonth     = cal.get(Calendar.MONTH) + 1;
        int currentYear      = cal.get(Calendar.YEAR);

        int totalEmployees   = employeeDAO.getTotalEmployees();
        int activeEmployees  = employeeDAO.getActiveEmployees();
        int departmentCount  = departmentDAO.getDepartmentCount();
        BigDecimal payrollAmt = payrollDAO.getTotalPayrollThisMonth(currentMonth, currentYear);

        request.setAttribute("totalEmployees",  totalEmployees);
        request.setAttribute("activeEmployees", activeEmployees);
        request.setAttribute("departmentCount", departmentCount);
        request.setAttribute("totalPayroll",    payrollAmt);
        request.setAttribute("currentMonth",    currentMonth);
        request.setAttribute("currentYear",     currentYear);

        request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
    }
}
