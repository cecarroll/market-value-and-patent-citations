# data/

Put the DISCERN distribution here. Nothing in this folder except this README is committed.

```
data/
  DISCERN_MARCH_2020/            the folder as distributed by the DISCERN authors
    programs/                    their build code (main_do_file.do, panel_do.do, ...)
    data/                        their input files, plus two you add:
      compustat_sample_80_15.dta   Compustat North America extract (WRDS; licensed)
      GDPDef.dta                   GDP deflator by fiscal year (fyear, gdpmultiplier)
    output_files/                created by the build; this repo's scripts write here too
```

`stata/00_master.do` points at `data/DISCERN_MARCH_2020` by default, so once the folder is in place you only need to set `REPO` at the top of that file.
