################################################################
#  Descriptive: 
#    Multivariable Mendelilan Randomization analysis 
#     Based on R-4.0.0:
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

##Usage: Rscript400 -F  "[1: project.dir] 
#                        [2: e1.name] 
#                        [3: o.name] 
#                        [4: e1.validIV.file] 
#                        [5: e2.name] 
#                        [6: e2.validIV.file] 
#                        [7: e3.name] 
#                        [8: e3.validIV.file] 
#                        [9:  e4.name] 
#                        [10: e4.validIV.file] 
#                        [11: e5.name] 
#                        [12: e5.validIV.file] 
#                        [13: e6.name] 
#                        [14: e6.validIV.file] 
#                        [15: LD.ref] 
#                        [16: pleiotropy.file]"
#                        [17: e1.sum_stats.file] 
#                        [18: e2.sum_stats.file] 
#                        [19: e3.sum_stats.file] 
#                        [20: e4.sum_stats.file] 
#                        [21: e5.sum_stats.file] 
#                        [22: e6.sum_stats.file] 
#                        [23: o.sum_stats.file] 
#                        [24: output.file]"
#                        [25: e1.SD.scale.parameter]"
#                        [26: e2.SD.scale.parameter]"
#                        [27: e3.SD.scale.parameter]"
#                        [28: e4.SD.scale.parameter]"
#                        [29: e5.SD.scale.parameter]"
#                        [30: e6.SD.scale.parameter]"

##clear the values and data
  rm(list = setdiff(ls(), lsf.str()))

##enable R to pass parameters
  args <- commandArgs(trailingOnly = TRUE)

  setwd(paste(args[1], sep = ""))  #attention: need to check the populaiton of gwas sum_stats
  source("s1_robustMVMR.r")

##prepare packages
  library(TwoSampleMR)
  library(reshape)
  library(simex)
  library(ggplot2)
  library(devtools)
  library(xtable)
  library(flextable)
  library(officer)
  library(MVMR)
  library(robustMVMR)
  library(MendelianRandomization)
  library(quantreg)
  library(MASS)
  library(robustbase)
  library(glmnet)
  library(openxlsx)
  library(scales)  
##

#data preparation  
  #step 1: prepare the initial IVs list
    e1_uvdat <- read.table(paste(args[2], "_", args[3], "/", args[4], sep = ""), header = T, sep = "\t", stringsAsFactors = FALSE)
    e1_uvdat_tmp <- e1_uvdat[, c("SNP", "EA", "NEA", "BETA", "SE", "P")]
    print(paste("step 1: prepare the exposure1", args[2], "data, input", nrow(e1_uvdat_tmp), "SNPs", ", the dim of exposure1 dataset is", dim(e1_uvdat_tmp)[1], dim(e1_uvdat_tmp)[2]))

    e2_uvdat <- read.table(paste(args[5], "_", args[3], "/", args[6], sep = ""), header = T, sep = "\t", stringsAsFactors = FALSE)
    e2_uvdat_tmp <- e2_uvdat[, c("SNP", "EA", "NEA", "BETA", "SE", "P")]
    print(paste("step 1: prepare the exposure2", args[5], "data, input", nrow(e2_uvdat_tmp), "SNPs", ", the dim of exposure2 dataset is", dim(e2_uvdat_tmp)[1], dim(e2_uvdat_tmp)[2]))

    e3_uvdat <- read.table(paste(args[7], "_", args[3], "/", args[8], sep = ""), header = T, sep = "\t", stringsAsFactors = FALSE)
    e3_uvdat_tmp <- e3_uvdat[, c("SNP", "EA", "NEA", "BETA", "SE", "P")]
    print(paste("step 1: prepare the exposure3", args[7], "data, input", nrow(e3_uvdat_tmp), "SNPs", ", the dim of exposure3 dataset is", dim(e3_uvdat_tmp)[1], dim(e3_uvdat_tmp)[2]))

    e4_uvdat <- read.table(paste(args[9], "_", args[3], "/", args[10], sep = ""), header = T, sep = "\t", stringsAsFactors = FALSE)
    e4_uvdat_tmp <- e4_uvdat[, c("SNP", "EA", "NEA", "BETA", "SE", "P")]
    print(paste("step 1: prepare the exposure4", args[9], "data, input", nrow(e4_uvdat_tmp), "SNPs", ", the dim of exposure4 dataset is", dim(e4_uvdat_tmp)[1], dim(e4_uvdat_tmp)[2]))

    e5_uvdat <- read.table(paste(args[11], "_", args[3], "/", args[12], sep = ""), header = T, sep = "\t", stringsAsFactors = FALSE)
    e5_uvdat_tmp <- e5_uvdat[, c("SNP", "EA", "NEA", "BETA", "SE", "P")]
    print(paste("step 1: prepare the exposure5", args[11], "data, input", nrow(e5_uvdat_tmp), "SNPs", ", the dim of exposure5 dataset is", dim(e5_uvdat_tmp)[1], dim(e5_uvdat_tmp)[2]))

    e6_uvdat <- read.table(paste(args[13], "_", args[3], "/", args[14], sep = ""), header = T, sep = "\t", stringsAsFactors = FALSE)
    e6_uvdat_tmp <- e6_uvdat[, c("SNP", "EA", "NEA", "BETA", "SE", "P")]
    print(paste("step 1: prepare the exposure6", args[13], "data, input", nrow(e6_uvdat_tmp), "SNPs", ", the dim of exposure6 dataset is", dim(e6_uvdat_tmp)[1], dim(e6_uvdat_tmp)[2]))

    e_uvdat <- rbind(e6_uvdat_tmp, e1_uvdat_tmp, e2_uvdat_tmp, e3_uvdat_tmp, e4_uvdat_tmp, e5_uvdat_tmp)
    #remove duplicated SNPs
    e_uvdat <- e_uvdat[!duplicated(e_uvdat$SNP), ]
    print(paste("step 1: prepare the initial IVs list from exposure1...6,", " total ", nrow(e_uvdat), " SNPs", ", the dim of e_uvdat dataset is", dim(e_uvdat)[1], dim(e_uvdat)[2]))
  ##

  #step 2: select independent (no LD) variants 
    ld_list <- subset(e_uvdat)
    ld_list[which(ld_list$SNP %in% e6_uvdat_tmp$SNP), ]$P <- 0
    names(ld_list)[ncol(ld_list)] <- "pval.exposure"

    e_uvdat_list <- clump_data(ld_list, clump_kb = 1000, clump_r2 = 0.01, clump_p1 = 1, clump_p2 = 1, pop = args[15])   
    #the full snps list for subsequently MV MR analysis
    e_uvdat1 <- subset(e_uvdat, SNP %in% e_uvdat_list$SNP)
    #leave SNPs
    print(paste("step 2: after select independent (no LD) variants for subsequently analysis, leaving", length(unique(e_uvdat1$SNP)), "SNPs"))

  #step 3: remove the pleiotropic snps
    list_func <- function(var = args[13], dat = dat_pleio){
        if (var %in% c(args[2], args[5], args[7], args[9], args[11], args[13]))  dat1 <- dat[!(dat$Exposure %in% c(args[2], args[5], args[7], args[9], args[11], args[13], "FG", "T2D", "TC")), ]
        return(dat1)
    }
    
    dat_pleio <- read.table(paste(args[1], "/", args[16], sep = ""), header = T)
    print(paste("the dim of pleiotropy snps is", dim(dat_pleio)[1], dim(dat_pleio)[2]))
    dat_pleio1 <- list_func(var = args[13], dat = dat_pleio)
    table(dat_pleio1$Exposure)

    e_uvdat2 <- e_uvdat1[!(e_uvdat1$SNP %in% dat_pleio1$SNP), ]
    print(paste("step 3: after remove the pleiotropic snps from other risk factors for subsequently analysis, leaving", length(unique(e_uvdat2$SNP)), "SNPs"))
  ##

  #step 4: select variants existed in the exposures' GWAS dataset
    #exposure 1
      e1_mvdat <- read_outcome_data(snps = unique(e_uvdat2$SNP), filename = args[17], sep = "\t", snp_col = "SNP",
                                    beta_col = "BETA", se_col = "SE", effect_allele_col = "EA", other_allele_col = "NEA", eaf_col = "EAF", pval_col = "P")   
      e1_mvdat$outcome <- args[2]
      #rescaled by the SDUKB/SDBBJ
        if (args[15] == "EAS"){
          e1_mvdat$beta.outcome <- e1_mvdat$beta.outcome / as.numeric(args[25])
          e1_mvdat$se.outcome   <- e1_mvdat$se.outcome   / as.numeric(args[25])
        } else {
          e1_mvdat$beta.outcome <- e1_mvdat$beta.outcome
          e1_mvdat$se.outcome   <- e1_mvdat$se.outcome 
        }
      ##      
    #leave SNPs
    print(paste("step 4: extract the pooled SNPs from exposure 1's GWAS summary dataset, obtained", nrow(e1_mvdat), "SNPs", ", the dim of e1_mvdat dataset is", dim(e1_mvdat)[1], dim(e1_mvdat)[2]))

    #exposure 2
      e2_mvdat <- read_outcome_data(snps = unique(e_uvdat2$SNP), filename = args[18], sep = "\t", snp_col = "SNP",
                                    beta_col = "BETA", se_col = "SE", effect_allele_col = "EA", other_allele_col = "NEA", eaf_col = "EAF", pval_col = "P")   
      e2_mvdat$outcome <- args[5]
      #rescaled by the SDUKB/SDBBJ
        if (args[15] == "EAS") {
          e2_mvdat$beta.outcome <- e2_mvdat$beta.outcome / as.numeric(args[26])
          e2_mvdat$se.outcome   <- e2_mvdat$se.outcome   / as.numeric(args[26])
        } else {
          e2_mvdat$beta.outcome <- e2_mvdat$beta.outcome
          e2_mvdat$se.outcome   <- e2_mvdat$se.outcome  
        }
      ##        
    #leave SNPs
    print(paste("step 4: extract the pooled SNPs from exposure 2's GWAS summary dataset, obtained", nrow(e2_mvdat), "SNPs", ", the dim of e2_mvdat dataset is", dim(e2_mvdat)[1], dim(e2_mvdat)[2]))

    #exposure 3
      e3_mvdat <- read_outcome_data(snps = unique(e_uvdat2$SNP), filename = args[19], sep = "\t", snp_col = "SNP",
                                    beta_col = "BETA", se_col = "SE", effect_allele_col = "EA", other_allele_col = "NEA", eaf_col = "EAF", pval_col = "P")   
      e3_mvdat$outcome <- args[7]
      #rescaled by the SDUKB/SDBBJ
        if (args[15] == "EAS") {
          e3_mvdat$beta.outcome <- e3_mvdat$beta.outcome / as.numeric(args[27])
          e3_mvdat$se.outcome   <- e3_mvdat$se.outcome   / as.numeric(args[27])
        } else {
          e3_mvdat$beta.outcome <- e3_mvdat$beta.outcome
          e3_mvdat$se.outcome   <- e3_mvdat$se.outcome  
        }
      ##       
    #leave SNPs
    print(paste("step 4: extract the pooled SNPs from exposure 3's GWAS summary dataset, obtained", nrow(e3_mvdat), "SNPs", ", the dim of e3_mvdat dataset is", dim(e3_mvdat)[1], dim(e3_mvdat)[2]))

    #exposure 4
      e4_mvdat <- read_outcome_data(snps = unique(e_uvdat2$SNP), filename = args[20], sep = "\t", snp_col = "SNP",
                                    beta_col = "BETA", se_col = "SE", effect_allele_col = "EA", other_allele_col = "NEA", eaf_col = "EAF", pval_col = "P")   
      e4_mvdat$outcome <- args[9]
      #rescaled by the SDUKB/SDBBJ
        if (args[15] == "EAS") {
          e4_mvdat$beta.outcome <- e4_mvdat$beta.outcome / as.numeric(args[28])
          e4_mvdat$se.outcome   <- e4_mvdat$se.outcome   / as.numeric(args[28])
        } else {
          e4_mvdat$beta.outcome <- e4_mvdat$beta.outcome
          e4_mvdat$se.outcome   <- e4_mvdat$se.outcome  
        }
      ##           
    #leave SNPs
    print(paste("step 4: extract the pooled SNPs from exposure 4's GWAS summary dataset, obtained", nrow(e4_mvdat), "SNPs", ", the dim of e4_mvdat dataset is", dim(e4_mvdat)[1], dim(e4_mvdat)[2]))

    #exposure 5
      e5_mvdat <- read_outcome_data(snps = unique(e_uvdat2$SNP), filename = args[21], sep = "\t", snp_col = "SNP",
                                    beta_col = "BETA", se_col = "SE", effect_allele_col = "EA", other_allele_col = "NEA", eaf_col = "EAF", pval_col = "P")   
      e5_mvdat$outcome <- args[11]
      #rescaled by the SDUKB/SDBBJ
        if (args[15] == "EAS") {
          e5_mvdat$beta.outcome <- e5_mvdat$beta.outcome / as.numeric(args[29])
          e5_mvdat$se.outcome   <- e5_mvdat$se.outcome   / as.numeric(args[29])
        } else {
          e5_mvdat$beta.outcome <- e5_mvdat$beta.outcome
          e5_mvdat$se.outcome   <- e5_mvdat$se.outcome  
        }
      ##       
    #leave SNPs
    print(paste("step 4: extract the pooled SNPs from exposure 5's GWAS summary dataset, obtained", nrow(e5_mvdat), "SNPs", ", the dim of e5_mvdat dataset is", dim(e5_mvdat)[1], dim(e5_mvdat)[2]))

    #exposure 6: primary exposure 
      e6_mvdat <- read_outcome_data(snps = unique(e_uvdat2$SNP), filename = args[22], sep = "\t", snp_col = "SNP",
                                    beta_col = "BETA", se_col = "SE", effect_allele_col = "EA", other_allele_col = "NEA", eaf_col = "EAF", pval_col = "P")
      e6_mvdat$outcome <- args[13]
      names(e6_mvdat) <- gsub("outcome", "exposure", names(e6_mvdat))
      #rescaled by the SDUKB/SDBBJ
        if (args[15] == "EAS") {
          e6_mvdat$beta.exposure <- e6_mvdat$beta.exposure / as.numeric(args[30])
          e6_mvdat$se.exposure   <- e6_mvdat$se.exposure   / as.numeric(args[30])
        } else {
          e6_mvdat$beta.exposure <- e6_mvdat$beta.exposure
          e6_mvdat$se.exposure   <- e6_mvdat$se.exposure  
        }
      ##  

      #orienta to the positive direction for the primary exposure: as suggested by Andrew J. Grant
        e6_mvdat$effect_allele.exposure_c <- e6_mvdat$effect_allele.exposure; e6_mvdat$other_allele.exposure_c <- e6_mvdat$other_allele.exposure
        e6_mvdat[ which(e6_mvdat$beta.exposure < 0), "effect_allele.exposure"] <-   e6_mvdat[ which(e6_mvdat$beta.exposure < 0), "other_allele.exposure_c"]      #effect allele
        e6_mvdat[ which(e6_mvdat$beta.exposure < 0), "other_allele.exposure"]  <-   e6_mvdat[ which(e6_mvdat$beta.exposure < 0), "effect_allele.exposure_c"]      #non effect allele
        e6_mvdat[ which(e6_mvdat$beta.exposure < 0), "eaf.exposure"]           <-   1 - e6_mvdat[ which(e6_mvdat$beta.exposure < 0), "eaf.exposure"]      #effect allele frequency
        e6_mvdat$beta.exposure <- abs(e6_mvdat$beta.exposure)  
        e6_mvdat <- e6_mvdat[, c(1:12)] # SNP EA NEA EAF BETA SE P...... need to check the EAF colunm before
    #leave SNPs
    print(paste("step 4: extract the pooled SNPs from exposure 6's GWAS summary dataset, obtained", nrow(e6_mvdat), "SNPs", ", the dim of e6_mvdat dataset is", dim(e6_mvdat)[1], dim(e6_mvdat)[2]))
    
    #intersection: keep the shared variants among these exposures
      inter_list <- Reduce(intersect, list(e1_mvdat$SNP, e2_mvdat$SNP, e3_mvdat$SNP, e4_mvdat$SNP, e5_mvdat$SNP, e6_mvdat$SNP))
    ##
    print(paste("step 4: extract the shared SNPs from exposure1...6's GWAS summary dataset, totally obtained", length(inter_list), "SNPs"))
  ##

  #step 5: harmonises snps to be all on the same strand
    e1_e5_mvdat <- rbind(subset(e1_mvdat, SNP %in% inter_list), subset(e2_mvdat, SNP %in% inter_list), subset(e3_mvdat, SNP %in% inter_list), 
                         subset(e4_mvdat, SNP %in% inter_list), subset(e5_mvdat, SNP %in% inter_list))

	  e_mvdat_h <- harmonise_data(e6_mvdat, e1_e5_mvdat, action = 1)
    print(paste("step 5: after harmonises snps (exposure 1 & .. & 5) to be all on the same strand, leaving", length(unique(e_mvdat_h$SNP)), "SNPs", ", the dim of e_mvdat_h dataset is", dim(e_mvdat_h)[1], dim(e_mvdat_h)[2]))
  ##

  #step 6: format the exposures' dataset
    e_mvdat_h1 <- subset(e_mvdat_h, id.outcome == id.outcome[1], select = c(SNP, exposure, id.exposure, effect_allele.exposure, other_allele.exposure, eaf.exposure, beta.exposure, se.exposure, pval.exposure))
    e_mvdat_h2 <- subset(e_mvdat_h, select = c(SNP, outcome, id.outcome, effect_allele.outcome, other_allele.outcome, eaf.outcome, beta.outcome, se.outcome, pval.outcome))
    names(e_mvdat_h2) <- gsub("outcome", "exposure", names(e_mvdat_h2))
    e_mvdat_h_qc <- rbind(e_mvdat_h1, e_mvdat_h2)

    e_mvdat_h_qc[e_mvdat_h_qc$exposure == args[2], ]$id.exposure <- args[2]
    e_mvdat_h_qc[e_mvdat_h_qc$exposure == args[5], ]$id.exposure <- args[5]
    e_mvdat_h_qc[e_mvdat_h_qc$exposure == args[7], ]$id.exposure <- args[7]
    e_mvdat_h_qc[e_mvdat_h_qc$exposure == args[9], ]$id.exposure <- args[9]
    e_mvdat_h_qc[e_mvdat_h_qc$exposure == args[11], ]$id.exposure <- args[11]
    e_mvdat_h_qc[e_mvdat_h_qc$exposure == args[13], ]$id.exposure <- args[13]

    e_mvdat_h_qc$id.exposure <- factor(e_mvdat_h_qc$id.exposure, levels = c(args[2], args[5], args[7], args[9], args[11], args[13]), labels = c(args[2], args[5], args[7], args[9], args[11], args[13]))
    print(paste("step 6: after format exposures (exposure 1 & .. & 6) for subsequently analysis, leaving", length(unique(e_mvdat_h_qc$SNP)), "SNPs", ", the dim of e_mvdat_h_qc dataset is", dim(e_mvdat_h_qc)[1], dim(e_mvdat_h_qc)[2]))
  ##

  #step 7: select the variants existed in the outcome' GWAS dataset 
    outcome_mvdat <- read_outcome_data(snps = unique(e_mvdat_h_qc$SNP), filename = args[23], sep = "\t", snp_col = "SNP",
                                       beta_col = "BETA", se_col = "SE", effect_allele_col = "EA", other_allele_col = "NEA", eaf_col = "EAF", pval_col = "P")  
    outcome_mvdat$outcome <-  args[3]
    #leave SNPs
    e_mvdat_h_qc_2 <- e_mvdat_h_qc[(e_mvdat_h_qc$SNP %in% outcome_mvdat$SNP), ]
    print(paste("step 7: after select variants existed in the outcome's GWAS dataset for subsequently analysis, leaving", length(unique(e_mvdat_h_qc_2$SNP)), "SNPs"))
  ##

  #step 8: harmonise the exposure and outcome data
    mvdat <- mv_harmonise_data(exposure_dat = e_mvdat_h_qc_2, outcome_dat = outcome_mvdat, harmonise_strictness = 1)
    #leave SNPs
    print(paste("step 8: harmonise the exposure and outcome data, we then conduct MVMR analysis on the formated dataset, including", dim(mvdat$exposure_beta)[1], "SNPs"))
  ##
##

#MVMR analysis
  #step 9: multivariable MR analysis 
    #based on robustMVMR
      #format data
        mvdat2 <- format_mvmr(BXGs = mvdat$exposure_beta, BYG = mvdat$outcome_beta, seBXGs = mvdat$exposure_se, seBYG = mvdat$outcome_se)
        rob_dat <- mvdat2
        rob_dat <- matrix(unlist(mvdat2), nrow(mvdat2))
        dimnames(rob_dat) <- list(c(1:nrow(rob_dat)), c("SNP", "beta.Y", "sebeta.Y", "beta.e1", "beta.e2", "beta.e3", "beta.e4", "beta.e5", "beta.e6",  
                                                                                     "sebeta.e1", "sebeta.e2", "sebeta.e3", "sebeta.e4", "sebeta.e5", "sebeta.e6"))

        pvalue.Y <- 5e-8; pvalue.e1 <- 5e-8; pvalue.e2 <- 5e-8; pvalue.e3 <- 5e-8; pvalue.e4 <- 5e-8; pvalue.e5 <- 5e-8; pvalue.e6 <- 5e-8; 
        rob_dat1 <- cbind(rob_dat, pvalue.Y, pvalue.e1, pvalue.e2, pvalue.e3, pvalue.e4, pvalue.e5, pvalue.e6)

        betaGY <- rob_dat1[, "beta.Y"]; sebetaGY <- rob_dat1[, "sebeta.Y"]; pvalbetaGY <- rob_dat1[,"pvalue.Y"]
        
        betaGX <- rob_dat1[, c("beta.e1", "beta.e2", "beta.e3", "beta.e4", "beta.e5", "beta.e6")]; 
        sebetaGX <- rob_dat1[, c("sebeta.e1", "sebeta.e2", "sebeta.e3", "sebeta.e4", "sebeta.e5", "sebeta.e6")]; 
        pvalbetaGX <- rob_dat1[, c("pvalue.e1", "pvalue.e2", "pvalue.e3", "pvalue.e4", "pvalue.e5", "pvalue.e6")]

      #estimate effect size
        robMVMR <- robustMVMR(betaGY = betaGY, sebetaGY = sebetaGY, pvalbetaGY = pvalbetaGY,
                              betaGX = betaGX, sebetaGX = sebetaGX, pvalbetaGX = pvalbetaGX,
                              pval_threshold = 1, plot = FALSE)

      #output all result
        #robustMVMR
          robmv_res_out1 <- subset(as.data.frame(robMVMR$mvMRResult_heter_robust), select = c(Index, betaXY, sebetaXY, PvalbetaXY))
          robmv_res_out1$betaXY <- formatC(robmv_res_out1$betaXY, format = 'f', digits = 4)
          robmv_res_out1$sebetaXY <- formatC(robmv_res_out1$sebetaXY, format = 'f', digits = 4)
          robmv_res_out1$PvalbetaXY <- formatC(robmv_res_out1$PvalbetaXY, format = 'e', digits = 2)
          names(robmv_res_out1)[2:4] <- c("Beta", "SE", "P")
          robmv_res_out1$Exposure <- c(args[2], args[5], args[7], args[9], args[11], args[13])
          robmv_res_out1$Method <- "Based on Grant (MVMR-Robust)"
          robmv_res_out1 <- subset(robmv_res_out1, select = c(Method, Index, Exposure, Beta, SE, P))
        write.table(robmv_res_out1, args[24], append = TRUE, row.names = F, col.names = T, quote = F, sep = ",")
      #
    ##
  
    #conditional F statistics
      if (args[15] == "EAS"){
          cor.exposure <- load("s1_phenotype.corrlation.eas.1575.Rdata")
      } else if (args[15] == "EUR") {
          cor.exposure <- load("s1_phenotype.corrlation.eur.472671.Rdata")
      }
      corr <- corr[row.names(corr) %in% c(args[2], args[5], args[7], args[9], args[11], args[13]), row.names(corr) %in% c(args[2], args[5], args[7], args[9], args[11], args[13])]
      print(corr)
      
      cov.exposure <- phenocov_mvmr(corr, mvdat2[, c("sebetaX1", "sebetaX2", "sebetaX3", "sebetaX4", "sebetaX5", "sebetaX6")])

      f_data <- format_mvmr(BXGs = mvdat2[, c("betaX1", "betaX2", "betaX3", "betaX4", "betaX5", "betaX6")],
                            BYG = mvdat2[, c("betaYG")],
                            seBXGs = mvdat2[, c("sebetaX1", "sebetaX2", "sebetaX3", "sebetaX4", "sebetaX5", "sebetaX6")],
                            seBYG = mvdat2[, c("sebetaYG")],
                            RSID = row.names(mvdat2))
      f_condi <- strength_mvmr(r_input = f_data, gencov = cov.exposure)
      write.table(f_condi, args[24], append = TRUE, row.names = F, col.names = T, quote = F, sep = ",")
    ##  
  ##
##
