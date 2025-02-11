# Import packages
#library(sf)

# Load functions
#source("owg.R")

# Define your experimental design
# Inputs: Three different shapes: "parabolic" (full space), "circle" or "square" 
#         + set center and radius values if the shape is a circle or a square
# Output: Simple feature (sf) object representing the shape 
defED <- function(shape, 
                  center = c(0.5, 0.5), 
                  radius = 0.2) {
  
  # Parabola
  x = seq(0, 1, length.out = 10000)
  y = 4 * x * (1 - x)
  
  parab = cbind(x, y)
  parab = rbind(parab, parab[1, ]) # Close the parabola
  
  # Convert to Simple Feature (sf)
  parab_sf = st_sfc(st_polygon(list(parab)), crs = 27572)
  
  # If not parabolic
  if (shape != "parabolic") { 
    
    # Circle
    if (shape == "circle") {
      # Create a point at the center
      center_point = st_sfc(st_point(center), crs = 27572)
      # Create a buffer around the point
      pol = st_buffer(center_point, dist = radius)
    }
    
    # Square
    if (shape == "square") {
      X = center[1]
      Y = center[2]
      # Define coordinates of the square
      coor = matrix(c(X - radius, Y - radius, X - radius, Y + radius, 
                      X + radius, Y + radius, X + radius, Y - radius, 
                      X - radius, Y - radius), ncol = 2, byrow = TRUE)
      pol = st_sfc(st_polygon(list(coor)), crs = 27572)
    }
    
    # Intersection of the shape with the parabola  
    int = st_intersection(parab_sf, pol)
    
    # NA if the shape is outside the parabola
    if (length(int) == 0) {
      #print("The shape is outside the parabolic decision-strategy space")
      return(NA)
    } else {
      return(int)
    }
  } else {
    return(parab_sf)
  }
}

# Generate your experimental design
# Inputs: Number of simulations nbsim (i.e. sample size)
#         + a Simple Feature (sf) object pol representing a shape within the decision-strategy space
# Output: Matrix of nbsim couple of risk and tradeoff values drawn at random within the shape
genED <- function(nbsim, pol) {
  # Random sampling within the polygon
  ech = st_sample(pol, nbsim, type = "random")
  ech = st_coordinates(ech)
  colnames(ech) = c("Risk", "Tradeoff")   
  
  return(ech)
}

# Choose the number of criteria
# Inputs: Number of weights + a matrix of risk and tradeoff values
# Output: Matrix of risk and tradeoff values + their associated weights 
ED <- function(nbcrit, data) {
  
  data[, 1] = round(data[, 1], digits = 5)
  data[, 2] = round(data[, 2], digits = 5)
  nsim = dim(data)[1]
  
  # Generate the weights for each couple of risk and tradeoff values with owg
  res = NULL
  for (i in 1:nsim) {
    owgi = owg(nbcrit, data[i, 1], data[i, 2], warn = FALSE)
    if (owgi$Suitable) {
      res = rbind(res, owgi$Weights)
    } else { # If not suitable, compute a new couple of risk and tradeoff based on 10 other values
      test = owgi$Suitable
      count = 0
      while (!test & count < 1000) {
        datai = apply(data[sample(nsim, 10, replace = TRUE), ], 2, mean)
        owgi = owg(nbcrit, datai[1], datai[2], warn = FALSE)
        
        test = owgi$Suitable
        count = count + 1                   
      }
      res = rbind(res, owgi$Weights)            
    }
  }
  
  res = cbind(data, res)
  res = res[!is.na(res[, 3]), ]
  colnames(res) = c("Risk", "Tradeoff", paste("W_", 1:nbcrit, sep = ""))
  
  return(res)
}
