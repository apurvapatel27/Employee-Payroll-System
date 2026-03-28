<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payslip — ${payroll.employeeName} — PayrollSystem</title>
    <meta name="description" content="Payslip for ${payroll.employeeName}">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/templatemo-glass-admin-style.css">
    <style>
        /* -------- Screen actions bar -------- */
        .payslip-actions {
            max-width: 760px; margin: 2rem auto 1rem;
            display: flex; gap: 0.75rem; padding: 0 1rem;
        }
        .btn-back {
            background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.15);
            color: var(--text-secondary, rgba(255,255,255,0.7));
            padding: 0.55rem 1.25rem; border-radius: 10px;
            cursor: pointer; font-family: inherit; font-size: 0.875rem;
            text-decoration: none; transition: all 0.2s;
        }
        .btn-back:hover { background: rgba(255,255,255,0.1); }
        .btn-print {
            background: linear-gradient(135deg, var(--emerald-light,#34d399), var(--emerald,#10b981));
            border: none; color: #fff; padding: 0.55rem 1.5rem; border-radius: 10px;
            cursor: pointer; font-family: inherit; font-size: 0.875rem; font-weight: 600; transition: all 0.2s;
        }
        .btn-print:hover { opacity: 0.9; transform: translateY(-1px); }

        /* -------- Payslip document -------- */
        .payslip-doc {
            max-width: 760px; margin: 0 auto 3rem;
            padding: 0 1rem;
        }
        .payslip-paper {
            background: #fff; color: #222; border-radius: 16px;
            overflow: hidden; box-shadow: 0 30px 80px rgba(0,0,0,0.5);
        }
        .ps-header {
            background: linear-gradient(135deg, #4361ee, #7209b7);
            color: #fff; padding: 2rem 2.5rem;
            display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 1rem;
        }
        .ps-header .company { font-size: 1.4rem; font-weight: 800; letter-spacing: 0.5px; }
        .ps-header .period-label { font-size: 0.8rem; opacity: 0.8; }
        .ps-header .period { font-size: 1.2rem; font-weight: 700; }
        .ps-emp { background: #f8f9fa; padding: 1.25rem 2.5rem; border-bottom: 2px solid #eee; }
        .ps-info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0.6rem 2rem; }
        .ps-info-item .lbl { font-size: 0.72rem; color: #888; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600; }
        .ps-info-item .val { font-size: 0.92rem; font-weight: 600; color: #222; }
        .ps-section { padding: 1.25rem 2.5rem; }
        .ps-section h6 { font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.8px; color: #888; font-weight: 700; margin-bottom: 0.75rem; }
        .ps-row { display: flex; justify-content: space-between; padding: 0.4rem 0; border-bottom: 1px solid #f0f0f0; font-size: 0.88rem; }
        .ps-row:last-child { border-bottom: none; }
        .ps-row .ps-lbl { color: #555; }
        .ps-row .ps-val { font-weight: 600; color: #222; }
        .ps-row.deduct .ps-val { color: #dc3545; }
        .ps-subtotal { background: #eef2ff; border-radius: 8px; padding: 0.6rem 0.75rem; margin-top: 0.5rem; }
        .ps-subtotal .ps-lbl { font-weight: 700; color: #333; }
        .ps-subtotal .ps-val { font-weight: 700; color: #4361ee; }
        .ps-net {
            background: linear-gradient(135deg, rgba(67,97,238,0.08), rgba(114,9,183,0.08));
            border: 2px solid rgba(67,97,238,0.25);
            margin: 0 2.5rem 1.5rem; border-radius: 12px;
            padding: 1.2rem 1.5rem; display: flex; justify-content: space-between; align-items: center;
        }
        .ps-net .net-lbl { font-size: 1rem; font-weight: 700; color: #333; }
        .ps-net .net-amt { font-size: 1.9rem; font-weight: 900; color: #4361ee; }
        .ps-footer {
            background: #f8f9fa; padding: 0.9rem 2.5rem;
            border-top: 1px solid #eee;
            display: flex; justify-content: space-between; font-size: 0.75rem; color: #999;
        }

        /* -------- Print styles -------- */
        @media print {
            body { background: #fff !important; }
            .background, .orb, .payslip-actions, .site-footer { display: none !important; }
            .payslip-doc { max-width: 100%; padding: 0; margin: 0; }
            .payslip-paper { box-shadow: none; border-radius: 0; }
            .ps-header { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
            .ps-net { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
        }
    </style>
</head>
<body>
    <div class="background"></div>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <!-- Screen-only action bar (hidden on print) -->
    <div class="payslip-actions d-print-none">
        <a href="${pageContext.request.contextPath}/payroll?month=${payroll.month}&year=${payroll.year}"
           class="btn-back" id="btnBackPayroll">&#8592; Back to Payroll</a>
        <button onclick="window.print()" class="btn-print" id="btnPrint">&#128438; Print Payslip</button>
    </div>

    <!-- Payslip Document -->
    <div class="payslip-doc">
        <div class="payslip-paper">
            <!-- Header -->
            <div class="ps-header">
                <div>
                    <div class="company">&#128188; PayrollSystem</div>
                    <div style="font-size:0.8rem;opacity:0.8;margin-top:0.25rem;">Employee Pay Slip</div>
                </div>
                <div style="text-align:right;">
                    <div class="period-label">Pay Period</div>
                    <div class="period">${payroll.monthName} ${payroll.year}</div>
                </div>
            </div>

            <!-- Employee Info -->
            <div class="ps-emp">
                <div class="ps-info-grid">
                    <div class="ps-info-item">
                        <div class="lbl">Employee Name</div>
                        <div class="val">${payroll.employeeName}</div>
                    </div>
                    <div class="ps-info-item">
                        <div class="lbl">Employee Code</div>
                        <div class="val">${payroll.empCode}</div>
                    </div>
                    <div class="ps-info-item">
                        <div class="lbl">Department</div>
                        <div class="val">${payroll.departmentName}</div>
                    </div>
                    <div class="ps-info-item">
                        <div class="lbl">Designation</div>
                        <div class="val">${payroll.designation}</div>
                    </div>
                </div>
            </div>

            <!-- Earnings -->
            <div class="ps-section">
                <h6>Earnings</h6>
                <div class="ps-row">
                    <span class="ps-lbl">Basic Salary</span>
                    <span class="ps-val">&#8377; <fmt:formatNumber value="${payroll.basicSalary}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
                <div class="ps-row">
                    <span class="ps-lbl">HRA <small style="color:#aaa">(40% of Basic)</small></span>
                    <span class="ps-val">&#8377; <fmt:formatNumber value="${payroll.hra}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
                <div class="ps-row">
                    <span class="ps-lbl">DA <small style="color:#aaa">(10% of Basic)</small></span>
                    <span class="ps-val">&#8377; <fmt:formatNumber value="${payroll.da}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
                <div class="ps-row ps-subtotal">
                    <span class="ps-lbl">Gross Salary</span>
                    <span class="ps-val">&#8377; <fmt:formatNumber value="${payroll.grossSalary}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
            </div>

            <!-- Deductions -->
            <div class="ps-section" style="padding-top:0;">
                <h6>Deductions</h6>
                <div class="ps-row deduct">
                    <span class="ps-lbl">Provident Fund <small style="color:#aaa">(12% of Basic)</small></span>
                    <span class="ps-val">- &#8377; <fmt:formatNumber value="${payroll.pf}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
                <div class="ps-row deduct">
                    <span class="ps-lbl">Income Tax <small style="color:#aaa">(5% of Gross)</small></span>
                    <span class="ps-val">- &#8377; <fmt:formatNumber value="${payroll.tax}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
            </div>

            <!-- Net Pay -->
            <div class="ps-net">
                <div class="net-lbl">&#128176; Net Pay (Take-Home)</div>
                <div class="net-amt">&#8377; <fmt:formatNumber value="${payroll.netSalary}" type="number" minFractionDigits="2" maxFractionDigits="2"/></div>
            </div>

            <!-- Footer -->
            <div class="ps-footer">
                <span>&#9989; Computer-generated payslip — no signature required.</span>
                <span>Generated by PayrollSystem</span>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/templatemo-glass-admin-script.js"></script>
</body>
</html>
