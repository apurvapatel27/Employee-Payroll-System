<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Payslip — ${emp.fullName} — PayrollSystem</title>
    <meta name="description" content="Employee payslip and salary dashboard">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/templatemo-glass-admin-style.css">
    <style>
        /* Employee sidebar accent — teal instead of purple */
        .sidebar { border-right-color: rgba(16,185,129,0.2); }
        .nav-link.active { background: rgba(16,185,129,0.15) !important; color: #34d399 !important; }
        .nav-link.active svg { stroke: #34d399 !important; }
        .logo { background: linear-gradient(135deg,#10b981,#059669) !important; }

        /* Month/year filter bar */
        .filter-bar { background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);border-radius:14px;padding:1.1rem 1.5rem;margin-bottom:1.5rem;display:flex;align-items:flex-end;gap:1rem;flex-wrap:wrap; }
        .filter-bar label { font-size:0.75rem;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.5px;font-weight:600;display:block;margin-bottom:0.35rem; }
        .filter-bar select { background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.12);color:var(--text-primary,#fff);border-radius:8px;padding:0.5rem 0.75rem;font-family:inherit;font-size:0.875rem; }
        .btn-view { background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.15);color:var(--text-secondary);padding:0.5rem 1.25rem;border-radius:10px;cursor:pointer;font-family:inherit;font-size:0.875rem;transition:all 0.2s; }
        .btn-view:hover { background:rgba(255,255,255,0.1); }

        /* Salary breakdown card */
        .salary-card { background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);border-radius:16px;overflow:hidden; }
        .salary-card-header { padding:1.2rem 1.5rem;border-bottom:1px solid rgba(255,255,255,0.07);display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:0.75rem; }
        .salary-card-header h2 { font-size:1rem;font-weight:700;color:#fff;margin:0; }
        .salary-card-header p { font-size:0.8rem;color:var(--text-muted);margin:0; }
        .salary-body { padding:1.5rem; }
        .row-group-title { font-size:0.7rem;text-transform:uppercase;letter-spacing:0.8px;color:var(--text-muted);font-weight:700;margin-bottom:0.6rem;margin-top:1.1rem; }
        .row-group-title:first-child { margin-top:0; }
        .sal-row { display:flex;justify-content:space-between;align-items:center;padding:0.55rem 0.75rem;border-radius:8px;font-size:0.9rem;transition:background 0.15s; }
        .sal-row:hover { background:rgba(255,255,255,0.04); }
        .sal-row .sal-label { color:rgba(255,255,255,0.65); }
        .sal-row .sal-value { font-weight:600;color:#fff; }
        .sal-row.deduction .sal-value { color:#f87171; }
        .sal-row.subtotal { background:rgba(255,255,255,0.06);margin-top:0.35rem; }
        .sal-row.subtotal .sal-label { font-weight:700;color:#fff; }
        .sal-row.subtotal .sal-value { color:var(--emerald-light,#34d399);font-weight:700; }
        .net-banner { margin:1.5rem;background:linear-gradient(135deg,rgba(16,185,129,0.12),rgba(5,150,105,0.08));border:2px solid rgba(16,185,129,0.3);border-radius:14px;padding:1.4rem 1.8rem;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:1rem; }
        .net-banner .net-label { font-size:1rem;font-weight:700;color:#fff; }
        .net-banner .net-amount { font-size:2rem;font-weight:900;color:#34d399; }
        .btn-print { background:linear-gradient(135deg,#10b981,#059669);border:none;color:#fff;padding:0.55rem 1.4rem;border-radius:10px;cursor:pointer;font-family:inherit;font-size:0.875rem;font-weight:600;transition:all 0.2s; }
        .btn-print:hover { opacity:0.9;transform:translateY(-1px); }

        /* Empty state */
        .empty-state { text-align:center;padding:3.5rem 1rem;color:var(--text-muted); }
        .empty-state .icon { font-size:3.5rem;margin-bottom:1rem;display:block; }

        @media print {
            .sidebar,.filter-bar,.mobile-menu-toggle,.site-footer,.navbar,.btn-print,.filter-bar { display:none!important; }
            .main-content { margin-left:0!important;padding:0!important; }
        }
    </style>
</head>
<body>
    <div class="background"></div>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <div class="dashboard">
        <!-- Employee Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="logo">&#128100;</div>
                <span class="logo-text">My Payslip</span>
            </div>

            <ul class="nav-menu">
                <li class="nav-section">
                    <span class="nav-section-title">Employee Menu</span>
                    <ul>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/employee-dashboard" class="nav-link active" id="navMyPayslip">
                                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <line x1="12" y1="1" x2="12" y2="23"/>
                                    <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
                                </svg>
                                My Salary
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-section">
                    <span class="nav-section-title">Account</span>
                    <ul>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/employee-logout" class="nav-link" id="navEmpLogout">
                                <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                                    <polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/>
                                </svg>
                                Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>

            <div class="sidebar-footer">
                <div class="user-profile">
                    <div class="user-avatar" style="background:linear-gradient(135deg,#10b981,#059669)">
                        <c:out value="${emp.firstName.substring(0,1)}${emp.lastName.substring(0,1)}"/>
                    </div>
                    <div class="user-info">
                        <div class="user-name"><c:out value="${emp.fullName}"/></div>
                        <div class="user-role"><c:out value="${emp.empCode}"/></div>
                    </div>
                </div>
            </div>
        </aside>

        <main class="main-content">
            <!-- Top Nav -->
            <nav class="navbar">
                <div class="page-header">
                    <h1 class="page-title">My Salary Details</h1>
                    <div class="page-breadcrumb">
                        <span>Employee Portal</span>
                        <span>/</span>
                        <span><c:out value="${emp.fullName}"/></span>
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

            <!-- Employee Info Cards -->
            <section class="stats-grid" style="grid-template-columns:repeat(3,1fr);">
                <div class="glass-card glass-card-3d stat-card">
                    <div class="stat-card-inner">
                        <div class="stat-info">
                            <h3>Employee Code</h3>
                            <div class="stat-value" style="font-size:1.4rem;font-family:'Space Mono',monospace">${emp.empCode}</div>
                        </div>
                        <div class="stat-icon cyan">
                            <svg viewBox="0 0 24 24" fill="none" stroke="var(--emerald-light)" stroke-width="2">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>
                            </svg>
                        </div>
                    </div>
                </div>
                <div class="glass-card glass-card-3d stat-card">
                    <div class="stat-card-inner">
                        <div class="stat-info">
                            <h3>Department</h3>
                            <div class="stat-value" style="font-size:1.1rem;">${empty emp.departmentName ? '—' : emp.departmentName}</div>
                        </div>
                        <div class="stat-icon magenta">
                            <svg viewBox="0 0 24 24" fill="none" stroke="var(--gold)" stroke-width="2">
                                <rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/>
                                <rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/>
                            </svg>
                        </div>
                    </div>
                </div>
                <div class="glass-card glass-card-3d stat-card">
                    <div class="stat-card-inner">
                        <div class="stat-info">
                            <h3>Basic Salary</h3>
                            <div class="stat-value" style="font-size:1.4rem;color:#34d399;">
                                &#8377;<fmt:formatNumber value="${emp.basicSalary}" type="number" maxFractionDigits="0"/>
                            </div>
                        </div>
                        <div class="stat-icon success">
                            <svg viewBox="0 0 24 24" fill="none" stroke="var(--success)" stroke-width="2">
                                <line x1="12" y1="1" x2="12" y2="23"/>
                                <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Month/Year Filter -->
            <div class="filter-bar d-print-none">
                <form method="get" action="${pageContext.request.contextPath}/employee-dashboard" id="filterForm" style="display:flex;align-items:flex-end;gap:0.75rem;flex-wrap:wrap;">
                    <div>
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
                    <div>
                        <label>Year</label>
                        <select name="year" id="selYear">
                            <option value="2022" ${selectedYear==2022?'selected':''}>2022</option>
                            <option value="2023" ${selectedYear==2023?'selected':''}>2023</option>
                            <option value="2024" ${selectedYear==2024?'selected':''}>2024</option>
                            <option value="2025" ${selectedYear==2025?'selected':''}>2025</option>
                            <option value="2026" ${selectedYear==2026?'selected':''}>2026</option>
                        </select>
                    </div>
                    <button type="submit" class="btn-view" id="btnViewMonth">View</button>
                </form>
            </div>

            <!-- Salary Breakdown -->
            <c:choose>
                <c:when test="${not empty payroll}">
                    <!-- Breakdown Card -->
                    <div class="salary-card" style="margin-bottom:1.5rem;">
                        <div class="salary-card-header">
                            <div>
                                <h2>Salary Breakdown — ${payroll.monthName} ${payroll.year}</h2>
                                <p>Your detailed salary components for this month</p>
                            </div>
                            <button class="btn-print d-print-none" onclick="window.print()" id="btnPrint">
                                &#128438; Print Payslip
                            </button>
                        </div>
                        <div class="salary-body">
                            <!-- Earnings -->
                            <div class="row-group-title">&#128200; Earnings</div>
                            <div class="sal-row">
                                <span class="sal-label">Basic Salary</span>
                                <span class="sal-value">&#8377; <fmt:formatNumber value="${payroll.basicSalary}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                            </div>
                            <div class="sal-row">
                                <span class="sal-label">House Rent Allowance (HRA) <small style="opacity:0.6">40% of Basic</small></span>
                                <span class="sal-value">&#8377; <fmt:formatNumber value="${payroll.hra}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                            </div>
                            <div class="sal-row">
                                <span class="sal-label">Dearness Allowance (DA) <small style="opacity:0.6">10% of Basic</small></span>
                                <span class="sal-value">&#8377; <fmt:formatNumber value="${payroll.da}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                            </div>
                            <div class="sal-row subtotal">
                                <span class="sal-label">Gross Salary</span>
                                <span class="sal-value">&#8377; <fmt:formatNumber value="${payroll.grossSalary}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                            </div>

                            <!-- Deductions -->
                            <div class="row-group-title" style="margin-top:1.5rem;">&#128203; Deductions</div>
                            <div class="sal-row deduction">
                                <span class="sal-label">Provident Fund (PF) <small style="opacity:0.6">12% of Basic</small></span>
                                <span class="sal-value">- &#8377; <fmt:formatNumber value="${payroll.pf}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                            </div>
                            <div class="sal-row deduction">
                                <span class="sal-label">Income Tax <small style="opacity:0.6">5% of Gross</small></span>
                                <span class="sal-value">- &#8377; <fmt:formatNumber value="${payroll.tax}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                            </div>
                        </div>

                        <!-- Net Pay Banner -->
                        <div class="net-banner">
                            <div class="net-label">&#128176; Net Pay (Take-Home)</div>
                            <div class="net-amount">&#8377; <fmt:formatNumber value="${payroll.netSalary}" type="number" minFractionDigits="2" maxFractionDigits="2"/></div>
                        </div>

                        <!-- Print view: full payslip link -->
                        <div style="padding:0 1.5rem 1.5rem;text-align:right;" class="d-print-none">
                            <a href="${pageContext.request.contextPath}/payslip?id=${payroll.id}"
                               target="_blank" id="linkFullPayslip"
                               style="color:var(--emerald-light,#34d399);font-size:0.85rem;text-decoration:none;">
                                &#128196; Open full printable payslip &rarr;
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Empty state -->
                    <div class="salary-card">
                        <div class="empty-state">
                            <span class="icon">&#128203;</span>
                            <h3 style="color:#fff;margin-bottom:0.5rem;">No Payroll Found</h3>
                            <p>No salary record exists for <strong>${selectedMonth}/${selectedYear}</strong>.</p>
                            <p style="font-size:0.85rem;margin-top:0.5rem;">Please contact your HR/Admin to generate payroll for this month.</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>

    <button class="mobile-menu-toggle" id="mobileMenuToggle">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="18" x2="21" y2="18"/>
        </svg>
    </button>

    <footer class="site-footer"><p>Copyright &copy; 2026 PayrollSystem &mdash; Employee Portal</p></footer>

    <script src="${pageContext.request.contextPath}/assets/templatemo-glass-admin-script.js"></script>
</body>
</html>
