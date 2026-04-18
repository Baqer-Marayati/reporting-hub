# Decisions

## 2026-04-18 -- Discrepancy fix-up batch (Service Performance, CANON)

Batch of corrections applied after the 2026-04-18 discrepancy review. All edits in the CANON PBIP only; PAPERENTITY tenant not yet touched.

- **`svc_p4_donut_rev` was a duplicate of `svc_p4_bar_parts`** ("Top Parts by Cost" cloned with same query). Rebuilt as `donutChart` titled "Revenue by Type" against `Fact_ServiceRevenue.RevenueType` x `[Total Service Revenue]`. Page 4 now matches its Phase-3 spec.
- **Customer-list visuals get `[Total Service Calls] > 0` visual-level filter** (not category swap). Added `filterConfig` to `svc_p3_bar_profit`, `svc_p3_bar_revcost`, `svc_p4_bar_custcost`, `svc_p5_bar_calls`. This is the implementation of the earlier 2026-04-18 decision to keep `Dim_Customer.CustomerName` as the row/category. Filter expression in PBIR: `Comparison ComparisonKind=1 (GreaterThan)` against `_Measures[Total Service Calls]` and literal `0L`.
- **`Dim_ProblemType` source augmented** with `UNION ALL SELECT 0 AS ProblemTypeID, 'Unclassified' AS ProblemTypeName FROM DUMMY`. `Fact_ServiceCalls` already coalesces NULL `prblmTyp` to `0`, so Page 4's "Calls by Fault Type" no longer renders a `(Blank)` bucket -- it shows "Unclassified".
- **`FSMA Parts Cost` measure ends with `+ 0`** so the card returns `0 د.ع.` instead of `--` when no rows match `TaxCode IN { "FSMA", "SMA" }`. (Open follow-up: confirm via SAP that `TaxCode` values are exactly `FSMA` / `SMA` -- if no row ever matches, the measure is structurally dead and should be redefined.)
- **Off-canvas duplicate visuals on Page 5 deleted.** `svc_p5_bar_profit` and `svc_p5_bar_rev` were both parked at `(x=-2000, y=-2000, h=0, w=0)`. Their measures (`Client Profitability`, `Total Service Revenue`) already live in `svc_p5_bar_calls` (Client Summary pivot). Removed both visual folders.
- **`Dim_Equipment.MachineClass` now matches `Dim_Equipment.ItemGroupClass`.** Old MachineClass logic only flagged `Production` when the equipment had a `U_Project`, which dropped IPS/group-139/`#N/A` machines into `Other`. New logic order: IPS / `#N/A` / group 139 / has-project all map to `Production` first; DS Copier -> Office; B2C -> Consumer; groups 172..177 -> Service (parity with `Dim_Item.MachineClass`); else Other. Side effect: `Untagged Production Machines` and `Untagged Production Calls` measures will now report `0`, which is the desired "perfect coverage" state. Kept the measures in the model as a regression safety-net.
- **Slicer rail label "Customer Type"** is the canonical label for the `Dim_Customer.CustomerType` (`OCRD.U_SolutionType`) slicer on pages 1, 3, 4. Old "Machine Type" label in screenshots `Portfolio/Shared/ChatContext/images/1.png`/`2.png` is stale -- re-screenshot after Desktop save.
- **Memory refresh.** `Project Memory/CURRENT_STATUS.md` and `Project Memory/REFERENCE.md` rewritten with today's date and the correct PBIP path under `Companies/CANON/Canon Service Report/...`.

Open items (not fixed in this batch):
- Slicer rail still inconsistent across pages: page 2 uses Team, page 5 uses Customer slicer. Decide whether to add Customer Type slicer to those pages too, or leave them context-specific.
- `Net Profit per Machine` subtracts unallocated `[Total Parts Cost]` from per-machine-allocated revenue. Per-customer rows reconcile, per-equipment drill-through will not. Long-term fix is per-equipment cost allocation; not in scope today.
- Inactive `Dim_Equipment.ProjectCode -> Dim_Project.ProjectCode` bothDirections relationship (`aa000005-0001-4000-c005-000000000002`) is dormant. Either delete or annotate before any future agent activates it via `USERELATIONSHIP`.

## 2026-04-18 -- Customer-list visuals must keep Dim_Customer as category

- Bar/matrix visuals on Pages 3, 4, 5 that list **customers** must keep `Dim_Customer.CustomerName` as the row/category. Do **not** swap it to `Fact_ServiceCalls.CustomerName` (or any denormalized fact string), even to "fix" the slicer-doesn't-reach-clients problem.
- Reason: those visuals carry measures like `Total Service Revenue`, `Client Profitability`, `Total Parts Cost`, `FSMA Revenue Allocated` -- these aggregate from `Fact_ServiceRevenue` / `Fact_ServiceParts`, which have **no relationship to `Dim_Equipment`** and only join customers via `Dim_Customer`. Switching the category to a non-key string makes those measures return the **grand total on every row** (verified visually: every customer ~40M).
- The original "too many clients appear under MachineClass=Production" problem must be solved by either: (a) PBIR visual-level filter measure (e.g. `[Total Service Calls] > 0`) on each customer-list visual, or (b) producing per-machine allocated revenue/cost so the equipment slicer can reach revenue, or (c) accepting the customer list shows all customers and only the calls-measure responds to the slicer.
- Bidirectional cross-filter on `Fact_ServiceCalls -> Dim_Customer` is **not** an option here -- it would create an ambiguous date path through `Dim_Date -> Fact_ServiceRevenue`.

## 2026-03-29 -- Phase 1 Discovery Decisions

### Data source mapping (plan vs actual)

| Plan assumed | Actual source | Decision |
|-------------|--------------|----------|
| SCL1 = Activities | **SCL6** = Activities | Use SCL6 for technician visits, duration, check-in/out |
| SCL5 = Parts consumed | **SCL2** (part list) + **DLN1 via SCL4** (cost) | SCL2 for what parts; DLN1 for cost values |
| OCTR/CTR1 = Contract revenue | **INV1 where ItemCode='SV002'/'MPS'** | FSMA/MPS revenue from regular invoices, not contracts module |
| OSCL.technician = primary tech | **SCL6.Technician** (field) + **OSCL.assignee** (coordinator) | SCL6.Technician for performance metrics; OSCL.assignee for call ownership |
| OINS.project = project link | **INV1.Project / DLN1.Project** | No project on equipment cards; project lives on financial document lines |

### Technician team classification

Hard-coded by empID (no SAP field for team):
- Production Service: 66, 67, 68, 69, 70, 71
- Office Service: 72, 73, 74, 75, 76, 77, 78
- Call Center: 80
- Exclude: 115, 117 (placeholders), and all non-dept-6 assignees

### Machine classification

Group prefix logic:
- `B2B - IPS*` = Production
- `B2B - DS Copier*` = Office
- `B2C*` = Consumer/Office
- Group 139 (#N/A) = **Production** (stakeholder confirmed; contains imagePRESS, varioPRINT, COLORADO)

### FSMA revenue model

- SV002 = FSMA per-page revenue (qty = page count, price = rate per page)
- SV001 = Labour income (flat fee per visit)
- MPS = MPS per-page revenue
- TaxCode FSMA/SMA on parts = delivered under contract at zero/reduced cost
- Revenue is at customer level, not per-machine (SV002 lines have no Project code)

### Machine profitability: per customer per machine (stakeholder decision)

- Show profitability at customer x machine level, not just customer
- FSMA revenue (SV002) must be allocated from customer level down to individual machines
- Allocation method: proportional to service call volume or counter readings per machine
- Cost side: already per-project via DLN1.Project and per-call via SCL4 linkage

### Ticket creation mapping (userSign -> OUSR, NOT OHEM)

OSCL.userSign maps to OUSR.INTERNAL_K, not to OHEM.empID:
- userSign=64 -> OUSR "Yamam Nabil" (AJZ09) -- creates 68% of tickets (production)
- userSign=72 -> OUSR "Office Service Department" (AJZ17, shared account) -- creates 32% (office)

Yamam's empID in OHEM is 80 (not 64). empID 64 in OHEM = Almuntadher Yousif (Sales, unrelated).

### Exclusions

- Non-service-dept assignees excluded from technician views
- empID 115, 117 excluded (phantom records)
- Yamam Nabil (empID 80) IS measurable via OUSR -- include her ticket creation KPIs on Ticket Operations page
