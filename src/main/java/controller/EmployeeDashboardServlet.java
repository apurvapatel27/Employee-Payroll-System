package controller;

import dao.PayrollDAO;
import model.Employee;
import model.Payroll;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Calendar;

@WebServlet("/employee-dashboard")
public class EmployeeDashboardServlet extends HttpServlet {

    private final PayrollDAO payrollDAO = new PayrollDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Block non-employees — redirect to employee login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedEmployee") == null) {
            response.sendRedirect(request.getContextPath() + "/employee-login");
            return;
        }

        // 2. Block admins from using this page — they must use /dashboard
        if (session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        Employee emp = (Employee) session.getAttribute("loggedEmployee");

        // 3. Resolve month/year (default = current)
        Calendar cal  = Calendar.getInstance();
        int month     = cal.get(Calendar.MONTH) + 1;
        int year      = cal.get(Calendar.YEAR);
        String mParam = request.getParameter("month");
        String yParam = request.getParameter("year");
        if (mParam != null && !mParam.isEmpty()) month = Integer.parseInt(mParam);
        if (yParam != null && !yParam.isEmpty()) year  = Integer.parseInt(yParam);

        // 4. Fetch this employee's payroll for the chosen month/year
        Payroll payroll = payrollDAO.getPayrollByEmployeeMonthYear(emp.getId(), month, year);

        request.setAttribute("emp",           emp);
        request.setAttribute("payroll",       payroll);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear",  year);

        request.getRequestDispatcher("/views/employee-dashboard.jsp").forward(request, response);
    }
}
