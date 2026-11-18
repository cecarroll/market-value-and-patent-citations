*******************************************************************************
* 04_regressions.do
* Firm fixed-effects regressions of log Tobin's Q on log knowledge-stock ratios
* (paper draft, Figure 4 and Figure 6). Robust SEs.
*******************************************************************************
use "./output_files/analysis_panel.dta", clear
xtset gvkey fyear

* Contemporaneous
xtreg lbigQ lrealRDStocktorealAT lPatStocktorealRDStock lCitesStocktoPatStock, fe robust
estimates store full0

* Lagged ratios: 1, 2, 3 years
xtreg lbigQ L1.lrealRDStocktorealAT L1.lPatStocktorealRDStock L1.lCitesStocktoPatStock, fe robust
estimates store fullL1
xtreg lbigQ L2.lrealRDStocktorealAT L2.lPatStocktorealRDStock L2.lCitesStocktoPatStock, fe robust
estimates store fullL2
xtreg lbigQ L3.lrealRDStocktorealAT L3.lPatStocktorealRDStock L3.lCitesStocktoPatStock, fe robust
estimates store fullL3

* First differences of the ratios
xtreg lbigQ D1.lrealRDStocktorealAT D1.lPatStocktorealRDStock D1.lCitesStocktoPatStock, fe robust
estimates store fulld1

capture which esttab
if _rc ssc install estout
esttab full0 fullL1 fullL2 fullL3 fulld1, se scalars(N r2 F) ///
    mtitles("Levels" "Lag 1" "Lag 2" "Lag 3" "First diff.")
esttab full0 fullL1 fullL2 fullL3 fulld1 using "./output_files/table_fe.rtf", ///
    se scalars(N r2 F) replace

* Industry subsamples (paper draft, Figure 7: paper, semiconductors, information)
* -- set the NAICS prefixes to the definitions used in the draft before running.
* xtreg lbigQ lrealRDStocktorealAT lPatStocktorealRDStock lCitesStocktoPatStock if substr(naics,1,3)=="322", fe robust
* xtreg lbigQ lrealRDStocktorealAT lPatStocktorealRDStock lCitesStocktoPatStock if substr(naics,1,6)=="334413", fe robust
* xtreg lbigQ lrealRDStocktorealAT lPatStocktorealRDStock lCitesStocktoPatStock if substr(naics,1,2)=="51", fe robust
