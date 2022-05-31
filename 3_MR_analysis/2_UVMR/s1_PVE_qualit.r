################################################################
#  Descriptive: 
#    Based on R-4.0.0:
#    Computing proportion of variance in phenotype explained by a
#    given SNP (PVE);
#    
#  Author: 
#    kai wang
#
#  Date:
#    03/23/2022
#
#  Revised Author:
#
#  Revised data:
#################################################################

#ref: Genetic Architecture of Complex Traits and Disease Risk Predictors; Genome-wide Association Study for Vitamin D Levels Reveals 69 Independent Loci
PVE_func_2 <- function(mr_data, scale = T, lambda = NA)
{ 
  if (scale == T){
    PVE <- 2*mr_data$beta.exposure*mr_data$beta.exposure*mr_data$eaf.exposure*(1 - mr_data$eaf.exposure) 
  } else {
    PVE <- 2*mr_data$beta.exposure*mr_data$beta.exposure*mr_data$eaf.exposure*(1 - mr_data$eaf.exposure)/lambda 
  }
  PVE_sum <- sum(PVE, na.rm = TRUE)
  print(PVE)
  print(PVE_sum)
  return(PVE_sum)
  
}
