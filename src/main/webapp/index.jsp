<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Ledger — Employee Expense Management</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
  :root{
    --ink:#0F2136;
    --ink-soft:#42556B;
    --surface:#F6F7F9;
    --panel:#FFFFFF;
    --line:#E3E7ED;
    --emerald:#1F6D4C;
    --emerald-soft:#E5F2EB;
    --amber:#9A6B12;
    --amber-soft:#FBF1DE;
    --brick:#A63C46;
    --brick-soft:#FBEAEC;
    --slate-chip:#EEF1F5;
    --radius:10px;
    --shadow:0 1px 2px rgba(15,33,54,.04), 0 8px 24px rgba(15,33,54,.06);
  }
  *{box-sizing:border-box}
  body{margin:0;font-family:'Inter',sans-serif;color:var(--ink);background:var(--surface);-webkit-font-smoothing:antialiased}
  h1,h2,h3,h4,.display{font-family:'Space Grotesk',sans-serif;letter-spacing:-0.01em}
  .mono{font-family:'JetBrains Mono',monospace}
  a{text-decoration:none}
  button{font-family:inherit;cursor:pointer}
  ::selection{background:var(--emerald-soft)}

  /* ---------- Buttons ---------- */
  .btn{border:1px solid transparent;border-radius:8px;padding:10px 18px;font-weight:600;font-size:14.5px;transition:.15s ease;display:inline-flex;align-items:center;gap:8px;}
  .btn-primary{background:var(--ink);color:#fff}
  .btn-primary:hover{background:#1c3350}
  .btn-emerald{background:var(--emerald);color:#fff}
  .btn-emerald:hover{background:#175639}
  .btn-outline{background:transparent;border-color:var(--line);color:var(--ink)}
  .btn-outline:hover{background:var(--slate-chip)}
  .btn-danger-ghost{background:transparent;color:var(--brick);border-color:var(--brick-soft)}
  .btn-danger-ghost:hover{background:var(--brick-soft)}
  .btn-sm{padding:6px 12px;font-size:13px;border-radius:6px}
  .btn-block{width:100%;justify-content:center}
  .btn[disabled]{opacity:.45;cursor:not-allowed}

  /* ---------- Inputs ---------- */
  .field{margin-bottom:16px}
  .field label{display:block;font-size:13px;font-weight:600;color:var(--ink-soft);margin-bottom:6px}
  .field input,.field select,.field textarea{
    width:100%;border:1px solid var(--line);border-radius:8px;padding:11px 13px;font-size:14.5px;
    font-family:inherit;background:#fff;color:var(--ink);transition:.15s;
  }
  .field input:focus,.field select:focus,.field textarea:focus{outline:none;border-color:var(--emerald);box-shadow:0 0 0 3px var(--emerald-soft)}
  .err{color:var(--brick);font-size:13px;margin-top:6px;display:none}

  /* ---------- Page control ---------- */
  .page{display:none}
  .page.active{display:block}

  /* =========================================================
     AUTH / MARKETING
     ========================================================= */
  .auth-nav{display:flex;align-items:center;justify-content:space-between;padding:22px 48px;border-bottom:1px solid var(--line);background:#fff}
  .brand{display:flex;align-items:center;gap:10px;font-family:'Space Grotesk';font-weight:700;font-size:19px}
  .brand .mark{width:30px;height:30px;border-radius:7px;background:var(--ink);color:#fff;display:flex;align-items:center;justify-content:center;font-size:15px}
  .hero{background:var(--ink);color:#fff;padding:100px 48px 90px;position:relative;overflow:hidden}
  .hero::after{content:"";position:absolute;right:-120px;top:-120px;width:420px;height:420px;border-radius:50%;background:radial-gradient(circle,rgba(31,109,76,.35),transparent 70%)}
  .hero-inner{max-width:640px;position:relative}
  .eyebrow{font-family:'JetBrains Mono';font-size:12.5px;letter-spacing:.14em;text-transform:uppercase;color:#8fd6b3;margin-bottom:18px}
  .hero h1{font-size:46px;line-height:1.08;margin:0 0 20px}
  .hero p{font-size:17px;color:#C6D0DC;line-height:1.6;margin-bottom:32px;max-width:520px}
  .stat-strip{display:flex;gap:0;border-top:1px solid rgba(255,255,255,.15);margin-top:64px;padding-top:28px;max-width:640px}
  .stat-strip div{flex:1;border-left:1px solid rgba(255,255,255,.15);padding-left:20px}
  .stat-strip div:first-child{border-left:none;padding-left:0}
  .stat-strip .n{font-family:'JetBrains Mono';font-size:24px;font-weight:600;color:#fff}
  .stat-strip .l{font-size:12.5px;color:#93A2B4;margin-top:4px}

  .section{padding:72px 48px;max-width:1180px;margin:0 auto}
  .section-head{max-width:520px;margin-bottom:44px}
  .section-head .eyebrow{color:var(--emerald)}
  .section-head h2{font-size:28px;margin:8px 0 10px}
  .section-head p{color:var(--ink-soft);font-size:15px;line-height:1.6}
  .flow-row{display:grid;grid-template-columns:repeat(4,1fr);gap:0;border:1px solid var(--line);border-radius:var(--radius);overflow:hidden;background:#fff}
  .flow-step{padding:26px 22px;border-right:1px solid var(--line);position:relative}
  .flow-step:last-child{border-right:none}
  .flow-step .num{font-family:'JetBrains Mono';font-size:12px;color:var(--emerald);font-weight:600}
  .flow-step h4{font-size:15.5px;margin:10px 0 6px}
  .flow-step p{font-size:13.5px;color:var(--ink-soft);line-height:1.55;margin:0}
  .flow-step .bi{position:absolute;top:24px;right:20px;color:var(--line);font-size:18px}

  .footer-auth{padding:26px 48px;border-top:1px solid var(--line);display:flex;justify-content:space-between;color:var(--ink-soft);font-size:13px;background:#fff}

  .auth-wrap{min-height:calc(100vh - 78px);display:flex;align-items:center;justify-content:center;background:var(--surface);padding:40px 20px}
  .auth-card{width:100%;max-width:400px;background:#fff;border:1px solid var(--line);border-radius:var(--radius);box-shadow:var(--shadow);padding:36px 32px}
  .auth-card .eyebrow{color:var(--emerald)}
  .auth-card h2{font-size:23px;margin:6px 0 26px}
  .switcher{text-align:center;font-size:13.5px;color:var(--ink-soft);margin-top:18px}
  .switcher a{color:var(--emerald);font-weight:600}
  .demo-box{background:var(--slate-chip);border-radius:8px;padding:12px 14px;font-size:12.5px;color:var(--ink-soft);margin-bottom:22px;line-height:1.6}
  .demo-box b{color:var(--ink)}

  /* =========================================================
     APP SHELL
     ========================================================= */
  .app{display:none;min-height:100vh}
  .sidebar{width:236px;background:var(--ink);color:#C9D3DF;position:fixed;top:0;left:0;bottom:0;display:flex;flex-direction:column;padding:22px 0}
  .sidebar .brand{color:#fff;padding:0 22px 24px;border-bottom:1px solid rgba(255,255,255,.1);margin-bottom:14px}
  .nav-group-label{font-family:'JetBrains Mono';font-size:10.5px;letter-spacing:.12em;text-transform:uppercase;color:#647084;padding:14px 22px 8px}
  .nav-link{display:flex;align-items:center;gap:12px;padding:10px 22px;font-size:14px;font-weight:500;color:#C9D3DF;border-left:3px solid transparent}
  .nav-link .bi{font-size:16px;width:18px;text-align:center}
  .nav-link:hover{background:rgba(255,255,255,.06);color:#fff}
  .nav-link.active{background:rgba(31,109,76,.22);color:#fff;border-left-color:var(--emerald)}
  .nav-bottom{margin-top:auto;padding:14px 22px 0;border-top:1px solid rgba(255,255,255,.1)}
  .role-chip{display:inline-block;font-family:'JetBrains Mono';font-size:10.5px;padding:2px 8px;border-radius:20px;background:rgba(255,255,255,.12);color:#C9D3DF;margin-top:4px}

  .main{margin-left:236px}
  .topbar{height:66px;background:#fff;border-bottom:1px solid var(--line);display:flex;align-items:center;justify-content:space-between;padding:0 30px;position:sticky;top:0;z-index:5}
  .topbar h3{font-size:18px;margin:0}
  .topbar .sub{font-size:12.5px;color:var(--ink-soft);margin-top:1px}
  .who{display:flex;align-items:center;gap:10px}
  .avatar{width:34px;height:34px;border-radius:50%;background:var(--emerald-soft);color:var(--emerald);display:flex;align-items:center;justify-content:center;font-weight:700;font-size:13px;font-family:'Space Grotesk'}
  .content{padding:30px}
  .dashpage{display:none}
  .dashpage.active{display:block}

  /* Cards / stats */
  .stat-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:28px}
  .stat-card{background:#fff;border:1px solid var(--line);border-radius:var(--radius);padding:20px;position:relative;overflow:hidden;box-shadow:var(--shadow)}
  .stat-card .bar{position:absolute;left:0;top:0;bottom:0;width:4px}
  .stat-card .l{font-size:12.5px;color:var(--ink-soft);font-weight:600;text-transform:uppercase;letter-spacing:.04em}
  .stat-card .v{font-family:'JetBrains Mono';font-size:26px;font-weight:600;margin-top:8px}
  .stat-card .d{font-size:12px;color:var(--ink-soft);margin-top:4px}

  .panel{background:#fff;border:1px solid var(--line);border-radius:var(--radius);box-shadow:var(--shadow)}
  .panel-head{padding:18px 22px;border-bottom:1px solid var(--line);display:flex;align-items:center;justify-content:space-between}
  .panel-head h4{margin:0;font-size:15.5px}
  .panel-body{padding:22px}

  table{width:100%;border-collapse:collapse}
  thead th{text-align:left;font-size:11.5px;text-transform:uppercase;letter-spacing:.05em;color:var(--ink-soft);padding:10px 22px;border-bottom:1px solid var(--line);background:var(--surface)}
  tbody td{padding:14px 22px;border-bottom:1px solid var(--line);font-size:14px}
  tbody tr:last-child td{border-bottom:none}
  tbody tr:hover{background:var(--surface)}
  .empty-row td{text-align:center;color:var(--ink-soft);padding:40px 20px;font-size:14px}

  .badge{display:inline-flex;align-items:center;gap:5px;font-size:12px;font-weight:600;padding:4px 10px;border-radius:20px}
  .badge-pending{background:var(--amber-soft);color:var(--amber)}
  .badge-approved{background:var(--emerald-soft);color:var(--emerald)}
  .badge-rejected{background:var(--brick-soft);color:var(--brick)}
  .badge-paid{background:#E7EEFB;color:#2A4E8C}
  .badge-unpaid{background:var(--slate-chip);color:var(--ink-soft)}
  .badge dot{}
  .badge .dot{width:6px;height:6px;border-radius:50%;background:currentColor}

  .form-grid{display:grid;grid-template-columns:1fr 1fr;gap:0 18px}
  .form-grid .full{grid-column:1/-1}

  .bar-chart{display:flex;flex-direction:column;gap:14px}
  .bar-row{display:grid;grid-template-columns:120px 1fr 70px;align-items:center;gap:12px}
  .bar-row .lbl{font-size:13px;color:var(--ink-soft);font-weight:600}
  .bar-track{height:10px;background:var(--slate-chip);border-radius:6px;overflow:hidden}
  .bar-fill{height:100%;background:var(--emerald);border-radius:6px}
  .bar-row .amt{font-family:'JetBrains Mono';font-size:12.5px;text-align:right}

  .settings-grid{display:grid;grid-template-columns:1fr 1fr;gap:24px}
  .toast{position:fixed;bottom:26px;right:26px;background:var(--ink);color:#fff;padding:13px 20px;border-radius:8px;font-size:14px;font-weight:500;box-shadow:0 10px 30px rgba(0,0,0,.25);display:flex;align-items:center;gap:10px;opacity:0;transform:translateY(10px);transition:.25s;z-index:50;pointer-events:none}
  .toast.show{opacity:1;transform:translateY(0)}
  .toast.ok{background:var(--emerald)}
  .toast.bad{background:var(--brick)}

  .empty-state{text-align:center;padding:56px 20px;color:var(--ink-soft)}
  .empty-state .bi{font-size:34px;color:var(--line);margin-bottom:14px;display:block}
  .empty-state h5{color:var(--ink);margin-bottom:6px}
  .empty-state p{font-size:13.5px;margin-bottom:18px}

  .action-row{display:flex;gap:8px}

  @media (max-width:960px){
    .stat-grid{grid-template-columns:repeat(2,1fr)}
    .flow-row{grid-template-columns:1fr;}
    .flow-step{border-right:none;border-bottom:1px solid var(--line)}
    .form-grid{grid-template-columns:1fr}
    .settings-grid{grid-template-columns:1fr}
    .hero h1{font-size:34px}
    .sidebar{transform:translateX(-100%);transition:.2s;z-index:40}
    .sidebar.open{transform:translateX(0)}
    .main{margin-left:0}
    .menu-btn{display:inline-flex !important}
  }
  .menu-btn{display:none;background:none;border:none;font-size:20px;color:var(--ink)}
</style>
</head>
<body>

<!-- ============================================================
     LANDING
============================================================ -->
<div id="landing" class="page active">
  <nav class="auth-nav">
    <div class="brand"><span class="mark"><i class="bi bi-book"></i></span>Ledger</div>
    <div>
      <button class="btn btn-outline btn-sm" onclick="showPage('login')">Log in</button>
      <button class="btn btn-primary btn-sm" onclick="showPage('signup')">Create account</button>
    </div>
  </nav>

  <section class="hero">
    <div class="hero-inner">
      <div class="eyebrow">// Expense operations</div>
      <h1>Every claim, tracked from receipt to reimbursement.</h1>
      <p>Ledger gives employees a fast way to file expenses and gives managers a single queue to approve, reject, and pay them — no spreadsheets, no email threads.</p>
      <button class="btn btn-emerald" onclick="showPage('signup')">Get started — it's free <i class="bi bi-arrow-right"></i></button>
      <div class="stat-strip">
        <div><div class="n">01</div><div class="l">File a claim</div></div>
        <div><div class="n">02</div><div class="l">Manager reviews</div></div>
        <div><div class="n">03</div><div class="l">Approve or reject</div></div>
        <div><div class="n">04</div><div class="l">Mark as paid</div></div>
      </div>
    </div>
  </section>

  <section class="section">
    <div class="section-head">
      <div class="eyebrow">// How it works</div>
      <h2>One queue. No back-and-forth.</h2>
      <p>Every expense moves through the same four stages, visible to both the person who filed it and the person approving it.</p>
    </div>
    <div class="flow-row">
      <div class="flow-step"><i class="bi bi-pencil-square"></i><div class="num">01</div><h4>Submit</h4><p>Employees log the type, amount and description of a business expense in under a minute.</p></div>
      <div class="flow-step"><i class="bi bi-hourglass-split"></i><div class="num">02</div><h4>Pending review</h4><p>The claim sits in the manager's approvals queue until it's actioned.</p></div>
      <div class="flow-step"><i class="bi bi-check2-circle"></i><div class="num">03</div><h4>Decision</h4><p>A manager approves or rejects, with the status reflected instantly for the employee.</p></div>
      <div class="flow-step"><i class="bi bi-cash-coin"></i><div class="num">04</div><h4>Payment</h4><p>Approved claims are marked paid once reimbursement is issued.</p></div>
    </div>
  </section>

  <footer class="footer-auth">
    <span>© 2026 Ledger — Employee Expense Management</span>
    <span>Built for finance teams and the people who file with them</span>
  </footer>
</div>

<!-- ============================================================
     LOGIN
============================================================ -->
<div id="login" class="page">
  <nav class="auth-nav">
    <div class="brand" style="cursor:pointer" onclick="showPage('landing')"><span class="mark"><i class="bi bi-book"></i></span>Ledger</div>
    <button class="btn btn-outline btn-sm" onclick="showPage('landing')"><i class="bi bi-arrow-left"></i> Back</button>
  </nav>
  <div class="auth-wrap">
    <div class="auth-card">
      <div class="eyebrow">// Welcome back</div>
      <h2>Log in to your account</h2>
      <div class="demo-box">Try it instantly — <b>manager</b> / <b>manager123</b> (Approvals access) or <b>employee</b> / <b>employee123</b>.</div>
      <div class="field">
        <label>Username</label>
        <input id="loginUser" placeholder="e.g. employee">
      </div>
      <div class="field">
        <label>Password</label>
        <input id="loginPass" type="password" placeholder="••••••••">
        <div class="err" id="loginErr">Incorrect username or password.</div>
      </div>
      <button class="btn btn-primary btn-block" onclick="login()">Log in <i class="bi bi-arrow-right"></i></button>
      <div class="switcher">No account yet? <a href="#" onclick="showPage('signup')">Create one</a></div>
    </div>
  </div>
</div>

<!-- ============================================================
     SIGNUP
============================================================ -->
<div id="signup" class="page">
  <nav class="auth-nav">
    <div class="brand" style="cursor:pointer" onclick="showPage('landing')"><span class="mark"><i class="bi bi-book"></i></span>Ledger</div>
    <button class="btn btn-outline btn-sm" onclick="showPage('landing')"><i class="bi bi-arrow-left"></i> Back</button>
  </nav>
  <div class="auth-wrap">
    <div class="auth-card">
      <div class="eyebrow">// Get started</div>
      <h2>Create your account</h2>
      <div class="field">
        <label>Full name</label>
        <input id="newName" placeholder="Jordan Lee">
      </div>
      <div class="field">
        <label>Username</label>
        <input id="newUser" placeholder="Choose a username">
      </div>
      <div class="field">
        <label>Password</label>
        <input id="newPass" type="password" placeholder="At least 4 characters">
      </div>
      <div class="field">
        <label>Role</label>
        <select id="newRole">
          <option value="employee">Employee — files expenses</option>
          <option value="manager">Manager — approves & pays expenses</option>
        </select>
      </div>
      <div class="err" id="signupErr">Please fill every field with a username that isn't taken.</div>
      <button class="btn btn-emerald btn-block" onclick="signup()">Create account <i class="bi bi-arrow-right"></i></button>
      <div class="switcher">Already registered? <a href="#" onclick="showPage('login')">Log in</a></div>
    </div>
  </div>
</div>

<!-- ============================================================
     APP SHELL
============================================================ -->
<div class="app" id="app">
  <aside class="sidebar" id="sidebar">
    <div class="brand"><span class="mark"><i class="bi bi-book"></i></span>Ledger</div>

    <div class="nav-group-label">Workspace</div>
    <a href="#" class="nav-link active" data-page="dashboard" onclick="dash('dashboard')"><i class="bi bi-grid-1x2"></i> Dashboard</a>
    <a href="#" class="nav-link" data-page="expenses" onclick="dash('expenses')"><i class="bi bi-receipt"></i> Expenses</a>
    <a href="#" class="nav-link" data-page="create" onclick="dash('create')"><i class="bi bi-plus-circle"></i> Create expense</a>
    <a href="#" class="nav-link mgr-only" data-page="approvals" onclick="dash('approvals')"><i class="bi bi-check2-circle"></i> Approvals</a>
    <a href="#" class="nav-link mgr-only" data-page="payments" onclick="dash('payments')"><i class="bi bi-cash-coin"></i> Payments</a>
    <a href="#" class="nav-link" data-page="reports" onclick="dash('reports')"><i class="bi bi-bar-chart"></i> Reports</a>
    <a href="#" class="nav-link" data-page="settings" onclick="dash('settings')"><i class="bi bi-gear"></i> Settings</a>

    <div class="nav-bottom">
      <div style="font-size:13px;font-weight:600;color:#fff" id="sideUserName">—</div>
      <span class="role-chip" id="sideRoleChip">role</span>
      <a href="#" class="nav-link" style="padding-left:0;margin-top:12px" onclick="logout()"><i class="bi bi-box-arrow-left"></i> Log out</a>
    </div>
  </aside>

  <div class="main">
    <div class="topbar">
      <div style="display:flex;align-items:center;gap:14px">
        <button class="menu-btn" onclick="sidebar.classList.toggle('open')"><i class="bi bi-list"></i></button>
        <div>
          <h3 id="pageTitle">Dashboard</h3>
          <div class="sub" id="pageSub">Overview of your expense activity</div>
        </div>
      </div>
      <div class="who">
        <div style="text-align:right">
          <div style="font-size:13.5px;font-weight:600" id="topUserName">—</div>
          <div style="font-size:11.5px;color:var(--ink-soft)" id="topUserRole">—</div>
        </div>
        <div class="avatar" id="topAvatar">—</div>
      </div>
    </div>

    <div class="content">

      <!-- DASHBOARD -->
      <div id="dashboard" class="dashpage active">
        <div class="stat-grid">
          <div class="stat-card"><div class="bar" style="background:var(--ink)"></div><div class="l">Total filed</div><div class="v mono" id="statTotal">₹0</div><div class="d" id="statTotalD">0 claims</div></div>
          <div class="stat-card"><div class="bar" style="background:var(--amber)"></div><div class="l">Pending</div><div class="v mono" id="statPending">0</div><div class="d">awaiting decision</div></div>
          <div class="stat-card"><div class="bar" style="background:var(--emerald)"></div><div class="l">Approved</div><div class="v mono" id="statApproved">0</div><div class="d">cleared for payment</div></div>
          <div class="stat-card"><div class="bar" style="background:var(--brick)"></div><div class="l">Rejected</div><div class="v mono" id="statRejected">0</div><div class="d">declined claims</div></div>
        </div>

        <div class="panel">
          <div class="panel-head">
            <h4 id="recentTitle">Recent expenses</h4>
            <a href="#" class="btn btn-outline btn-sm" onclick="dash('expenses')">View all <i class="bi bi-arrow-right"></i></a>
          </div>
          <table>
            <thead><tr><th>Type</th><th>Employee</th><th>Amount</th><th>Status</th><th>Payment</th><th>Date</th></tr></thead>
            <tbody id="recentBody"></tbody>
          </table>
        </div>
      </div>

      <!-- EXPENSES -->
      <div id="expenses" class="dashpage">
        <div class="panel">
          <div class="panel-head">
            <h4 id="expensesTitle">Your expenses</h4>
            <button class="btn btn-primary btn-sm" onclick="dash('create')"><i class="bi bi-plus-lg"></i> New expense</button>
          </div>
          <table>
            <thead><tr><th>Type</th><th>Employee</th><th>Amount</th><th>Description</th><th>Status</th><th>Payment</th><th>Date</th></tr></thead>
            <tbody id="expenseBody"></tbody>
          </table>
        </div>
      </div>

      <!-- CREATE -->
      <div id="create" class="dashpage">
        <div class="panel" style="max-width:640px">
          <div class="panel-head"><h4>File a new expense</h4></div>
          <div class="panel-body">
            <div class="form-grid">
              <div class="field">
                <label>Expense type</label>
                <select id="etype">
                  <option>Travel</option>
                  <option>Meals & entertainment</option>
                  <option>Office supplies</option>
                  <option>Software & subscriptions</option>
                  <option>Accommodation</option>
                  <option>Client hospitality</option>
                  <option>Other</option>
                </select>
              </div>
              <div class="field">
                <label>Amount (₹)</label>
                <input id="eamount" type="number" min="1" placeholder="e.g. 2500">
              </div>
              <div class="field full">
                <label>Description</label>
                <textarea id="edesc" rows="3" placeholder="What was this for?"></textarea>
              </div>
              <div class="field full">
                <label>Date incurred</label>
                <input id="edate" type="date">
              </div>
            </div>
            <div class="err" id="createErr">Enter an expense type, a valid amount, and a description.</div>
            <button class="btn btn-emerald" onclick="addExpense()"><i class="bi bi-send"></i> Submit for approval</button>
          </div>
        </div>
      </div>

      <!-- APPROVALS (manager only) -->
      <div id="approvals" class="dashpage">
        <div class="panel">
          <div class="panel-head">
            <h4>Pending approvals</h4>
            <span class="badge badge-pending" id="approvalsCount">0 pending</span>
          </div>
          <table>
            <thead><tr><th>Employee</th><th>Type</th><th>Amount</th><th>Description</th><th>Date</th><th>Action</th></tr></thead>
            <tbody id="approvalsBody"></tbody>
          </table>
        </div>
      </div>

      <!-- PAYMENTS (manager only) -->
      <div id="payments" class="dashpage">
        <div class="panel">
          <div class="panel-head">
            <h4>Approved claims — payment status</h4>
            <span class="badge badge-unpaid" id="paymentsCount">0 unpaid</span>
          </div>
          <table>
            <thead><tr><th>Employee</th><th>Type</th><th>Amount</th><th>Approved on</th><th>Payment</th><th>Action</th></tr></thead>
            <tbody id="paymentsBody"></tbody>
          </table>
        </div>
      </div>

      <!-- REPORTS -->
      <div id="reports" class="dashpage">
        <div class="panel" style="margin-bottom:20px">
          <div class="panel-head"><h4>Spend by category</h4></div>
          <div class="panel-body">
            <div class="bar-chart" id="categoryChart"></div>
          </div>
        </div>
        <div class="panel">
          <div class="panel-head"><h4>Claims by status</h4></div>
          <div class="panel-body">
            <div class="bar-chart" id="statusChart"></div>
          </div>
        </div>
      </div>

      <!-- SETTINGS -->
      <div id="settings" class="dashpage">
        <div class="panel" style="max-width:640px">
          <div class="panel-head"><h4>Profile settings</h4></div>
          <div class="panel-body">
            <div class="settings-grid">
              <div class="field">
                <label>Full name</label>
                <input id="setName">
              </div>
              <div class="field">
                <label>Username</label>
                <input id="setUser" disabled>
              </div>
              <div class="field full">
                <label>New password <span style="font-weight:400;color:var(--ink-soft)">(leave blank to keep current)</span></label>
                <input id="setPass" type="password" placeholder="••••••••">
              </div>
            </div>
            <button class="btn btn-primary" onclick="saveSettings()"><i class="bi bi-check-lg"></i> Save changes</button>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<div class="toast" id="toast"></div>

<script>
/* =========================================================
   IN-MEMORY APPLICATION STATE
   (no localStorage — state lives for this session only)
========================================================= */
let users = [
  {username:'manager', password:'manager123', name:'Priya Sharma', role:'manager'},
  {username:'employee', password:'employee123', name:'Arjun Mehta', role:'employee'}
];

let expenses = [
  {id:1, username:'employee', type:'Travel', amount:4200, description:'Client visit — Bengaluru round trip', date:'2026-06-18', status:'Pending', payment:'Unpaid'},
  {id:2, username:'employee', type:'Meals & entertainment', amount:1150, description:'Team lunch with vendor', date:'2026-06-21', status:'Approved', payment:'Unpaid'},
  {id:3, username:'employee', type:'Software & subscriptions', amount:2599, description:'Design tool annual license', date:'2026-06-25', status:'Approved', payment:'Paid'},
  {id:4, username:'employee', type:'Office supplies', amount:640, description:'Notebooks and desk organizers', date:'2026-06-29', status:'Rejected', payment:'Unpaid'}
];
let nextId = 5;
let currentUser = null;

/* =========================================================
   AUTH / PAGE ROUTING
========================================================= */
function showPage(id){
  document.querySelectorAll('.page').forEach(p=>p.classList.remove('active'));
  document.getElementById(id).classList.add('active');
  document.getElementById('loginErr').style.display='none';
  document.getElementById('signupErr').style.display='none';
}

function signup(){
  const name = document.getElementById('newName').value.trim();
  const uname = document.getElementById('newUser').value.trim();
  const pass = document.getElementById('newPass').value;
  const role = document.getElementById('newRole').value;
  const err = document.getElementById('signupErr');

  if(!name || !uname || pass.length < 4 || users.find(u=>u.username===uname)){
    err.style.display='block';
    return;
  }
  err.style.display='none';
  users.push({username:uname, password:pass, name:name, role:role});
  toast('Account created — log in to continue', 'ok');
  document.getElementById('loginUser').value = uname;
  document.getElementById('newName').value='';
  document.getElementById('newUser').value='';
  document.getElementById('newPass').value='';
  showPage('login');
}

function login(){
  const uname = document.getElementById('loginUser').value.trim();
  const pass = document.getElementById('loginPass').value;
  const found = users.find(u=>u.username===uname && u.password===pass);
  const err = document.getElementById('loginErr');

  if(!found){
    err.style.display='block';
    return;
  }
  err.style.display='none';
  currentUser = found;
  enterApp();
}

function logout(){
  currentUser = null;
  document.getElementById('app').style.display='none';
  document.getElementById('loginUser').value='';
  document.getElementById('loginPass').value='';
  showPage('landing');
}

function enterApp(){
  document.getElementById('app').style.display='block';
  document.querySelectorAll('.page').forEach(p=>p.classList.remove('active'));

  const isManager = currentUser.role === 'manager';
  document.querySelectorAll('.mgr-only').forEach(el=> el.style.display = isManager ? 'flex' : 'none');

  document.getElementById('sideUserName').innerText = currentUser.name;
  document.getElementById('sideRoleChip').innerText = currentUser.role;
  document.getElementById('topUserName').innerText = currentUser.name;
  document.getElementById('topUserRole').innerText = isManager ? 'Manager' : 'Employee';
  document.getElementById('topAvatar').innerText = currentUser.name.split(' ').map(s=>s[0]).slice(0,2).join('').toUpperCase();

  document.getElementById('setName').value = currentUser.name;
  document.getElementById('setUser').value = currentUser.username;
  document.getElementById('setPass').value = '';

  dash('dashboard');
}

/* =========================================================
   NAVIGATION BETWEEN DASHBOARD PAGES
========================================================= */
const pageMeta = {
  dashboard:{title:'Dashboard', sub:'Overview of your expense activity'},
  expenses:{title:'Expenses', sub:'All claims you can see, in one list'},
  create:{title:'Create expense', sub:'File a new claim for approval'},
  approvals:{title:'Approvals', sub:'Review and action pending claims'},
  payments:{title:'Payments', sub:'Track reimbursement for approved claims'},
  reports:{title:'Reports', sub:'Spend broken down by category and status'},
  settings:{title:'Settings', sub:'Manage your profile'}
};

function dash(id){
  if(id==='approvals' || id==='payments'){
    if(!currentUser || currentUser.role !== 'manager'){ toast('Manager access required', 'bad'); id='dashboard'; }
  }
  document.querySelectorAll('.dashpage').forEach(p=>p.classList.remove('active'));
  document.getElementById(id).classList.add('active');
  document.querySelectorAll('.nav-link').forEach(a=>a.classList.remove('active'));
  const link = document.querySelector(`.nav-link[data-page="${id}"]`);
  if(link) link.classList.add('active');
  document.getElementById('pageTitle').innerText = pageMeta[id].title;
  document.getElementById('pageSub').innerText = pageMeta[id].sub;
  sidebar.classList.remove('open');
  renderAll();
}

/* =========================================================
   DATA HELPERS
========================================================= */
function visibleExpenses(){
  if(currentUser.role === 'manager') return expenses;
  return expenses.filter(e=>e.username===currentUser.username);
}
function nameFor(username){
  const u = users.find(x=>x.username===username);
  return u ? u.name : username;
}
function fmt(n){ return '₹' + Number(n).toLocaleString('en-IN'); }
function statusBadge(s){
  const map = {Pending:'badge-pending', Approved:'badge-approved', Rejected:'badge-rejected'};
  return `<span class="badge ${map[s]}"><span class="dot"></span>${s}</span>`;
}
function paymentBadge(p){
  return `<span class="badge ${p==='Paid'?'badge-paid':'badge-unpaid'}"><span class="dot"></span>${p}</span>`;
}

/* =========================================================
   RENDER: everything reflows off `expenses` + `currentUser`
========================================================= */
function renderAll(){
  if(!currentUser) return;
  renderDashboard();
  renderExpenses();
  renderApprovals();
  renderPayments();
  renderReports();
}

function renderDashboard(){
  const list = visibleExpenses();
  const total = list.reduce((s,e)=>s+Number(e.amount),0);
  const pending = list.filter(e=>e.status==='Pending').length;
  const approved = list.filter(e=>e.status==='Approved').length;
  const rejected = list.filter(e=>e.status==='Rejected').length;

  document.getElementById('statTotal').innerText = fmt(total);
  document.getElementById('statTotalD').innerText = list.length + ' claim' + (list.length===1?'':'s');
  document.getElementById('statPending').innerText = pending;
  document.getElementById('statApproved').innerText = approved;
  document.getElementById('statRejected').innerText = rejected;

  document.getElementById('recentTitle').innerText = currentUser.role==='manager' ? 'Recent expenses — all employees' : 'Your recent expenses';

  const recent = [...list].sort((a,b)=> b.id - a.id).slice(0,5);
  const body = document.getElementById('recentBody');
  body.innerHTML = recent.length ? recent.map(e=>`
    <tr>
      <td>${e.type}</td>
      <td>${nameFor(e.username)}</td>
      <td class="mono">${fmt(e.amount)}</td>
      <td>${statusBadge(e.status)}</td>
      <td>${paymentBadge(e.payment)}</td>
      <td>${e.date}</td>
    </tr>`).join('') : `<tr class="empty-row"><td colspan="6">No expenses filed yet.</td></tr>`;
}

function renderExpenses(){
  const list = [...visibleExpenses()].sort((a,b)=> b.id - a.id);
  document.getElementById('expensesTitle').innerText = currentUser.role==='manager' ? 'All employee expenses' : 'Your expenses';
  const body = document.getElementById('expenseBody');
  body.innerHTML = list.length ? list.map(e=>`
    <tr>
      <td>${e.type}</td>
      <td>${nameFor(e.username)}</td>
      <td class="mono">${fmt(e.amount)}</td>
      <td>${e.description}</td>
      <td>${statusBadge(e.status)}</td>
      <td>${paymentBadge(e.payment)}</td>
      <td>${e.date}</td>
    </tr>`).join('') : `<tr class="empty-row"><td colspan="7">No expenses to show yet — file your first one.</td></tr>`;
}

function renderApprovals(){
  if(currentUser.role !== 'manager') return;
  const pending = expenses.filter(e=>e.status==='Pending').sort((a,b)=>b.id-a.id);
  document.getElementById('approvalsCount').innerText = pending.length + ' pending';
  const body = document.getElementById('approvalsBody');
  body.innerHTML = pending.length ? pending.map(e=>`
    <tr>
      <td>${nameFor(e.username)}</td>
      <td>${e.type}</td>
      <td class="mono">${fmt(e.amount)}</td>
      <td>${e.description}</td>
      <td>${e.date}</td>
      <td>
        <div class="action-row">
          <button class="btn btn-emerald btn-sm" onclick="decide(${e.id},'Approved')"><i class="bi bi-check-lg"></i> Approve</button>
          <button class="btn btn-danger-ghost btn-sm" onclick="decide(${e.id},'Rejected')"><i class="bi bi-x-lg"></i> Reject</button>
        </div>
      </td>
    </tr>`).join('') : `<tr class="empty-row"><td colspan="6">Nothing waiting on you — the queue is clear.</td></tr>`;
}

function renderPayments(){
  if(currentUser.role !== 'manager') return;
  const approved = expenses.filter(e=>e.status==='Approved').sort((a,b)=>b.id-a.id);
  const unpaidCount = approved.filter(e=>e.payment==='Unpaid').length;
  document.getElementById('paymentsCount').innerText = unpaidCount + ' unpaid';
  const body = document.getElementById('paymentsBody');
  body.innerHTML = approved.length ? approved.map(e=>`
    <tr>
      <td>${nameFor(e.username)}</td>
      <td>${e.type}</td>
      <td class="mono">${fmt(e.amount)}</td>
      <td>${e.date}</td>
      <td>${paymentBadge(e.payment)}</td>
      <td>${e.payment==='Unpaid'
          ? `<button class="btn btn-primary btn-sm" onclick="markPaid(${e.id})"><i class="bi bi-cash"></i> Mark as paid</button>`
          : `<span class="mono" style="font-size:12.5px;color:var(--ink-soft)">Settled</span>`}</td>
    </tr>`).join('') : `<tr class="empty-row"><td colspan="6">No approved claims yet.</td></tr>`;
}

function renderReports(){
  const list = visibleExpenses();
  const cats = {};
  list.forEach(e=> cats[e.type] = (cats[e.type]||0) + Number(e.amount));
  const maxCat = Math.max(1, ...Object.values(cats));
  const catEl = document.getElementById('categoryChart');
  const catEntries = Object.entries(cats).sort((a,b)=>b[1]-a[1]);
  catEl.innerHTML = catEntries.length ? catEntries.map(([k,v])=>`
    <div class="bar-row">
      <div class="lbl">${k}</div>
      <div class="bar-track"><div class="bar-fill" style="width:${(v/maxCat*100).toFixed(0)}%"></div></div>
      <div class="amt">${fmt(v)}</div>
    </div>`).join('') : `<div class="empty-state" style="padding:20px"><p>No data to chart yet.</p></div>`;

  const statuses = ['Pending','Approved','Rejected'];
  const colors = {Pending:'var(--amber)', Approved:'var(--emerald)', Rejected:'var(--brick)'};
  const counts = statuses.map(s=> list.filter(e=>e.status===s).length);
  const maxS = Math.max(1, ...counts);
  const stEl = document.getElementById('statusChart');
  stEl.innerHTML = statuses.map((s,i)=>`
    <div class="bar-row">
      <div class="lbl">${s}</div>
      <div class="bar-track"><div class="bar-fill" style="width:${(counts[i]/maxS*100).toFixed(0)}%;background:${colors[s]}"></div></div>
      <div class="amt">${counts[i]}</div>
    </div>`).join('');
}

/* =========================================================
   ACTIONS
========================================================= */
function addExpense(){
  const type = document.getElementById('etype').value;
  const amount = document.getElementById('eamount').value;
  const desc = document.getElementById('edesc').value.trim();
  const date = document.getElementById('edate').value || new Date().toISOString().slice(0,10);
  const err = document.getElementById('createErr');

  if(!type || !amount || Number(amount) <= 0 || !desc){
    err.style.display='block';
    return;
  }
  err.style.display='none';

  expenses.push({
    id: nextId++,
    username: currentUser.username,
    type, amount:Number(amount), description:desc, date,
    status:'Pending', payment:'Unpaid'
  });

  document.getElementById('eamount').value='';
  document.getElementById('edesc').value='';
  document.getElementById('edate').value='';

  toast('Expense submitted for approval', 'ok');
  dash('expenses');
}

function decide(id, status){
  const e = expenses.find(x=>x.id===id);
  if(!e) return;
  e.status = status;
  toast(`Claim ${status.toLowerCase()}`, status==='Approved' ? 'ok' : 'bad');
  renderAll();
}

function markPaid(id){
  const e = expenses.find(x=>x.id===id);
  if(!e) return;
  e.payment = 'Paid';
  toast('Marked as paid', 'ok');
  renderAll();
}

function saveSettings(){
  const name = document.getElementById('setName').value.trim();
  const pass = document.getElementById('setPass').value;
  if(!name) return;
  currentUser.name = name;
  if(pass) currentUser.password = pass;
  document.getElementById('sideUserName').innerText = currentUser.name;
  document.getElementById('topUserName').innerText = currentUser.name;
  document.getElementById('topAvatar').innerText = currentUser.name.split(' ').map(s=>s[0]).slice(0,2).join('').toUpperCase();
  document.getElementById('setPass').value='';
  toast('Profile updated', 'ok');
}

/* =========================================================
   TOAST
========================================================= */
let toastTimer;
function toast(msg, kind){
  const t = document.getElementById('toast');
  t.className = 'toast show ' + (kind||'');
  t.innerHTML = `<i class="bi ${kind==='ok'?'bi-check-circle':kind==='bad'?'bi-exclamation-circle':'bi-info-circle'}"></i> ${msg}`;
  clearTimeout(toastTimer);
  toastTimer = setTimeout(()=> t.classList.remove('show'), 2600);
}
</script>
</body>
</html>
