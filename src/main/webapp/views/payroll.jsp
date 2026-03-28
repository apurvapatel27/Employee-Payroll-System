<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payroll — PayrollSystem</title>
    <meta name="description" content="Generate and manage monthly payroll">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/templatemo-glass-admin-style.css">
    <style>
        @media print { .sidebar,.mobile-menu-toggle,.site-footer { display:none!important; } }
        .filter-glass { background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);border-radius:14px;padding:1.25rem 1.5rem;margin-bottom:1.5rem;display:flex;align-items:flex-end;justify-content:space-between;flex-wrap:wrap;gap:1rem; }
        .filter-group { display:flex;align-items:flex-end;gap:0.75rem;flex-wrap:wrap; }
        .filter-field { display:flex;flex-direction:column;gap:0.35rem; }
        .filter-field label { font-size:0.75rem;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.5px;font-weight:600; }
        .filter-field select { background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.12);color:var(--text-primary,#fff);border-radius:8px;padding:0.5rem 0.75rem;font-family:inherit;font-size:0.875rem; }
        .btn-generate { background:linear-gradient(135deg,var(--emerald-light,#34d399),var(--emerald,#10b981));border:none;color:#fff;padding:0.55rem 1.5rem;border-radius:10px;cursor:pointer;font-family:inherit;font-size:0.875rem;font-weight:600;transition:all 0.2s; }
        .btn-generate:hover { opacity:0.9;transform:translateY(-1px); }
        .btn-view { background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.15);color:var(--text-secondary,rgba(255,255,255,0.7));padding:0.55rem 1.25rem;border-radius:10px;cursor:pointer;font-family:inherit;font-size:0.875rem;transition:all 0.2s; }
        .btn-view:hover { background:rgba(255,255,255,0.1); }
        .total-row td { border-top:2px solid rgba(255,255,255,0.15)!important;font-weight:700;color:var(--emerald-light,#34d399)!important; }
        .payslip-link { background:rgba(99,102,241,0.15);border:1px solid rgba(99,102,241,0.4);color:#818cf8;padding:4px 10px;border-radius:8px;font-size:0.78rem;text-decoration:none;transition:all 0.2s; }
        .payslip-link:hover { background:rgba(99,102,241,0.25); }
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
                    <h1 class="page-title">Payroll</h1>
                    <div class="page-breadcrumb">
                        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                        <span>/</span><span>Payroll</span>
                    </div>
                </div>
                <div class="navbar-right">
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

            <!-- Filter + Generate -->
            <div class="filter-glass">
                <form method="get" action="${pageContext.request.contextPath}/payroll" id="filterForm" class="filter-group">
                    <div class="filter-field">
                        <label>Month</label>
                        <select name="month" id="selMonth">
                            <option value="1"  ${selectedMonth==1  ?'selected':''}>January</option>
                            <option value="2"  ${selectedMonth==2  ?'selected':''}>February</option>
                            <option value="3"  ${selectedMonth==3  ?'selected':''}>March</option>
                            <option value="4"  ${selectedMonth==4  ?'selected':''}>April</option>
                            <option value="5"  ${selectedMonth==5  ?'selected':''}>May</option>
                            <option value="6"  ${selectedMonth==6  ?'selected':''}>June</option>
                            <option value="7"  ${selectedMonth==7  ?'selected':''}>July</option>
                            <option value="8"  ${selectedMonth==8  ?'selected':''}>August</option>
                            <option value="9"  ${selectedMonth==9  ?'selected':''}>September</option>
                            <option value="10" ${selectedMonth==10 ?'selected':''}>October</option>
                            <option value="11" ${selectedMonth==11 ?'selected':''}>November</option>
                            <option value="12" ${selectedMonth==12 ?'selected':''}>December</option>
                        </select>
                    </div>
                    <div class="filter-field">
                        <label>Year</label>
                        <select name="year" id="selYear">
                            <option value="2022" ${selectedYear==2022?'selected':''}>2022</option>
                            <option value="2023" ${selectedYear==2023?'selected':''}>2023</option>
                            <option value="2024" ${selectedYear==2024?'selected':''}>2024</option>
                            <option value="2025" ${selectedYear==2025?'selected':''}>2025</option>
                            <option value="2026" ${selectedYear==2026?'selected':''}>2026</option>
                            <option value="2027" ${selectedYear==2027?'selected':''}>2027</option>
                        </select>
                    </div>
                    <button type="submit" class="btn-view" id="btnViewPayroll">View Records</button>
                </form>

                <form method="post" action="${pageContext.request.contextPath}/payroll" id="generateForm"
                      onsubmit="return confirm('Generate payroll for all active employees?')">
                    <input type="hidden" name="month" value="${selectedMonth}">
                    <input type="hidden" name="year"  value="${selectedYear}">
                    <button type="submit" class="btn-generate" id="btnGenerate">&#9889; Generate Payroll</button>
                </form>
            </div>

            <!-- Payroll Table -->
            <section class="content-grid" style="grid-template-columns:1fr;">
                <div class="glass-card table-card" style="grid-column:span 1;">
                    <div class="card-header">
                        <div>
                            <h2 class="card-title">
                                Payroll — ${empty payrolls ? 'No records' : payrolls[0].monthName} ${selectedYear}
                            </h2>
                            <p class="card-subtitle">${payrolls.size()} payroll records</p>
                        </div>
                    </div>
                    <div class="table-wrapper">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>#</th><th>Employee</th><th>Dept</th>
                                    <th>Basic</th><th>HRA</th><th>DA</th><th>Gross</th>
                                    <th>PF</th><th>Tax</th><th>Net Pay</th><th>Payslip</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="totalNet" value="0"/>
                                <c:forEach var="p" items="${payrolls}" varStatus="st">
                                <c:set var="totalNet" value="${totalNet + p.netSalary}"/>
                                <tr>
                                    <td>${st.count}</td>
                                    <td>
                                        <div class="table-user">
                                            <div class="table-avatar" style="background:linear-gradient(135deg,var(--emerald-light),var(--emerald));">
                                                ${p.employeeName.substring(0,1)}
                                            </div>
                                            <div class="table-user-info">
                                                <span class="table-user-name">${p.employeeName}</span>
                                                <span class="table-user-email">${p.empCode} &bull; ${p.designation}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${p.departmentName}</td>
                                    <td><fmt:formatNumber value="${p.basicSalary}" type="number" maxFractionDigits="0"/></td>
                                    <td><fmt:formatNumber value="${p.hra}"         type="number" maxFractionDigits="0"/></td>
                                    <td><fmt:formatNumber value="${p.da}"          type="number" maxFractionDigits="0"/></td>
                                    <td><fmt:formatNumber value="${p.grossSalary}" type="number" maxFractionDigits="0"/></td>
                                    <td style="color:#f87171"><fmt:formatNumber value="${p.pf}"  type="number" maxFractionDigits="0"/></td>
                                    <td style="color:#f87171"><fmt:formatNumber value="${p.tax}" type="number" maxFractionDigits="0"/></td>
                                    <td><span class="table-amount">&#8377;<fmt:formatNumber value="${p.netSalary}" type="number" maxFractionDigits="0"/></span></td>
                                    <td><a href="${pageContext.request.contextPath}/payslip?id=${p.id}" class="payslip-link" target="_blank">View</a></td>
                                </tr>
                                </c:forEach>
                                <c:if test="${not empty payrolls}">
                                <tr class="total-row">
                                    <td colspan="9" style="text-align:right;padding-right:1rem;">Total Net Payable:</td>
                                    <td colspan="2">&#8377;<fmt:formatNumber value="${totalNet}" type="number" maxFractionDigits="0"/></td>
                                </tr>
                                </c:if>
                                <c:if test="${empty payrolls}">
                                <tr><td colspan="11" style="text-align:center;padding:2.5rem;color:var(--text-muted);">
                                    No records for this period. Click <strong>Generate Payroll</strong> to create them.
                                </td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <button class="mobile-menu-toggle" id="mobileMenuToggle">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="18" x2="21" y2="18"/>
        </svg>
    </button>
    <footer class="site-footer"><p>Copyright &copy; 2026 PayrollSystem</p></footer>

    <script src="${pageContext.request.contextPath}/assets/templatemo-glass-admin-script.js"></script>
    <script>document.getElementById('navPayroll').classList.add('active');</script>
</body>
</html>
