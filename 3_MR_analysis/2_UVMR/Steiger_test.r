
#clear the values and data
  rm(list = setdiff(ls(), lsf.str()))
  setwd("/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB")
#prepare packages
  library(TwoSampleMR)
  library(devtools)
  library(openxlsx)
##

#Hb and CAD
 dir_func1 <- function(exp = "Hb"; out = "CAD"; exp.n = 108794; out.n = 29319 + 183134; pop = "EAS"){
    dat <- read.csv(paste(exp, "_", out, "/meta/result/ld_1e-1_r_5e2/", pop, ".P5e-2.v16.1/IVs_for_", exp, "_to_", out, ".csv", sep = ""))
    dat$samplesize.exposure <- exp.n
    dat$samplesize.outcome <- out.n 
    dat$r.exposure <- get_r_from_pn(dat$pval.exposure, dat$samplesize.exposure)
    dat$r.outcome <- get_r_from_lor(lor = dat$beta.outcome, af = dat$eaf.outcome, 
                                    ncase = 29319, ncontrol = 183134, prevalence = 0.0524)

    dir <- directionality_test(dat)   
    return(dir)  
 }

 dir_func1 <- function(exp = "Hb"; out = "CAD"; exp.n = 350474; out.n = 91753 + 311344; pop = "EUR"){
    dat <- read.csv(paste(exp, "_", out, "/meta/result/ld_1e-1_r_5e2/", pop, ".P5e-2.v16.1/IVs_for_", exp, "_to_", out, ".csv", sep = ""))
    dat$samplesize.exposure <- exp.n
    dat$samplesize.outcome <- out.n 
    dat$r.exposure <- get_r_from_pn(dat$pval.exposure, dat$samplesize.exposure)
    dat$r.outcome <- get_r_from_lor(lor = dat$beta.outcome, af = dat$eaf.outcome, 
                                    ncase = 91753, ncontrol = 311344, prevalence = 0.0677)    
    dir <- directionality_test(dat)   
    return(dir)  
 }

 dir_func2 <- function(exp = "CAD"; out = "Hb"; exp.n = 29319 + 183134; out.n = 108794; pop = "EAS"){
    dat <- read.csv(paste(out, "_", exp, "/meta/result/ld_1e-1_r_5e2/", pop, ".P5e-2.v18.1.reverse/IVs_for_", exp, "_to_", out, ".csv", sep = ""))
    dat$samplesize.exposure <- exp.n
    dat$samplesize.outcome <- out.n 
    dat$r.exposure <- get_r_from_lor(lor = dat$beta.exposure, af = dat$eaf.exposure, 
                                    ncase = 29319, ncontrol = 183134, prevalence = 0.0524)    
    dat$r.outcome <- get_r_from_pn(dat$pval.outcome, dat$samplesize.outcome)

    dir <- directionality_test(dat)   
    return(dir)  
 }

 dir_func2 <- function(exp = "CAD"; out = "Hb"; exp.n = 91753 + 311344; out.n = 350474; pop = "EUR"){
    dat <- read.csv(paste(out, "_", exp, "/meta/result/ld_1e-1_r_5e2/", pop, ".P5e-2.v18.1.reverse/IVs_for_", exp, "_to_", out, ".csv", sep = ""))
    dat$samplesize.exposure <- exp.n
    dat$samplesize.outcome <- out.n 
    dat$r.exposure <- get_r_from_lor(lor = dat$beta.exposure, af = dat$eaf.exposure, 
                                    ncase = 91753, ncontrol = 311344, prevalence = 0.0677)    
    dat$r.outcome <- get_r_from_pn(dat$pval.outcome, dat$samplesize.outcome)

    dir <- directionality_test(dat)   
    return(dir)  
 }