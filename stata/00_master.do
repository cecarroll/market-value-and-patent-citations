*******************************************************************************
* Market Value and Patent Citations: A Replication on DISCERN (1980-2015)
* Cole Carroll (Ball State University, ISPE) with Nathanael Snow, 2024
*
* Replicates the Tobin's Q / knowledge-stock regressions of
* Hall, Jaffe & Trajtenberg (2005, RAND J. Econ.) on the DISCERN database
* (Arora, Belenzon & Sheer 2020) instead of the NBER patent file.
*
* Set REPO below. Put the DISCERN_MARCH_2020 folder in data/ (see data/README.md).
*******************************************************************************
clear all
set more off
global REPO "C:/path/to/market-value-and-patent-citations"   // <- edit this line only
global ROOT "$REPO/data/DISCERN_MARCH_2020"
global CODE "$REPO/stata"
cd "$ROOT"

* Step 0 -- DISCERN's own build (authors' code, shipped with the data; not in
* this repo). Produces output_files/DISCERN_Panal_Data_1980_2015.dta
* do "./programs/main_do_file.do"

do "$CODE/01_merge_compustat.do"     // DISCERN panel + Compustat financials
do "$CODE/02_vars.do"                // GDP-deflate financials, R&D stock seed, market value
do "$CODE/03_construct_stocks.do"    // knowledge stocks, Tobin's Q, log ratios  [reconstructed]
do "$CODE/04_regressions.do"         // FE regressions: levels, lags 1-3, first differences
