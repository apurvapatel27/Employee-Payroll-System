package controller;

import dao.EmployeeDAO;
import model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/employee-login")
public class EmployeeLoginServlet extends HttpServlet {

    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Already logged in as employee → go to employee dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedEmployee") != null) {
            response.sendRedirect(request.getContextPath() + "/employee-dashboard");
            return;
        }
        request.getRequestDispatcher("/views/employee-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String empCode  = request.getParameter("empCode");
        String password = request.getParameter("password");

        Employee emp = employeeDAO.validateEmployeeLogin(empCode, password);
        if (emp != null) {
            // Invalidate any existing session first (clean slate)
            HttpSession old = request.getSession(false);
            if (old != null) old.invalidate();

            HttpSession session = request.getSession(true);
            session.setAttribute("loggedEmployee", emp);
            response.sendRedirect(request.getContextPath() + "/employee-dashboard");
        } else {
            request.setAttribute("error", "Invalid Employee Code or Password. Only Active employees can login.");
            request.getRequestDispatcher("/views/employee-login.jsp").forward(request, response);
        }
    }
}
