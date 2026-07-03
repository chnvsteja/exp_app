<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Employee Expense Management System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
body{font-family:'Segoe UI',sans-serif;background:#f5f7fb;min-height:100vh;display:flex;flex-direction:column}
.hero{padding:80px 40px;background:linear-gradient(135deg,#667eea,#764ba2);color:#fff}
.section{padding:60px 20px;flex:1}
.card-custom{border-radius:15px;box-shadow:0 4px 15px rgba(0,0,0,.1)}
.sidebar{width:250px;height:100vh;background:#1f2937;color:#fff;position:fixed;top:0;left:0;display:none;z-index:1000}
.sidebar a{display:block;color:#cbd5e1;padding:12px 20px;text-decoration:none}
.sidebar a:hover, .sidebar a.active{background:#4f46e5;color:#fff}
.main{margin-left:250px;display:none;min-height:100vh;background:#f5f7fb}
.topbar{height:60px;background:#fff;border-bottom:1px solid #ddd;display:flex;justify-content:space-between;align-items:center;padding:0 20px}
.page{display:none}
.page.active{display:block}
.footer{background:#1e293b;color:#fff;padding:20px;text-align:center;margin-top:auto}
</style>
</head>
<body>

<div id="public-wrapper">
    <div id="landing" class="page active">
        <nav class="navbar navbar-expand-lg bg-white shadow-sm px-4">
            <div class="container-fluid">
                <h4 class="fw-bold text-primary mb-0"><i class="bi bi-wallet2"></i> Expense Tracker</h4>
                <div class="ms-auto">
                    <button class="btn btn-outline-dark me-2" onclick="showPage('login')">Login</button>
                    <button class="btn btn-primary" onclick="showPage('signup')">Sign Up</button>
                </div>
            </div>
        </nav>

        <section class="hero text-center">
            <div class="container">
                <h1 class="display-4 fw-bold">Expense Management <span class="text-warning">System</span></h1>
                <p class="lead">Track expenses, manage approvals, and accelerate reimbursements efficiently.</p>
                <button class="btn btn-light btn-lg mt-3" onclick="showPage('signup')">Get Started</button>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <div class="row g-4">
                    <div class="col-md-4"><div class="card card-custom p-4 text-center h-100"><i class="bi bi-receipt fs-1 text-primary mb-2"></i><h5>Track Expenses</h5><p class="text-muted small">Log and track items easily with itemized inputs.</p></div></div>
                    <div class="col-md-4"><div class="card card-custom p-4 text-center h-100"><i class="bi bi-check2-circle fs-1 text-success mb-2"></i><h5>Instant Approvals</h5><p class="text-muted small">Process logs instantly through status dashboards.</p></div></div>
                    <div class="col-md-4"><div class="card card-custom p-4 text-center h-100"><i class="bi bi-bar-chart fs-1 text-warning mb-2"></i><h5>Analytics Reports</h5><p class="text-muted small">Check real-time spend distributions anytime.</p></div></div>
                </div>
            </div>
        </section>

        <footer class="footer">©2026 Employee Expense Management System</footer>
    </div>

    <div id="login" class="page container py-5" style="max-width:420px">
        <div class="card p-4 shadow-sm border-0">
            <h3 class="text-center mb-3 fw-bold">Login</h3>
            <input id="loginUser" class="form-control mb-3" placeholder="Username">
            <input id="loginPass" type="password" class="form-control mb-3" placeholder="Password">
            <button class="btn btn-primary w-100" onclick="login()">Login</button>
            <p class="text-center mt-3 mb-0"><a href="#" onclick="showPage('signup')" class="text-decoration-none">Create account</a></p>
            <p class="text-center mt-2 mb-0"><a href="#" onclick="showPage('landing')" class="text-muted small text-decoration-none"><i class="bi bi-arrow-left"></i> Back Home</a></p>
        </div>
    </div>

    <div id="signup" class="page container py-5" style="max-width:420px">
        <div class="card p-4 shadow-sm border-0">
            <h3 class="text-center mb-3 fw-bold">Sign Up</h3>
            <input id="newUser" class="form-control mb-3" placeholder="Username">
            <input id="newPass" type="password" class="form-control mb-3" placeholder="Password">
            <button class="btn btn-success w-100" onclick="signup()">Register</button>
            <p class="text-center mt-3 mb-0"><a href="#" onclick="showPage('login')" class="text-decoration-none">Already have an account? Login</a></p>
        </div>
    </div>
</div>

<div class="sidebar" id="sidebar">
    <h4 class="py-3 text-center border-bottom border-secondary fw-bold"><i class="bi bi-wallet2"></i> Expense</h4>
    <a href="#" id="lnk-dashboard" onclick="dash('dashboard')" class="active"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a>
    <a href="#" id="lnk-expenses" onclick="dash('expenses')"><i class="bi bi-list-ul me-2"></i> Expenses</a>
    <a href="#" id="lnk-create" onclick="dash('create')"><i class="bi bi-plus-circle me-2"></i> Create Expense</a>
    <a href="#" id="lnk-approvals" onclick="dash('approvals')"><i class="bi bi-shield-check me-2"></i> Approvals</a>
    <a href="#" id="lnk-payments" onclick="dash('payments')"><i class="bi bi-cash-stack me-2"></i> Payments</a>
    <a href="#" id="lnk-reports" onclick="dash('reports')"><i class="bi bi-graph-up-arrow me-2"></i> Reports</a>
    <a href="#" id="lnk-settings" onclick="dash('settings')"><i class="bi bi-gear me-2"></i> Settings</a>
    <a href="#" onclick="logout()" class="text-danger mt-5"><i class="bi bi-box-arrow-left me-2"></i> Logout</a>
</div>

<div class="main" id="main">
    <div class="topbar px-4 shadow-sm">
        <h5 id="title" class="fw-bold m-0">Dashboard</h5>
        <div class="fw-semibold text-secondary"><i class="bi bi-person-circle me-1 text-primary"></i> <span id="userLabel"></span></div>
    </div>

    <div class="p-4">
        <div id="dashboard" class="dashpage">
            <div class="row g-3">
                <div class="col-md-3"><div class="card p-3 border-0 shadow-sm border-start border-primary border-4"><h5>Total Expenses</h5><h2 id="statTotal" class="text-primary fw-bold">₹0</h2></div></div>
                <div class="col-md-3"><div class="card p-3 border-0 shadow-sm border-start border-warning border-4"><h5>Pending</h5><h2 id="statPending" class="text-warning fw-bold">0</h2></div></div>
                <div class="col-md-3"><div class="card p-3 border-0 shadow-sm border-start border-success border-4"><h5>Approved</h5><h2 id="statApproved" class="text-success fw-bold">0</h2></div></div>
                <div class="col-md-3"><div class="card p-3 border-0 shadow-sm border-start border-danger border-4"><h5>Rejected</h5><h2 id="statRejected" class="text-danger fw-bold">0</h2></div></div>
            </div>
        </div>

        <div id="expenses" class="dashpage" style="display:none">
            <h3 class="fw-bold mb-3">My Expenses</h3>
            <div class="card p-3 border-0 shadow-sm table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Amount</th>
                            <th>Description</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody id="expenseBody"></tbody>
                </table>
            </div>
        </div>

        <div id="create" class="dashpage" style="display:none">
            <h3 class="fw-bold mb-3">Create Expense</h3>
            <div class="card p-4 border-0 shadow-sm" style="max-width: 500px;">
                <label class="form-label font-weight-bold">Expense Type</label>
                <select id="etype" class="form-select mb-3">
                    <option value="Travel">Travel</option>
                    <option value="Meals & Entertainment">Meals & Entertainment</option>
                    <option value="Office Supplies">Office Supplies</option>
                    <option value="Technology/Hardware">Technology & Hardware</option>
                    <option value="Other">Other</option>
                </select>
                <label class="form-label">Amount (₹)</label>
                <input id="eamount" type="number" class="form-control mb-3" placeholder="e.g. 1500">
                <label class="form-label">Description</label>
                <input id="edesc" class="form-control mb-4" placeholder="Brief note...">
                <button class="btn btn-primary px-4" onclick="addExpense()">Submit Claim</button>
            </div>
        </div>

        <div id="approvals" class="dashpage" style="display:none">
            <h3 class="fw-bold mb-3">Approvals Management</h3>
            <div class="card p-3 border-0 shadow-sm table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Type</th>
                            <th>Amount</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="approvalsBody"></tbody>
                </table>
            </div>
        </div>

        <div id="payments" class="dashpage" style="display:none">
            <h3 class="fw-bold mb-3">Reimbursement Processing</h3>
            <div class="card p-3 border-0 shadow-sm table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Type</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="paymentsBody"></tbody>
                </table>
            </div>
        </div>

        <div id="reports" class="dashpage" style="display:none">
            <h3 class="fw-bold mb-3">Reports Overview</h3>
            <div class="row g-3">
                <div class="col-md-6">
                    <div class="card p-4 border-0 shadow-sm">
                        <h5>Category Breakdown Summary</h5>
                        <hr>
                        <div id="reportSummary">No logs found to construct dynamic breakdown models.</div>
                    </div>
                </div>
            </div>
        </div>

        <div id="settings" class="dashpage" style="display:none">
            <h3 class="fw-bold mb-3">Settings</h3>
            <div class="card p-4 border-0 shadow-sm" style="max-width: 400px;">
                <h5>User Configuration Profile</h5>
                <p class="text-muted small">Standard configuration settings interface access.</p>
                <hr>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Security Context</label>
                    <input type="text" class="form-control" value="Role: Global App Administrator" readonly>
                </div>
                <button class="btn btn-secondary btn-sm" onclick="alert('Settings configured successfully.')">Save Updates</button>
            </div>
        </div>
    </div>
</div>

<script>
// Master Data Struct initialization via LocalStorage
let expenses = JSON.parse(localStorage.getItem('expenses_array')) || [];
let currentUser = sessionStorage.getItem('current_user') || "";

window.onload = function() {
    if(currentUser) {
        bootDashboard();
    }
};

function showPage(id){
    document.querySelectorAll(".page").forEach(x=>x.classList.remove("active"));
    document.getElementById(id).classList.add("active");
}

function signup(){
    let user = document.getElementById("newUser").value.trim();
    let pass = document.getElementById("newPass").value.trim();
    if(!user || !pass) { alert("Please complete all registration parameters."); return; }
    
    localStorage.setItem("user_" + user, pass);
    alert("Account Registered Successfully!");
    showPage("login");
    document.getElementById("newUser").value = "";
    document.getElementById("newPass").value = "";
}

function login(){
    let user = document.getElementById("loginUser").value.trim();
    let pass = document.getElementById("loginPass").value.trim();
    
    if(pass === localStorage.getItem("user_" + user) || (user === "admin" && pass === "admin")){
        currentUser = user || "admin";
        sessionStorage.setItem('current_user', currentUser);
        bootDashboard();
    } else { 
        alert("Invalid Username or Password Credential Matches Found."); 
    }
}

function bootDashboard() {
    document.getElementById("public-wrapper").style.display = "none";
    document.getElementById("sidebar").style.display = "block";
    document.getElementById("main").style.display = "block";
    document.getElementById("userLabel").innerText = currentUser;
    renderAllEngineData();
    dash('dashboard');
}

function logout(){
    sessionStorage.removeItem('current_user');
    location.reload();
}

function dash(id){
    document.querySelectorAll(".dashpage").forEach(x=>x.style.display="none");
    document.querySelectorAll(".sidebar a").forEach(x=>x.classList.remove("active"));
    
    document.getElementById(id).style.display = "block";
    let activeLink = document.getElementById("lnk-" + id);
    if(activeLink) activeLink.classList.add("active");
    
    document.getElementById("title").innerText = id.charAt(0).toUpperCase() + id.slice(1);
    renderAllEngineData();
}

function addExpense(){
    let t = document.getElementById("etype").value;
    let a = parseFloat(document.getElementById("eamount").value);
    let d = document.getElementById("edesc").value.trim();
    
    if(!a || a <= 0) { alert("Please enter a valid expense financial amount."); return; }
    
    let targetPayload = {
        id: 'exp_' + Date.now(),
        user: currentUser,
        type: t,
        amount: a,
        desc: d || 'N/A',
        status: 'Pending'
    };
    
    expenses.push(targetPayload);
    syncStorage();
    
    document.getElementById("eamount").value = "";
    document.getElementById("edesc").value = "";
    alert("Expense Claim submitted successfully!");
    dash('expenses');
}

function updateStatus(id, newStatus) {
    expenses = expenses.map(item => {
        if(item.id === id) item.status = newStatus;
        return item;
    });
    syncStorage();
    renderAllEngineData();
}

function syncStorage() {
    localStorage.setItem('expenses_array', JSON.stringify(expenses));
}

function renderAllEngineData() {
    // 1. Recalculate Metrics counters
    let totalValue = 0, pendingCount = 0, approvedCount = 0, rejectedCount = 0;
    let categoryData = {};

    expenses.forEach(item => {
        if(item.user === currentUser || currentUser === 'admin') {
            totalValue += item.amount;
            if(item.status === 'Pending') pendingCount++;
            else if(item.status === 'Approved' || item.status === 'Paid') approvedCount++;
            else if(item.status === 'Rejected') rejectedCount++;
        }
        categoryData[item.type] = (categoryData[item.type] || 0) + item.amount;
    });

    document.getElementById("statTotal").innerText = "₹" + totalValue.toLocaleString('en-IN');
    document.getElementById("statPending").innerText = pendingCount;
    document.getElementById("statApproved").innerText = approvedCount;
    document.getElementById("statRejected").innerText = rejectedCount;

    // 2. Personal/User Expense Table Rows
    let expBodyHTML = "";
    let myExpenses = expenses.filter(x => x.user === currentUser);
    if(myExpenses.length === 0) {
        expBodyHTML = `<tr><td colspan="4" class="text-center text-muted py-3">No submitted expenses found.</td></tr>`;
    } else {
        myExpenses.forEach(item => {
            let badgeClass = item.status==='Pending'?'bg-warning':item.status==='Rejected'?'bg-danger':'bg-success';
            expBodyHTML += `<tr>
                <td><strong>${item.type}</strong></td>
                <td>₹${item.amount.toLocaleString('en-IN')}</td>
                <td>${item.desc}</td>
                <td><span class="badge ${badgeClass}">${item.status}</span></td>
            </tr>`;
        });
    }
    document.getElementById("expenseBody").innerHTML = expBodyHTML;

    // 3. Approvals Matrix Parsing Engine
    let appBodyHTML = "";
    let pendingApprovals = expenses.filter(x => x.status === 'Pending');
    if(pendingApprovals.length === 0) {
        appBodyHTML = `<tr><td colspan="5" class="text-center text-muted py-3">No pending manager confirmation workflows found.</td></tr>`;
    } else {
        pendingApprovals.forEach(item => {
            appBodyHTML += `<tr>
                <td><code>${item.user}</code></td>
                <td>${item.type}</td>
                <td>₹${item.amount}</td>
                <td>${item.desc}</td>
                <td>
                    <button class="btn btn-sm btn-success me-1" onclick="updateStatus('${item.id}', 'Approved')"><i class="bi bi-check"></i></button>
                    <button class="btn btn-sm btn-danger" onclick="updateStatus('${item.id}', 'Rejected')"><i class="bi bi-x"></i></button>
                </td>
            </tr>`;
        });
    }
    document.getElementById("approvalsBody").innerHTML = appBodyHTML;

    // 4. Payments Handling Matrix 
    let payBodyHTML = "";
    let approvedPayments = expenses.filter(x => x.status === 'Approved' || x.status === 'Paid');
    if(approvedPayments.length === 0) {
        payBodyHTML = `<tr><td colspan="5" class="text-center text-muted py-3">No outstanding approved line items queued for distribution.</td></tr>`;
    } else {
        approvedPayments.forEach(item => {
            let isPaid = item.status === 'Paid';
            payBodyHTML += `<tr>
                <td><code>${item.user}</code></td>
                <td>${item.type}</td>
                <td>₹${item.amount}</td>
                <td><span class="badge ${isPaid?'bg-secondary':'bg-success'}">${item.status}</span></td>
                <td>
                    <button class="btn btn-sm btn-outline-primary" ${isPaid?'disabled':''} onclick="updateStatus('${item.id}', 'Paid')">
                        ${isPaid ? 'Settled' : 'Disburse Cash'}
                    </button>
                </td>
            </tr>`;
        });
    }
    document.getElementById("paymentsBody").innerHTML = payBodyHTML;

    // 5. Dynamic Metrics Reports Component UI Builder
    let reportElement = document.getElementById("reportSummary");
    if(Object.keys(categoryData).length === 0) {
        reportElement.innerHTML = `<span class="text-muted">Insufficient ledger entry details.</span>`;
    } else {
        let listHTML = `<ul class="list-group">`;
        for (const [cat, val] of Object.entries(categoryData)) {
            listHTML += `<li class="list-group-item d-flex justify-content-between align-items-center">
                ${cat} <span class="badge bg-primary rounded-pill">₹${val.toLocaleString('en-IN')}</span>
            </li>`;
        }
        listHTML += `</ul>`;
        reportElement.innerHTML = listHTML;
    }
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
