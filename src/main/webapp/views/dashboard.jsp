<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — PayrollSystem</title>
    <meta name="description" content="Payroll System Admin Dashboard">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/templatemo-glass-admin-style.css">
    <style>
        @media print { .sidebar, .mobile-menu-toggle, .site-footer, .navbar { display: none !important; } }
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
            <!-- Top Navbar -->
            <nav class="navbar">
                <h1 class="page-title">Dashboard Overview</h1>
                <div class="navbar-right">
                    <button class="nav-btn" id="theme-toggle" title="Toggle Light/Dark Mode">
                        <svg class="icon-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="4"/><path d="M12 2v2"/><path d="M12 20v2"/>
                            <path d="M4.93 4.93l1.41 1.41"/><path d="M17.66 17.66l1.41 1.41"/>
                            <path d="M2 12h2"/><path d="M20 12h2"/>
                            <path d="M6.34 17.66l-1.41 1.41"/><path d="M19.07 4.93l-1.41 1.41"/>
                        </svg>
                        <svg class="icon-moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display:none;">
                            <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/>
                        </svg>
                    </button>
                </div>
            </nav>

            <!-- 4 Stat Cards -->
            <section class="stats-grid">
                <!-- Total Employees -->
                <div class="glass-card glass-card-3d stat-card">
                    <div class="stat-card-inner">
                        <div class="stat-info">
                            <h3>Total Employees</h3>
                            <div class="stat-value">${totalEmployees}</div>
                            <span class="stat-change positive">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/></svg>
                                All staff
                            </span>
                        </div>
                        <div class="stat-icon cyan">
                            <svg viewBox="0 0 24 24" fill="none" stroke="var(--emerald-light)" stroke-width="2">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                                <circle cx="9" cy="7" r="4"/>
                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Monthly Payroll -->
                <div class="glass-card glass-card-3d stat-card">
                    <div class="stat-card-inner">
                        <div class="stat-info">
                            <h3>Payroll This Month</h3>
                            <div class="stat-value" style="font-size:1.6rem;">
                                &#8377;<fmt:formatNumber value="${totalPayroll}" type="number" maxFractionDigits="0"/>
                            </div>
                            <span class="stat-change positive">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/></svg>
                                Month ${currentMonth} / ${currentYear}
                            </span>
                        </div>
                        <div class="stat-icon magenta">
                            <svg viewBox="0 0 24 24" fill="none" stroke="var(--gold)" stroke-width="2">
                                <line x1="12" y1="1" x2="12" y2="23"/>
                                <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Active Employees -->
                <div class="glass-card glass-card-3d stat-card">
                    <div class="stat-card-inner">
                        <div class="stat-info">
                            <h3>Active Employees</h3>
                            <div class="stat-value">${activeEmployees}</div>
                            <span class="stat-change positive">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/></svg>
                                On payroll
                            </span>
                        </div>
                        <div class="stat-icon purple">
                            <svg viewBox="0 0 24 24" fill="none" stroke="var(--coral)" stroke-width="2">
                                <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                                <circle cx="8.5" cy="7" r="4"/>
                                <line x1="20" y1="8" x2="20" y2="14"/><line x1="23" y1="11" x2="17" y2="11"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Departments -->
                <div class="glass-card glass-card-3d stat-card">
                    <div class="stat-card-inner">
                        <div class="stat-info">
                            <h3>Departments</h3>
                            <div class="stat-value">${departmentCount}</div>
                            <span class="stat-change positive">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/></svg>
                                Org units
                            </span>
                        </div>
                        <div class="stat-icon success">
                            <svg viewBox="0 0 24 24" fill="none" stroke="var(--success)" stroke-width="2">
                                <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Quick Actions + Summary -->
            <section class="content-grid">
                <div class="glass-card chart-card">
                    <div class="card-header">
                        <div>
                            <h2 class="card-title">Quick Actions</h2>
                            <p class="card-subtitle">Common payroll tasks</p>
                        </div>
                    </div>
                    <div style="display:flex;flex-direction:column;gap:0.75rem;padding-top:0.5rem;">
                        <a href="${pageContext.request.contextPath}/employees" id="btnGoEmployees"
                           style="display:flex;align-items:center;gap:0.75rem;padding:1rem 1.25rem;
                                  background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);
                                  border-radius:12px;color:var(--text-primary);text-decoration:none;transition:all 0.2s;"
                           onmouseover="this.style.background='rgba(255,255,255,0.08)'"
                           onmouseout="this.style.background='rgba(255,255,255,0.04)'">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--emerald-light)" stroke-width="2">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/>
                                <line x1="20" y1="8" x2="20" y2="14"/><line x1="23" y1="11" x2="17" y2="11"/>
                            </svg>
                            <span>Manage Employees</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/payroll" id="btnGoPayroll"
                           style="display:flex;align-items:center;gap:0.75rem;padding:1rem 1.25rem;
                                  background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);
                                  border-radius:12px;color:var(--text-primary);text-decoration:none;transition:all 0.2s;"
                           onmouseover="this.style.background='rgba(255,255,255,0.08)'"
                           onmouseout="this.style.background='rgba(255,255,255,0.04)'">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--gold)" stroke-width="2">
                                <line x1="12" y1="1" x2="12" y2="23"/>
                                <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
                            </svg>
                            <span>Generate Payroll</span>
                        </a>
                    </div>
                </div>

                <div class="glass-card activity-card">
                    <div class="card-header">
                        <div>
                            <h2 class="card-title">Payroll Summary</h2>
                            <p class="card-subtitle">Current month at a glance</p>
                        </div>
                    </div>
                    <div class="activity-list">
                        <div class="activity-item">
                            <div class="activity-avatar" style="background:linear-gradient(135deg,var(--emerald-light),var(--emerald))">T</div>
                            <div class="activity-content">
                                <p class="activity-text"><strong>Total Employees</strong></p>
                                <span class="activity-time">${totalEmployees} registered</span>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-avatar" style="background:linear-gradient(135deg,var(--gold),var(--amber))">A</div>
                            <div class="activity-content">
                                <p class="activity-text"><strong>Active on Payroll</strong></p>
                                <span class="activity-time">${activeEmployees} employees</span>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-avatar" style="background:linear-gradient(135deg,var(--coral),var(--gold))">I</div>
                            <div class="activity-content">
                                <p class="activity-text"><strong>Inactive</strong></p>
                                <span class="activity-time">${totalEmployees - activeEmployees} employees</span>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-avatar" style="background:linear-gradient(135deg,var(--success),var(--emerald))">&#8377;</div>
                            <div class="activity-content">
                                <p class="activity-text"><strong>Net Payroll Disbursed</strong></p>
                                <span class="activity-time">&#8377;<fmt:formatNumber value="${totalPayroll}" type="number" maxFractionDigits="0"/> this month</span>
                            </div>
                        </div>
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

    <footer class="site-footer">
        <p>Copyright &copy; 2026 PayrollSystem &mdash; Powered by Java EE &amp; Tomcat 10</p>
    </footer>

    <script src="${pageContext.request.contextPath}/assets/templatemo-glass-admin-script.js"></script>
    <script>
        // Mark active nav link
        document.getElementById('navDashboard').classList.add('active');
    </script>
</body>
</html>
