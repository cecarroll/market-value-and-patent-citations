*******************************************************************************
* 03_construct_stocks.do  -- RECONSTRUCTED, NOT YET RUN
*
* The original version of this step was run interactively in 2024 and the
* code was not saved. It is rebuilt here from the method as written in the
* paper draft (SOBIE, May 2024):
*   - knowledge stocks:  Stock_it = (1 - .15) * Stock_i,t-1 + Input_it,
*     starting in each firm's first observed year (delta = .15, as in HJT 2005)
*   - Tobin's Q:         market value / total assets
*   - regressors:        log(R&D stock / assets), log(patent stock / R&D stock),
*                        log(citation stock / patent stock)
* Variable names match those used in 04_regressions.do.
*
* ASSUMPTIONS TO CONFIRM against the draft's Figure 5 summary statistics
* (e.g. 58,245 firm-years with stocks; median R&D stock 34.2; median patent
* stock 6.99) before treating results as a reproduction:
*   (a) patent flow  = pat_yr  (granted patents per firm-year, DISCERN)
*   (b) citation flow = inter_cites + corp_exter_cites  (DISCERN citation counts)
*   (c) market value = builtmkvalt from 02_vars.do (no preferred stock)
*******************************************************************************
use "./output_files/vars.dta", clear

xtset gvkey fyear
sort gvkey fyear

local delta = .15

* R&D stock (real), patent stock, citation stock
foreach s in RD Pat Cites {
    if "`s'" == "RD"    local flow realxrd
    if "`s'" == "Pat"   local flow pat_yr
    if "`s'" == "Cites" {
        capture drop cites_flow
        gen cites_flow = inter_cites + corp_exter_cites
        local flow cites_flow
    }
    gen `s'Stock = `flow' if _n == 1
    by gvkey: replace `s'Stock = `flow' if _n == 1
    by gvkey: replace `s'Stock = (1 - `delta') * `s'Stock[_n-1] + `flow' if _n > 1
}
rename RDStock realRDStock

* Tobin's Q and log ratios (zeros/negatives become missing under log)
gen bigQ                   = builtmkvalt / realat
gen lbigQ                  = ln(bigQ)
gen lrealRDStocktorealAT   = ln(realRDStock / realat)
gen lPatStocktorealRDStock = ln(PatStock / realRDStock)
gen lCitesStocktoPatStock  = ln(CitesStock / PatStock)

* Quick check against the draft's Figure 5
tabstat builtmkvalt realat realRDStock PatStock CitesStock, ///
    stats(n mean p50 min max sd) columns(statistics)

save "./output_files/analysis_panel.dta", replace
