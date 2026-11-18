* 02_vars.do
* Deflate Compustat financials to real dollars (GDP deflator, ./data/GDPDef.dta),
* seed the cumulative R&D series, and build market value = LT debt + ST debt + common stock.


use "./output_files/Merged.dta", clear
sort fyear
drop _merge
merge m:1 fyear using "./data/GDPDef.dta"

save "./output_files/vars.dta", replace

gen realact = act * gdpmultiplier
gen realat = at * gdpmultiplier
gen realbkvlps = bkvlps * gdpmultiplier
gen realcapx = capx * gdpmultiplier
gen realch = ch * gdpmultiplier
gen realcshi = cshi * gdpmultiplier
gen realcsho = csho * gdpmultiplier
gen realcstk = cstk * gdpmultiplier
gen realdlc = dlc * gdpmultiplier
gen realdltt = dltt * gdpmultiplier
gen realebit = ebit * gdpmultiplier
gen realebitda = ebitda * gdpmultiplier
gen realgdwl = gdwl * gdpmultiplier
gen realintan = intan * gdpmultiplier
gen realintano = intano * gdpmultiplier
gen realinvt = invt * gdpmultiplier
gen realitcb = itcb * gdpmultiplier
gen realivaeq = ivaeq * gdpmultiplier
gen realivao = ivao * gdpmultiplier
gen realmibt = mibt * gdpmultiplier
gen realppent = ppent * gdpmultiplier
gen realpstk = pstk * gdpmultiplier
gen realsale = sale * gdpmultiplier
gen realtxt = txt * gdpmultiplier
gen realxrd = xrd * gdpmultiplier
gen realxrdp  = xrdp * gdpmultiplier


save "./output_files/vars.dta", replace

sort gvkey fyear
gen realsumxrd = 0
by gvkey: replace realsumxrd = realxrdp + realxrd if _n == 1 
by gvkey: replace realsumxrd = realsumxrd[_n-1] + realxrd if _n >1

gen builtmkvalt = realdltt + realdlc + realcstk
save "./output_files/vars.dta", replace
