# sedac

# population: https://sedac.ciesin.columbia.edu/data/set/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01
# https://sedac.ciesin.columbia.edu/downloads/docs/popdynamics/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01-readme.txt

# Base Year	GeoTIFF	https://sedac.ciesin.columbia.edu/downloads/data/popdynamics/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01-byr-geotiff.zip
# Projection Grids:		
# SSP1 (Sustainability)	GeoTIFF	https://sedac.ciesin.columbia.edu/downloads/data/popdynamics/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01-proj-ssp1-geotiff.zip
# SSP2 (Middle of the road)	GeoTIFF	https://sedac.ciesin.columbia.edu/downloads/data/popdynamics/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01-proj-ssp2-geotiff.zip
# SSP3 (Regional rivalry)	GeoTIFF	https://sedac.ciesin.columbia.edu/downloads/data/popdynamics/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01-proj-ssp3-geotiff.zip
# SSP4 (Inequality)	GeoTIFF	https://sedac.ciesin.columbia.edu/downloads/data/popdynamics/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01-proj-ssp4-geotiff.zip
# SSP5 (Fossil-fueled development)	GeoTIFF	https://sedac.ciesin.columbia.edu/downloads/data/popdynamics/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01-proj-ssp5-geotiff.zip


# https://sedac.ciesin.columbia.edu/data/set/popdynamics-1-8th-pop-base-year-projection-ssp-2000-2100-rev01/data-download

url <- "https://sedac.ciesin.columbia.edu/downloads/data/popdynamics/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01/popdynamics-1-km-downscaled-pop-base-year-projection-ssp-2000-2100-rev01-byr-geotiff.zip"
path <- "G:/My Drive/work/ciat/eia/analysis/input"
folder <- file.path(path, "sedac/popdynamics")
dir.create(folder, FALSE, FALSE)

zipf <- file.path(folder, basename(url))
if (!file.exists(zipf)) {
  utils::download.file(url, zipf, mode="wb")
}
