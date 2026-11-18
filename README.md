# Market Value and Patent Citations: A Replication on DISCERN

Stata code for **Carroll, C. & Snow, N. (2024). *Market Value and Patent Citations Revisited and Replicated.*** Draft presented at SOBIE 2024 (Ball State University, Institute for the Study of Political Economy).

**What it does.** It re-estimates the Tobin's Q regressions of Hall, Jaffe & Trajtenberg (2005, *RAND Journal of Economics*), which ask whether markets value a firm's R&D, patents, and patent citations. The original used the NBER patent file (1976–2006). This replication uses the **DISCERN** database (Arora, Belenzon & Sheer 2020), which covers 1980–2015, tracks ownership and name changes, and is merged with Compustat financials: about 58,000 firm-years, built from roughly 25 million underlying patent and citation records.

**Model.** Firm fixed-effects regressions of log Tobin's Q on log knowledge-stock ratios:

log(MV/A)ᵢₜ = β₀ + β₁ log(R&D stock/A)ᵢₜ + β₂ log(Patent stock/R&D stock)ᵢₜ + β₃ log(Citation stock/Patent stock)ᵢₜ + αᵢ + εᵢₜ

Each knowledge stock is built with 15% annual depreciation, following HJT 2005. The specifications cover contemporaneous ratios, 1–3 year lags, first differences, and industry subsamples (paper, semiconductors, information).

## Pipeline

| File | Step | Status |
|---|---|---|
| `stata/00_master.do` | sets paths, runs everything | |
| *(DISCERN `main_do_file.do`)* | DISCERN's own panel build (the authors' code, distributed with the data) | not included |
| `stata/01_merge_compustat.do` | merge Compustat financials onto the DISCERN firm-year panel (CUSIP × year) | original |
| `stata/02_vars.do` | GDP-deflate financials, seed cumulative R&D, build market value | original |
| `stata/03_construct_stocks.do` | knowledge stocks (δ = 0.15), Tobin's Q, log ratios | **reconstructed from the paper's method section; not yet run** |
| `stata/04_regressions.do` | FE regressions with levels, lags and differences; `esttab` tables | original specifications |

The variable-construction step was originally run interactively and not saved. `03_construct_stocks.do` rebuilds it from the method as written in the draft and lists the assumptions to verify against the draft's summary statistics.

## Data (not included)

- **DISCERN** (Arora, Belenzon & Sheer 2020), NBER/Duke: firm-level patent, publication and citation panel, with its own build code.
- **Compustat North America** via WRDS. This is licensed and cannot be redistributed.
- **GDP deflator** (BEA/FRED) → `data/GDPDef.dta`

## References

Hall, B. H., Jaffe, A., & Trajtenberg, M. (2005). Market value and patent citations. *RAND Journal of Economics*, 36(1), 16–38.
Arora, A., Belenzon, S., & Sheer, L. (2021). Matching patents to Compustat firms, 1980–2015: Dynamic reassignment, name changes, and ownership structures. *Research Policy*, 50(5).
Griliches, Z. (1981). Market value, R&D, and patents. *Economics Letters*, 7(2), 183–187.
