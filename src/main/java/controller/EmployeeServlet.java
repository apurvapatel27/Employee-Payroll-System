package controller;

import dao.DepartmentDAO;
import dao.EmployeeDAO;
import model.Department;
import model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {

    private final EmployeeDAO   employeeDAO   = new EmployeeDAO();
    private final DepartmentDAO departmentDAO = new DepartmentDAO();

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

        String action = request.getParameter("action");
        if (action == null) action = "list";

        // Handle inline delete
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            employeeDAO.deleteEmployee(id);
            response.sendRedirect(request.getContextPath() + "/employees");
            return;
        }

        List<Employee>   employees   = employeeDAO.getAllEmployees();
        List<Department> departments = departmentDAO.getAllDepartments();
        request.setAttribute("employees",   employees);
        request.setAttribute("departments", departments);

        // Pre-populate edit modal
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("editEmployee", employeeDAO.getEmployeeById(id));
        }

        request.getRequestDispatcher("/views/employees.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!requireAuth(request, response)) return;

        String action = request.getParameter("action");
        Employee emp  = buildFromRequest(request);

        if ("add".equals(action)) {
            employeeDAO.addEmployee(emp);
        } else if ("update".equals(action)) {
            emp.setId(Integer.parseInt(request.getParameter("id")));
            employeeDAO.updateEmployee(emp);
        }
        response.sendRedirect(request.getContextPath() + "/employees");
    }

    private Employee buildFromRequest(HttpServletRequest req) {
        Employee e = new Employee();
        e.setEmpCode(req.getParameter("empCode"));
        e.setFirstName(req.getParameter("firstName"));
        e.setLastName(req.getParameter("lastName"));
        e.setEmail(req.getParameter("email"));
        e.setPhone(req.getParameter("phone"));
        e.setDepartmentId(Integer.parseInt(req.getParameter("departmentId")));
        e.setDesignation(req.getParameter("designation"));
        e.setBasicSalary(new BigDecimal(req.getParameter("basicSalary")));
        String jd = req.getParameter("joinDate");
        if (jd != null && !jd.isEmpty()) e.setJoinDate(Date.valueOf(jd));
        e.setStatus(req.getParameter("status"));
        return e;
    }
}
