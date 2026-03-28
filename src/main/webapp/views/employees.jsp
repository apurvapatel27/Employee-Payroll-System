<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employees — PayrollSystem</title>
    <meta name="description" content="Manage employees in the Payroll System">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/templatemo-glass-admin-style.css">
    <style>
        @media print { .sidebar,.mobile-menu-toggle,.site-footer { display:none!important; } }
        /* Modal overlay */
        .modal-overlay { display:none;position:fixed;inset:0;background:rgba(0,0,0,0.6);backdrop-filter:blur(4px);z-index:1000;align-items:center;justify-content:center; }
        .modal-overlay.open { display:flex; }
        .modal-box { background:var(--glass-bg,rgba(15,14,23,0.95));border:1px solid rgba(255,255,255,0.12);border-radius:20px;padding:2rem;width:100%;max-width:680px;max-height:90vh;overflow-y:auto;box-shadow:0 30px 80px rgba(0,0,0,0.5); }
        .modal-box h3 { font-size:1.2rem;font-weight:700;margin-bottom:1.5rem;color:var(--text-primary,#fff); }
        .modal-grid { display:grid;grid-template-columns:1fr 1fr;gap:1rem; }
        .modal-grid .full { grid-column:span 2; }
        .form-row-modal { display:flex;flex-direction:column;gap:0.4rem; }
        .form-row-modal label { font-size:0.8rem;color:var(--text-muted,rgba(255,255,255,0.5));font-weight:500;text-transform:uppercase;letter-spacing:0.5px; }
        .modal-footer-btns { display:flex;gap:0.75rem;justify-content:flex-end;margin-top:1.5rem; }
        .btn-cancel { background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.12);color:var(--text-secondary,rgba(255,255,255,0.7));padding:0.6rem 1.25rem;border-radius:10px;cursor:pointer;font-family:inherit;font-size:0.875rem;transition:all 0.2s; }
        .btn-cancel:hover { background:rgba(255,255,255,0.1); }
        .btn-save { background:linear-gradient(135deg,var(--emerald-light,#34d399),var(--emerald,#10b981));border:none;color:#fff;padding:0.6rem 1.5rem;border-radius:10px;cursor:pointer;font-family:inherit;font-size:0.875rem;font-weight:600;transition:all 0.2s; }
        .btn-save:hover { opacity:0.9;transform:translateY(-1px); }
        .action-btn { padding:5px 10px;border-radius:8px;font-size:0.78rem;cursor:pointer;font-family:inherit;border:1px solid transparent;transition:all 0.2s; }
        .btn-edit { background:rgba(251,191,36,0.15);border-color:rgba(251,191,36,0.4);color:#fbbf24; }
        .btn-edit:hover { background:rgba(251,191,36,0.25); }
        .btn-delete { background:rgba(239,68,68,0.15);border-color:rgba(239,68,68,0.4);color:#f87171; }
        .btn-delete:hover { background:rgba(239,68,68,0.25); }
    </style>
</head>
<body>
    <div class="background"></div>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <div class="dashboard">
        <%@ include file="navbar.jsp" %>

        <main class="main-content">
            <nav class="navbar">
                <div class="page-header">
                    <h1 class="page-title">Employees</h1>
                    <div class="page-breadcrumb">
                        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                        <span>/</span><span>Employees</span>
                    </div>
                </div>
                <div class="navbar-right">
                    <div class="search-box">
                        <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
                        </svg>
                        <input type="text" class="search-input" id="tableSearch" placeholder="Search employees..." oninput="filterTable(this.value)">
                    </div>
                    <button class="nav-btn" id="theme-toggle" title="Toggle Theme">
                        <svg class="icon-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="4"/><path d="M12 2v2"/><path d="M12 20v2"/>
                            <path d="M4.93 4.93l1.41 1.41"/><path d="M17.66 17.66l1.41 1.41"/>
                            <path d="M2 12h2"/><path d="M20 12h2"/>
                        </svg>
                        <svg class="icon-moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display:none;">
                            <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/>
                        </svg>
                    </button>
                </div>
            </nav>

            <!-- Stats -->
            <section class="stats-grid" style="grid-template-columns:repeat(3,1fr);">
                <div class="glass-card glass-card-3d stat-card">
                    <div class="stat-card-inner">
                        <div class="stat-info">
                            <h3>Total Employees</h3>
                            <div class="stat-value">${employees.size()}</div>
                        </div>
                        <div class="stat-icon cyan">
                            <svg viewBox="0 0 24 24" fill="none" stroke="var(--emerald-light)" stroke-width="2">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/>
                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                            </svg>
                        </div>
                    </div>
                </div>
                <div class="glass-card glass-card-3d stat-card">
                    <div class="stat-card-inner">
                        <div class="stat-info">
                            <h3>Active</h3>
                            <div class="stat-value" style="color:var(--emerald-light)">
                                <c:set var="ac" value="0"/>
                                <c:forEach var="e" items="${employees}"><c:if test="${e.status=='Active'}"><c:set var="ac" value="${ac+1}"/></c:if></c:forEach>
                                ${ac}
                            </div>
                        </div>
                        <div class="stat-icon success">
                            <svg viewBox="0 0 24 24" fill="none" stroke="var(--success)" stroke-width="2">
                                <polyline points="20 6 9 17 4 12"/>
                            </svg>
                        </div>
                    </div>
                </div>
                <div class="glass-card glass-card-3d stat-card">
                    <div class="stat-card-inner">
                        <div class="stat-info">
                            <h3>Departments</h3>
                            <div class="stat-value">${departments.size()}</div>
                        </div>
                        <div class="stat-icon magenta">
                            <svg viewBox="0 0 24 24" fill="none" stroke="var(--gold)" stroke-width="2">
                                <rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/>
                                <rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Employee Table -->
            <section class="content-grid" style="grid-template-columns:1fr;">
                <div class="glass-card table-card" style="grid-column:span 1;">
                    <div class="card-header">
                        <div>
                            <h2 class="card-title">Employee Directory</h2>
                            <p class="card-subtitle">All registered employees</p>
                        </div>
                        <div class="card-actions">
                            <button class="card-btn" id="btnAddEmployee" onclick="openAddModal()">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:6px;">
                                    <line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/>
                                </svg>
                                Add Employee
                            </button>
                        </div>
                    </div>
                    <div class="table-wrapper">
                        <table class="data-table" id="empTable">
                            <thead>
                                <tr>
                                    <th>#</th><th>Employee</th><th>Department</th>
                                    <th>Designation</th><th>Basic Salary</th><th>Status</th><th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="emp" items="${employees}" varStatus="st">
                                <tr>
                                    <td>${st.count}</td>
                                    <td>
                                        <div class="table-user">
                                            <div class="table-avatar" style="background:linear-gradient(135deg,var(--emerald-light),var(--emerald));">
                                                <c:out value="${emp.firstName.substring(0,1)}${emp.lastName.substring(0,1)}"/>
                                            </div>
                                            <div class="table-user-info">
                                                <span class="table-user-name">${emp.fullName}</span>
                                                <span class="table-user-email">${emp.empCode} &bull; ${emp.email}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${empty emp.departmentName ? '—' : emp.departmentName}</td>
                                    <td>${emp.designation}</td>
                                    <td><span class="table-amount">&#8377;<fmt:formatNumber value="${emp.basicSalary}" type="number" maxFractionDigits="0"/></span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${emp.status == 'Active'}"><span class="status-badge completed">Active</span></c:when>
                                            <c:otherwise><span class="status-badge processing">Inactive</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="display:flex;gap:6px;flex-wrap:wrap;">
                                        <button class="action-btn btn-edit" title="Edit"
                                            onclick="openEditModal(${emp.id},'${emp.empCode}','${emp.firstName}','${emp.lastName}','${emp.email}','${emp.phone}',${emp.departmentId},'${emp.designation}','${emp.basicSalary}','${emp.joinDate}','${emp.status}')">
                                            Edit
                                        </button>
                                        <a href="${pageContext.request.contextPath}/employees?action=delete&id=${emp.id}"
                                           class="action-btn btn-delete"
                                           onclick="return confirm('Delete ${emp.fullName}?')">Delete</a>
                                    </td>
                                </tr>
                                </c:forEach>
                                <c:if test="${empty employees}">
                                <tr><td colspan="7" style="text-align:center;padding:2rem;color:var(--text-muted);">No employees found. Add one to get started.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <!-- Add/Edit Modal -->
    <div class="modal-overlay" id="empModal">
        <div class="modal-box">
            <h3 id="modalTitle">Add Employee</h3>
            <form id="empForm" method="post" action="${pageContext.request.contextPath}/employees">
                <input type="hidden" name="action" id="formAction" value="add">
                <input type="hidden" name="id"     id="formId"     value="">
                <div class="modal-grid">
                    <div class="form-row-modal">
                        <label>Employee Code *</label>
                        <input type="text" class="form-input" name="empCode" id="fEmpCode" required>
                    </div>
                    <div class="form-row-modal">
                        <label>Department *</label>
                        <select class="form-input" name="departmentId" id="fDept" required style="background:transparent;">
                            <option value="">— Select —</option>
                            <c:forEach var="dept" items="${departments}">
                                <option value="${dept.id}">${dept.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-row-modal">
                        <label>First Name *</label>
                        <input type="text" class="form-input" name="firstName" id="fFirst" required>
                    </div>
                    <div class="form-row-modal">
                        <label>Last Name *</label>
                        <input type="text" class="form-input" name="lastName" id="fLast" required>
                    </div>
                    <div class="form-row-modal">
                        <label>Email</label>
                        <input type="email" class="form-input" name="email" id="fEmail">
                    </div>
                    <div class="form-row-modal">
                        <label>Phone</label>
                        <input type="text" class="form-input" name="phone" id="fPhone">
                    </div>
                    <div class="form-row-modal full">
                        <label>Designation *</label>
                        <input type="text" class="form-input" name="designation" id="fDesig" required>
                    </div>
                    <div class="form-row-modal">
                        <label>Basic Salary (&#8377;) *</label>
                        <input type="number" step="0.01" min="0" class="form-input" name="basicSalary" id="fSalary" required>
                    </div>
                    <div class="form-row-modal">
                        <label>Join Date</label>
                        <input type="date" class="form-input" name="joinDate" id="fJoinDate">
                    </div>
                    <div class="form-row-modal full">
                        <label>Status *</label>
                        <select class="form-input" name="status" id="fStatus" required style="background:transparent;">
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer-btns">
                    <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn-save" id="btnSaveEmp">Save Employee</button>
                </div>
            </form>
        </div>
    </div>

    <button class="mobile-menu-toggle" id="mobileMenuToggle">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="18" x2="21" y2="18"/>
        </svg>
    </button>
    <footer class="site-footer"><p>Copyright &copy; 2026 PayrollSystem</p></footer>

    <script src="${pageContext.request.contextPath}/assets/templatemo-glass-admin-script.js"></script>
    <script>
        document.getElementById('navEmployees').classList.add('active');

        function openAddModal() {
            document.getElementById('modalTitle').textContent = 'Add Employee';
            document.getElementById('formAction').value = 'add';
            document.getElementById('formId').value = '';
            document.getElementById('empForm').reset();
            document.getElementById('empModal').classList.add('open');
        }

        function openEditModal(id, code, first, last, email, phone, deptId, desig, salary, joinDate, status) {
            document.getElementById('modalTitle').textContent = 'Edit Employee';
            document.getElementById('formAction').value = 'update';
            document.getElementById('formId').value    = id;
            document.getElementById('fEmpCode').value  = code;
            document.getElementById('fFirst').value    = first;
            document.getElementById('fLast').value     = last;
            document.getElementById('fEmail').value    = email;
            document.getElementById('fPhone').value    = phone;
            document.getElementById('fDept').value     = deptId;
            document.getElementById('fDesig').value    = desig;
            document.getElementById('fSalary').value   = salary;
            document.getElementById('fJoinDate').value = joinDate;
            document.getElementById('fStatus').value   = status;
            document.getElementById('empModal').classList.add('open');
        }

        function closeModal() { document.getElementById('empModal').classList.remove('open'); }

        document.getElementById('empModal').addEventListener('click', function(e) {
            if (e.target === this) closeModal();
        });

        function filterTable(q) {
            const rows = document.querySelectorAll('#empTable tbody tr');
            q = q.toLowerCase();
            rows.forEach(r => r.style.display = r.textContent.toLowerCase().includes(q) ? '' : 'none');
        }

        <c:if test="${not empty editEmployee}">
        window.addEventListener('DOMContentLoaded', function() {
            openEditModal(${editEmployee.id},'${editEmployee.empCode}',
                '${editEmployee.firstName}','${editEmployee.lastName}',
                '${editEmployee.email}','${editEmployee.phone}',
                ${editEmployee.departmentId},'${editEmployee.designation}',
                '${editEmployee.basicSalary}','${editEmployee.joinDate}','${editEmployee.status}');
        });
        </c:if>
    </script>
</body>
</html>
