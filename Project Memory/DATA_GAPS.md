# Data Gaps

## Purpose
This file separates what is truly available from SAP-backed logic, what is currently placeholder or compatibility logic, and what still depends on future SAP-side confirmation or buildout.

## Available Now

### Profit and Loss / Financial Reporting Core
- `Fact_PNL` is available and already powers working financial pages.
- `Fact_BalanceSheet` is available and already powers the balance sheet page.
- `Fact_SalesDetail` is available and already powers sales and revenue-oriented pages.

### Accounts Receivable
- SAP-backed AR-style data is available through `customerLedgerEntries`.
- AR top cards and customer-level views prove the underlying domain exists.
- Remaining problems are mostly report wiring and visual cleanup.

### Accounts Payable
- SAP-backed AP-style data is available through `vendorLedgerEntries`.
- AP top cards and invoice-status visuals prove the underlying domain exists.
- Remaining problems are mostly report wiring and visual cleanup.

### Commitment-Like Purchase Logic
- Commitment-style logic is partly available through `purchaseLines`.
- This supports committed purchase behavior, but it is not yet a complete enterprise commitment model.

## Placeholder Or Compatibility Logic

### Budget
- `glBudgetEntries` is currently a compatibility budget derived from actual GL logic.
- This is useful for making budget-shaped pages bind and render.
- It is not confirmed native SAP budget data.

### Cashflow
- `bankAccountLedgerEntries` is currently a compatibility shell.
- It is not yet a true SAP bank-ledger or cash-movement fact.
- Current cashflow work should be described as compatibility logic unless a real source is added.

### Benchmark Compatibility Tables
- Several tables exist only to help Sample 2 pages bind to valid objects.
- These should be treated as support layers, not assumed business truth.
- Examples include helper date tables, dimension slicers, category sort tables, and benchmark-style alias tables.

## Missing Or Not Yet Confirmed

### Native SAP Budget Domain
- Needed for true budget vs actual reporting.
- Required if the business expects real approved budget figures rather than a compatibility placeholder.

### True Bank / Cash Movement Domain
- Needed for true cashflow reporting.
- Required if the business expects actual cash movement logic rather than GL-derived compatibility behavior.

### Broader Commitment Domain
- May still be needed if `purchaseLines` does not cover all commitment states the business expects.
- Depends on how far the commitment reporting needs to go beyond purchase quote/order logic.

## User-Side Or SAP-Side Dependencies

### Depends On User / SAP Confirmation
- whether a real SAP budget source exists and should be modeled
- whether a true bank-ledger or cash-movement source exists and should be modeled
- whether purchase-line commitment logic is sufficient for the intended commitment-report scope

### Does Not Currently Depend On User Input
- AR domain existence
- AP domain existence
- core P&L domain existence
- balance sheet domain existence
- general report rewiring, cleanup, and IQD formatting work

## Practical Reading
- If a page is broken but its top cards already show valid numbers, the domain usually exists and the problem is likely report wiring.
- If a page depends on budget or bank-ledger truth, verify whether the source is real before claiming the page is fully solved.
