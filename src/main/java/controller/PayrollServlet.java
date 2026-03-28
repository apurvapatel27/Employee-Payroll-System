package controller;

import dao.EmployeeDAO;
import dao.PayrollDAO;
import model.Employee;
import model.Payroll;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

@WebServlet("/payroll")
public class PayrollServlet extends HttpServlet {

    private final PayrollDAO  payrollDAO  = new PayrollDAO();
    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    private boolean requireAuth(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("admin") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!requireAuth(request, response)) return;

        Calendar cal  = Calendar.getInstance();
        int month     = cal.get(Calendar.MONTH) + 1;
        int year      = cal.get(Calendar.YEAR);
        String mParam = request.getParameter("month");
        String yParam = request.getParameter("year");
        if (mParam != null && !mParam.isEmpty()) month = Integer.parseInt(mParam);
        if (yParam != null && !yParam.isEmpty()) year  = Integer.parseInt(yParam);

        List<Payroll> payrolls = payrollDAO.getPayrollByMonthYear(month, year);
        request.setAttribute("payrolls",      payrolls);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear",  year);
        request.getRequestDispatcher("/views/payroll.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!requireAuth(request, response)) return;

        int month = Integer.parseInt(request.getParameter("month"));
        int year  = Integer.parseInt(request.getParameter("year"));

        // Generate payroll for every Active employee
        List<Employee> employees = employeeDAO.getAllEmployees();
        for (Employee emp : employees) {
            if ("Active".equals(emp.getStatus())) {
                payrollDAO.generatePayroll(emp.getId(), month, year, emp.getBasicSalary());
            }
        }
        response.sendRedirect(request.getContextPath() + "/payroll?month=" + month + "&year=" + year);
    }
}
