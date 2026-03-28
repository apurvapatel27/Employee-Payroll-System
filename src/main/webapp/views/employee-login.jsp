<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Login — PayrollSystem</title>
    <meta name="description" content="Employee login for the PayrollSystem — view your payslip and salary details">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/templatemo-glass-admin-style.css">
    <style>
        /* Teal/emerald accent to visually distinguish from admin login */
        .emp-accent { color: var(--emerald-light, #34d399); }
        .login-logo-emp {
            background: linear-gradient(135deg, #10b981, #059669) !important;
        }
        .btn-emp {
            background: linear-gradient(135deg, #10b981, #059669) !important;
            box-shadow: 0 6px 20px rgba(16,185,129,0.4) !important;
        }
        .role-badge {
            display: inline-block;
            background: rgba(16,185,129,0.15);
            border: 1px solid rgba(16,185,129,0.35);
            color: #34d399;
            border-radius: 20px;
            padding: 0.25rem 0.9rem;
            font-size: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-bottom: 0.75rem;
        }
    </style>
</head>
<body>
    <!-- Animated Background -->
    <div class="background"></div>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <div class="login-page">
        <!-- Theme Toggle -->
        <button class="theme-toggle-float" id="theme-toggle" title="Toggle Light/Dark Mode">
            <svg class="icon-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="12" cy="12" r="4"/><path d="M12 2v2"/><path d="M12 20v2"/>
                <path d="M4.93 4.93l1.41 1.41"/><path d="M17.66 17.66l1.41 1.41"/>
                <path d="M2 12h2"/><path d="M20 12h2"/>
            </svg>
            <svg class="icon-moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display:none;">
                <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/>
            </svg>
        </button>

        <div class="login-container">
            <div class="login-card">
                <div class="login-header">
                    <div class="login-logo login-logo-emp">&#128100;</div>
                    <div class="role-badge">Employee Portal</div>
                    <h1 class="login-title">My Payslip</h1>
                    <p class="login-subtitle">Sign in with your Employee Code to view your salary details</p>
                </div>

                <% if (request.getAttribute("error") != null) { %>
                <div style="background:rgba(239,68,68,0.15);border:1px solid rgba(239,68,68,0.4);
                            color:#fca5a5;border-radius:10px;padding:0.75rem 1rem;
                            font-size:0.875rem;margin-bottom:1rem;text-align:center;" id="loginError">
                    &#9888; <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/employee-login" method="post" id="empLoginForm">
                    <div class="form-group">
                        <label class="form-label" for="empCode">Employee Code</label>
                        <input type="text" id="empCode" name="empCode" class="form-input"
                               placeholder="e.g. EMP001" required autocomplete="username">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="password">Password</label>
                        <input type="password" id="password" name="password" class="form-input"
                               placeholder="Enter your password" required autocomplete="current-password">
                    </div>
                    <button type="submit" class="btn btn-primary btn-emp" id="btnEmpLogin">
                        Sign In
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/>
                        </svg>
                    </button>
                </form>

                <p style="margin-top:1.25rem;text-align:center;color:var(--text-muted);font-size:0.8rem;">
                    Default password: <strong style="color:var(--text-secondary)">emp123</strong>
                </p>

                <div class="divider"><span>or</span></div>

                <p style="text-align:center;font-size:0.85rem;color:var(--text-muted);">
                    Are you an Admin?
                    <a href="${pageContext.request.contextPath}/login" id="linkAdminLogin"
                       style="color:var(--emerald-light,#34d399);text-decoration:none;font-weight:600;">
                        Admin Login &rarr;
                    </a>
                </p>
            </div>
        </div>

        <footer class="site-footer">
            <p>Copyright &copy; 2026 PayrollSystem &mdash; Employee Portal</p>
        </footer>
    </div>

    <script src="${pageContext.request.contextPath}/assets/templatemo-glass-admin-script.js"></script>
</body>
</html>
