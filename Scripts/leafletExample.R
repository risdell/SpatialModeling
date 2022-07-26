library(leaflet)

plot_map <- function(df, minLong, minLat, maxLong, maxLat){
  
  m <- leaflet(data = df) %>% 
    addTiles(
      urlTemplate="https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png"
    ) %>% 
    addMarkers(
      lng = ~long,
      lat = ~lat) %>%
    addScaleBar( options = scaleBarOptions(
      imperial=FALSE)) %>%
    fitBounds(minLong-.5, minLat, maxLong+.5, maxLat)
  
  return(m)
}

dat <- read.csv("./Data/leaflet-eg.csv", header=TRUE)

dat

map <- plot_map(dat, 
                min(dat$long), 
                min(dat$lat), 
                max(dat$long), 
                max(dat$lat))

map
