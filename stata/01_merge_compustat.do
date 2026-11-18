* 01_merge_compustat.do
* Attach Compustat firm financials to the DISCERN firm-year panel.
* Key: CUSIP x year. (Originally appended to DISCERN's panel_do.do.)
use "./output_files/DISCERN_Panal_Data_1980_2015.dta", clear
gen composite_key = cusip + "_" + string(year)
merge 1:1 composite_key using "./data/compustat_sample_80_15.dta"
save "./output_files/Merged.dta", replace
