.wcurl <- "https://biogeo.ucdavis.edu/data/worldclim/..."

cmip6_world <- function(model, ssp, time, var, res, path) {
  
  res <- as.character(res)
  stopifnot(res %in% c("2.5", "5", "10", "0.5"))
  stopifnot(var %in% c("tmin", "tmax", "prec", "bio", "bioc"))
  ssp <- as.character(ssp)
  stopifnot(ssp %in% c("126", "245", "370", "585"))
  # stopifnot(model %in% c("BCC-CSM2-MR", "CanESM5", "CNRM-CM6-1", "CNRM-ESM2-1", "GFDL-ESM4", "IPSL-CM6A-LR", "MIROC-ES2L", "MIROC6", "MRI-ESM2-0"))
  stopifnot(model %in% c("ACCESS-CM2","BCC-CSM2-MR","CIESM","CNRM-CM6-1","CNRM-ESM2-1","FIO-ESM-2-0","HadGEM3-GC31-LL","INM-CM5-0",
                         "MIROC-ES2L","MPI-ESM1-2-LR", "ACCESS-ESM1-5","CanESM5","CMCC-ESM2","CNRM-CM6-1-HR","FGOALS-g3",
                         "GISS-E2-1-G","INM-CM4-8", "IPSL-CM6A-LR","MPI-ESM-1-2-HAM","NESM3"))
  stopifnot(time %in% c("2021-2040", "2041-2060", "2061-2080"))
  
  # some combinations do not exist. Catch these here.
  
  if (var == "bio") var <- "bioc"
  stopifnot(dir.exists(path))
  
  fres <- ifelse(res==0.5, "30s", paste0(res, "m"))
  path <- file.path(path, paste0("wc2.1_", fres, "/"))
  dir.create(path, showWarnings=FALSE)
  
  zip <- paste0("wc2.1_", fres, "_", var, "_", model, "_ssp", ssp, "_", time, ".zip")
  pzip <- file.path(path, zip)
  outf <- gsub("\\.zip$", ".tif", zip)
  poutf <- file.path(path, outf)
  if (!file.exists(pzip)) {
    url <- paste0(.wcurl, "fut/", fres, "/", zip)
    ok <- try(utils::download.file(url, pzip, mode="wb"), silent=TRUE)
    if (class(ok) == "try-error") {stop("download failed")}
    if (!file.exists(pzip)) {stop("download failed")}
  }
  if (!file.exists(poutf)) {
    fz <- try(utils::unzip(pzip, exdir=path, junkpaths=TRUE), silent=TRUE)
    if (class(fz) == "try-error") {stop("unzip failed")}
  }
  rast(poutf)
}