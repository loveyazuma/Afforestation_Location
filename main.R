# Source external functions
source('R/createBuffer.R')

# Load sf library
library('sf')

# Create data folder if not yet existent
if (!dir.exists('data')) {
  dir.create('data')
}
# Create output folder if not yet existent
if (!dir.exists('output')) {
  dir.create('output')
}

# Download data to data folder if not yet present
if (!file.exists('data/data.zip')) {
  download.file(url = 'https://www.dropbox.com/sh/4n2ifcpg0wy766e/AADYNljpqwZWngzucgsoSYt1a?dl=1', destfile = 'data/data.zip', method = 'auto')
  unzip('data/data.zip', exdir = 'data')
}

# Load shapefiles
landcover = st_read(dsn = 'data/MS_land_cover.geojson')
roads = st_read(dsn = 'data/MS_roads.geojson')

# Create 10 km buffer around Nature reserves
nature_buffer <- createBuffer(landcover[landcover$lc_string == 'Nature reserve',], 10000)

# Create 8 km buffer around Croplands
cropland_buffer <- createBuffer(landcover[landcover$lc_string == 'Cropland',], 8000)

# Create 5 km buffer around Roads
road_buffer <- createBuffer(roads, 5000)

# Exclude road and croplands buffer from nature reserve buffer
nature_road_diff <- st_difference(nature_buffer, road_buffer)
nature_road_crop_diff <- st_difference(nature_road_diff, cropland_buffer)

# Find intersection with abandoned agricultural fields
afforestation_area <- st_intersection(nature_road_crop_diff, landcover[landcover$lc_string == 'Abandoned field', 'geometry'])

# Calculate the optimal afforestation area in km^2, with no decimals
opt_area <- round(st_area(afforestation_area) / 10^6, 0)

# Save the afforestation area as shapefile to output folder
if (!file.exists('output/afforestation_area.geojson')){
  st_write(afforestation_area, dsn = 'output/afforestation_area.geojson')
}

# Bonus: Plot the final output on top of the Mato Grosso state map. Export as png. 
par(mfrow=c(1,1))

png(filename="output/afforestation_map.png", width=800, height=500)

plot(st_geometry(st_transform(landcover,crs=4326)), main="State of Mato Grosso", col="black", axes=TRUE)
plot(st_transform(afforestation_area,crs=4326), add=T, col="green")
legend("left", fill="green", legend="Optimal area\n for afforestation\n (2710km²)",
       bty="n", ncol = 3)

dev.off()
