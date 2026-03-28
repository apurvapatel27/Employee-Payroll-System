package controller;

import dao.PayrollDAO;
import model.Employee;
import model.Payroll;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/payslip")
public class PayslipServlet extends HttpServlet {

    private final PayrollDAO payrollDAO = new PayrollDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        boolean isAdmin    = session != null && session.getAttribute("admin")          != null;
        boolean isEmployee = session != null && session.getAttribute("loggedEmployee") != null;

        // Must be logged in as either admin or employee
        if (!isAdmin && !isEmployee) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        Payroll payroll = payrollDAO.getPayrollById(id);

        if (payroll == null) {
            response.sendError(404, "Payslip not found.");
            return;
        }

        // Employees can only view their OWN payslip
        if (isEmployee && !isAdmin) {
            Employee emp = (Employee) session.getAttribute("loggedEmployee");
            if (payroll.getEmployeeId() != emp.getId()) {
                response.sendError(403, "Access denied.");
                return;
            }
        }

        request.setAttribute("payroll", payroll);
        request.getRequestDispatcher("/views/payslip.jsp").forward(request, response);
    }
}
