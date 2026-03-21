# Page Map

## Purpose
This file is the page-by-page operating map for the Financial Report PBIP. Use it to understand what each page is for, what domain it depends on, and whether the current issue is mostly report wiring, semantic-model logic, or missing source data.

## Working Pages

### Executive Overview
- Purpose: top-level executive summary
- Primary domain: existing SAP-backed summary logic
- Status: working
- Notes: keep current shell and KPI rhythm

### Income Statement
- Purpose: core income statement view
- Primary domain: `Fact_PNL`
- Status: working
- Notes: preserve current SAP-backed logic

### Financial Details
- Purpose: deeper financial breakdowns
- Primary domain: existing SAP-backed financial model
- Status: working
- Notes: use as a reference for stable page behavior

### Performance Details
- Purpose: performance breakdown page
- Primary domain: existing SAP-backed logic
- Status: working
- Notes: keep layout consistent with current design direction

### Revenue Insights
- Purpose: revenue analysis
- Primary domain: `Fact_SalesDetail`
- Status: working
- Notes: serves as a good reference for stable sales-domain visuals

### Cost Structure
- Purpose: cost breakdown and structure
- Primary domain: `Fact_PNL`
- Status: working
- Notes: already aligned with the current shell

### Balance Sheet
- Purpose: balance sheet analysis
- Primary domain: `Fact_BalanceSheet`
- Status: working
- Notes: use as a stable reference for SAP-backed balance logic

## Pages In Active Repair

### Profit and Loss
- Purpose: management-style P&L summary page from Sample 2
- Primary domain: `Fact_PNL`, `generalLedgerEntries`, `glBudgetEntries`
- Status: partially working, still broken in lower visuals
- Main issue type: visual wiring and disconnected helper logic
- Notes: top KPIs render; lower visuals still show relationship-style failures

### Actual vs Budget
- Purpose: compare actuals with budget and variance
- Primary domain: `glBudgetEntries`, `BudgetVsActualTable`, `generalLedgerEntries`
- Status: partially working, still broken
- Main issue type: mixed report rewiring plus placeholder budget logic
- Notes: page can be stabilized, but true budget truth still depends on a real SAP budget source

### Accounts Payable
- Purpose: AP balances, aging, and invoice status
- Primary domain: `vendorLedgerEntries`
- Status: partially working
- Main issue type: some visuals still reference stale fields or filters
- Notes: top cards and some charts prove SAP-backed AP data is present

### AP Invoice Details
- Purpose: invoice-level AP detail / drillthrough
- Primary domain: `vendorLedgerEntries`
- Status: still unstable
- Main issue type: drillthrough and visual relationship errors
- Notes: benchmark-specific filters were removed; page still needs safe single-domain rewiring

### Accounts Receivable
- Purpose: AR balances, aging, and invoice status
- Primary domain: `customerLedgerEntries`
- Status: partially working
- Main issue type: lower visuals still contain field/filter issues
- Notes: top half of the page proves SAP-backed AR data is present

### AR Invoice Details
- Purpose: invoice-level AR detail / drillthrough
- Primary domain: `customerLedgerEntries`
- Status: still unstable
- Main issue type: drillthrough and visual relationship errors
- Notes: page should remain a drillthrough page but stay as single-table as possible

### Cashflow
- Purpose: cash-in / cash-out and short-term projection page
- Primary domain: `bankAccountLedgerEntries`, cashflow helper dates
- Status: mostly broken
- Main issue type: compatibility-table limitations and helper-date wiring
- Notes: current cashflow logic is compatibility-based, not a true bank-ledger build

### Commitment Report
- Purpose: commitments, budget usage, and remaining allocation
- Primary domain: `purchaseLines`, `CommitmentDocumentTable`, `glBudgetEntries`
- Status: partially working, still broken in major visuals
- Main issue type: mixed commitment and placeholder-budget wiring
- Notes: committed PO logic is partly present; true budget truth is still provisional

## Operational Rules
- Do not delete the active-repair pages.
- Keep the Sample 2 structure unless the user requests otherwise.
- Prefer report-side rewires before risky model relationships.
- Keep all currency presentation in `IQD`.
