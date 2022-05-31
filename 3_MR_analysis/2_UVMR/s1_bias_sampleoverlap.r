 ################################################################
#  Descriptive: 
#    Mendelilan Randomization analysis based on the TwoSampleMR package, 
#    Based on R-4.0.0:
#    Computing bias and type 1 error rate due to sample overlapping between the GWAS of exposure and outcome
#    given PVE, number of IVs, and smaple size of exposure GWAS;
    
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

#We provide R code to implement the formulae for the estimation of bias under the
#null and Type 1 error rate. These formulae assume that
#there are multiple genetic variants; bias is a single genetic variant is unlikely to be
#substantial [Angrist and Pischke, 2009]. We assume that the units for the risk factor
#and outcome (for a continuous outcome) are the same for the ordinary least squares
#(OLS) and instrumental variable (IV) estimates; the simplest case is when all variables
#are in standard deviation units (so var_x and var_y are both 1).
#ref:  Bias due to participant overlap in two-sample Mendelian randomization

bias_TS <- function(exposure = "exp", outcome = "out", N = 100, K = 10, rsq = 0.02, olsbias = 0.2, overlap.prop = 0.5, var_x = 1, var_y = 1, binary = T, prop.case = 0.5){

  expf <- ((N - K - 1) / K) * (rsq / (1 - rsq)) # expf is expected value of the F statistic
  # N is sample size
  # K is number of genetic variants
  # rsq is the expected value of R^2
  # (otherwise expf can be specified directly)
  bias <- olsbias * overlap.prop * (1 / expf)
  # bias is the bias of the IV estimate under the null
  # olsbias is the bias of the OLS estimate (observational
  # estimate for binary outcome)
  # overlap.prop is the proportion of overlap
  # between the samples (between 0 and 1)
  
  if (binary == F) {
    var <- var_y / (N * var_x * rsq) # var is the variance of the IV estimate
    # (continuous outcome)
    # var_x is the variance of the risk factor
    # var_y is the variance of the outcome
    } else {
    var <- 1 / (N * rsq * var_x * prop.case * (1 - prop.case))
    # var is the variance of the IV estimate
    # (binary outcome)
    # prop.case is the proportion of cases (between 0 and 1)
    }
 
  type1err <- 2 - pnorm(1.96 + bias / sqrt(var)) - pnorm(1.96 - bias / sqrt(var))
  # type1err is the estimated Type 1 error rate
  # rate under the null for a nominal 5% two-sided
  # significance level

  bias_res <- data.frame(exposure = exposure, outcome = outcome, overlap.prop = overlap.prop, bias = bias, type1err = type1err)
  return(bias_res)

}

#example:
#  bias_TS(exposure = "scr", outcome = "covid", N = 344104, K = 702, rsq = 0.086, olsbias = log(1.03), overlap.prop = 0.338, var_x = 1, var_y = 1, binary = T, prop.case = 6492/(6492+1012809))