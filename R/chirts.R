#' Read GeoTiff tiles from ftp://ftp.chc.ucsb.edu/
#' 
#' @param var character, A valid variable from the options: Tmax, Tmin, RHum, HeatIndex 
#' @param dates character, vector of start date and end date for processing interval, 
#'  in the format ("MM-DD-YYYY")
#' @param y spatial, see details
#' @param as.raster logical, If TRUE returns \code{\link[terra]{SpatRaster}} with \code{\link[terra]{crop}} by y, ignoring any other arguments
#' @param ... options, see \code{\link[terra]{extract}}
#' @return A SpatRaster object if \code{as.raster=TRUE}, else matrix, list, or data.frame 
#' @details
#' Variable escription from https://data.chc.ucsb.edu/products/CHIRTSdaily/aaa.Readme.txt
#' Tmax: Daily average maximum air temperature at 2m above ground
#' Tmin: Daily average minimum air temperature at 2m above ground
#' RHum: Daily average relative humidity
#' HeatIndex: Daily average heat index
#' y any allowed format from \code{\link[terra]{cropr}} or \code{\link[terra]{extract}}
#' 
#' interval: supported intervals are daily, pentad, dekad, monthly, 2-monthly, 3-monthly, annual
#' currently hard coded to daily 
#' 
#' @examples
#' Case 1: return summary tables
#' dates <- c("2010-12-15","2010-12-31")
#' lonlat <- data.frame(lon = c(-55.0281,-54.9857), lat = c(-2.8094, -2.8756))
#' val <- get_chrits_out(var = "Tmax", dates, y = lonlat, fun = mean)
#' 
#' Case 2: return raster
#' f <- system.file("ex/lux.shp", package="terra")
#' v <- vect(f)
#' r <- get_chrits_out(var = "Tmax", dates, y = v, as.raster = TRUE)
#'                        
#' @noRd

.get_CHIRTS_tiles_CHC <- function(var, dates, ...){
  stopifnot(var %in% c("HeatIndex", "RHum", "Tmax", "Tmin"))
  
  # setup file names
  seqdate <- seq.Date(as.Date(dates[1]), as.Date(dates[2]), by = "day")
  years <- format(seqdate, format="%Y")
  
  # year range
  yrange <- seq(1983, 2016, 1)
  stopifnot(unique(years) %in% yrange)
  
  dates <- gsub("-","\\.", seqdate)
  fnames <- file.path(years, paste0(var, ".", dates, ".tif"))
  
  # hardcoded now, but need to change in the future with more options
  coverage <- "global"
  interval <- "daily"
  format <- "tifs"
  
  resolution <- gsub("0\\.", "p", resolution)
  
  u <- file.path("https://data.chc.ucsb.edu/products/CHIRTSdaily/v1.0", 
                 paste0(coverage, "_", format, "_", resolution), var, fnames)
  u1 <- file.path("/vsicurl", u)
  r <- terra::rast(u1)
  # time(r) <- seqdate
  return(r)
}

get_chrits_out <- function(var, dates, y, as.raster = FALSE, ...){
  # get CHIRTS GeoTiff files
  rr <- .get_CHIRTS_tiles_CHC(var, dates)
  
  if(as.raster){
    rout <- crop(rr, y)
    return(rout)
  } else {
    vals <- extract(rr, y, ...)
    vals$ID <- NULL
    return(vals)
  }
}

