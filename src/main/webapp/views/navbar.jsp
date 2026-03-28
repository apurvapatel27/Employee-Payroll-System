<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%-- Glass Admin Sidebar — included in every authenticated page. d-print-none equivalent handled via @media print in CSS --%>
<aside class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="logo">P</div>
        <span class="logo-text">PayrollSystem</span>
    </div>

    <ul class="nav-menu">
        <li class="nav-section">
            <span class="nav-section-title">Main Menu</span>
            <ul>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/dashboard" class="nav-link" id="navDashboard">
                        <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/>
                            <rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/>
                        </svg>
                        Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/employees" class="nav-link" id="navEmployees">
                        <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                            <circle cx="9" cy="7" r="4"/>
                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                        </svg>
                        Employees
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/payroll" class="nav-link" id="navPayroll">
                        <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="12" y1="1" x2="12" y2="23"/>
                            <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
                        </svg>
                        Payroll
                    </a>
                </li>
            </ul>
        </li>

        <li class="nav-section">
            <span class="nav-section-title">Account</span>
            <ul>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/logout" class="nav-link" id="navLogout">
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
            <div class="user-avatar"><c:out value="${sessionScope.adminName != null ? sessionScope.adminName.substring(0,1).toUpperCase() : 'A'}"/></div>
            <div class="user-info">
                <div class="user-name"><c:out value="${sessionScope.adminName}"/></div>
                <div class="user-role">Administrator</div>
            </div>
        </div>
    </div>
</aside>
