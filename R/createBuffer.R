# Function that creates a buffer, given a vector layer and a distance in meters
createBuffer <- function(layer,distance){
  
  # Create buffer
  buffer <- st_buffer(layer,distance)
  
  # Take union of the buffer to obtain singlepart polygon
  buffer <- st_union(buffer)
  
  return(buffer)
}