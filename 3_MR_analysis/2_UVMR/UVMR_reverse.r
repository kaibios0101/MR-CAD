################################################################
#  Descriptive: 
#    Mendelilan Randomization analysis based on the TwoSampleMR package, 
#    Based on R-4.0.0:
#    Harmonise and remove pleiotropy snps and output all results
#    This script is for standard TSMR analysis
#    
#  Author: 
#    kai wang
#
#  Date:
#    03/23/2022
#
#  Revised Author: Kai Wang
#
#  Revised data: 
#################################################################

##Usage: Rscript360 -F "[1.project dir] [2.e.name] [3.o.name] [4.meta] [5.IV.file.name] [6.o.sum_stats.file] [7.pleio.list] [8.n_iter] [9.mr.corr.b.prior] [10.n_iter_MRCorr]
#  [11.effective.smp.size.e] [12.binary.e] [13.prevalence.in.pop.e] [14.output.dir] [15.binary.o] [16.prop.smp.overlap] [17.prop.case.o]"

##clear the values and data
  rm(list = setdiff(ls(), lsf.str()))

##enable R to pass parameters
  args <- commandArgs(trailingOnly = TRUE)

##first rerun the follow R.script
  source("s1_forest_plot.r")
  source("s1_funnel_plot.r")
  source("s1_leave_one_out_plot.r")
  source("s1_scatter_plot.r")
  source("s1_PVE_binary.r")
  source("s1_PVE_quanti.r")
  source("s1_bias_sampleoverlap.r")

setwd(paste(args[1], args[2], "_", args[3], "/", args[4], sep = "")) #attention: need to check the populaiton of gwas sum_stats

##prepare packages
  library(TwoSampleMR)
  library(reshape)
  library(MRPRESSO)
  library(bootstrap)
  library(simex)
  library(ggplot2)
  library(devtools)
  library(BWMR)
  library(mr.raps)
  library(MR.Corr2);
##

#prepare data
  #step 1: prepare the exposure data
    exposure <- read.table(paste("/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/CAD_CAD/meta/", args[5], sep = ""), header = T, sep = "\t", stringsAsFactors = FALSE)
    #orienta to the positive direction
	      exposure$EAF <- 0.50 #after meta-analyzed CAD, we do not get the EAF info, and just revlaue as 0.50
        exposure$EA_c <- exposure$EA; exposure$NEA_c <- exposure$NEA
        exposure[ which(exposure$BETA < 0), "EA"] <-   exposure[ which(exposure$BETA < 0), "NEA_c"]      #effect allele
        exposure[ which(exposure$BETA < 0), "NEA"] <-   exposure[ which(exposure$BETA < 0), "EA_c"]      #non effect allele
        exposure[ which(exposure$BETA < 0), "EAF"] <-  1 - exposure[ which(exposure$BETA < 0), "EAF"]      #effect allele frequency
        exposure$BETA <- abs(exposure$BETA)  
        exposure <- exposure[, c("SNP", "EA", "NEA", "EAF", "BETA", "SE", "P")] # SNP CHR POS EA NEA EAF BETA SE P. need to check the EAF colunm before
    exposure <- rename(exposure, c( BETA = "beta", SE = "se", EA = "effect_allele", NEA = "other_allele", EAF = "eaf", P = "pval"))
    exposure_dat <- format_data(exposure, type = "exposure")
    exposure_dat$exposure <- args[3]
  
    exposure_dat_tmp <- exposure_dat
    print(paste("step 1: prepare the exposure data, input", nrow(exposure), "SNPs", ", the dim of exposure dataset is", dim(exposure)[1], dim(exposure)[2]))
  ##

  #step 2: prepare the outcome data by extract the summary statistics using above IVs information
    outcome_dat <- read_outcome_data(snps = exposure_dat_tmp$SNP, filename = args[6], sep = "\t", snp_col = "SNP",
                                     beta_col = "BETA", se_col = "SE", effect_allele_col = "EA", other_allele_col = "NEA", eaf_col = "EAF", pval_col = "P") 
    outcome_dat$outcome <- args[2]
    print(paste("step 2: prepare the outcome data by extract the summary statistics using above IVs information, leave", nrow(outcome_dat_tmp1), "SNPs", ", the dim of outcome_dat dataset is", dim(outcome_dat_tmp1)[1], dim(outcome_dat_tmp1)[2]))
  ##

  #step 3: remove potential pleiotropic SNPs which is genome-wide significant associated (<5E-8) with other risk factors
    list_func <- function(var = "Height", dat = dat_pleio){
      if (var %in% c("FG", "HbA1c", "T2D"))  dat1 <- dat[!(dat$Exposure %in% c("FG", "HbA1c", "T2D")), ]
      else if (var %in% c("HDL", "LDL", "TG"))  dat1 <- dat[!(dat$Exposure %in% c(var, "TC")), ]
      else if (var %in% c("TC")) dat1 <- dat[!(dat$Exposure %in% c(var, "HDL", "LDL", "TG")), ]
      else if (var %in% c("WBC")) dat1 <- dat[!(dat$Exposure %in% c(var, "Lym", "Mono", "Neutro", "Eosino", "Baso")), ]
      else if (var %in% c("Lym", "Mono", "Neutro", "Eosino", "Baso"))  dat1 <- dat[!(dat$Exposure %in% c(var, "WBC")), ]
      else if (var %in% c("RBC", "MCV", "MCH", "MCHC", "Hb", "Ht"))  dat1 <- dat[!(dat$Exposure %in% c("RBC", "MCV", "MCH", "MCHC", "Hb", "Ht")), ]
      else if (var %in% c("TP", "Alb"))  dat1 <- dat[!(dat$Exposure %in% c("TP", "Alb")), ]
      else dat1 <- dat[!(dat$Exposure %in% var), ]

      return(dat1)
    }
   
   dat_pleio <- read.table(paste(args[1], args[7], sep = ""), header = T)

   print(paste("the dim of pleiotropy snps is", dim(dat_pleio)[1], dim(dat_pleio)[2]))

   dat_pleio1 <- list_func(var = args[2], dat = dat_pleio)

   exposure_dat_tmp1 <- exposure_dat_tmp[!(exposure_dat_tmp$SNP %in% dat_pleio1$SNP), ]
   print(paste("step 3: remove potential pleiotropic SNPs which is genome-wide significant associated (<5E-8) with other risk factors in current study using the meta's dataset of risk factors, leave", nrow(exposure_dat_tmp1), "SNPs", ", the dim of exposure_dat_tmp1 dataset is", dim(exposure_dat_tmp1)[1], dim(exposure_dat_tmp1)[2]))
  ##

  #step 4: harmonise the exposure and outcome data
    e_o_dat <- harmonise_data(exposure_dat = exposure_dat_tmp1, outcome_dat = outcome_dat, action = 1)
    e_o_dat_clean <- e_o_dat[e_o_dat$mr_keep == "TRUE", ]
    print(paste("step 4: harmonise the exposure and outcome data, leave", nrow(e_o_dat_clean), "SNPs", ", the dim of e_o_dat_clean dataset is", dim(e_o_dat_clean)[1], dim(e_o_dat_clean)[2]))
  ##

  #step 5: MR PRESSO test
    if (nrow(e_o_dat_clean) > 5){

    #while loop
    
      #initial
        outlier_index <- "NA"
        e_o_dat_clean1 <- e_o_dat_clean
        
      #while loop
        while ( !is.na(outlier_index) ){
            
            mrpresso <- mr_presso(BetaOutcome = "beta.outcome", BetaExposure = "beta.exposure", SdOutcome = "se.outcome", SdExposure = "se.exposure", 
                                  OUTLIERtest = TRUE, DISTORTIONtest = TRUE, 
                                  data = e_o_dat_clean1, 
                                  NbDistribution = as.numeric(args[8]), 
                                  SignifThreshold = 0.05, 
                                  seed = 20190601)
            
            if (is.null(mrpresso$`MR-PRESSO results`$`Distortion Test`$`Outliers Indices`)) {
                outlier_index <- NA
            } else if (mrpresso$`MR-PRESSO results`$`Distortion Test`$`Outliers Indices` == "No significant outliers") {
                outlier_index <- NA
            } else {
                outlier_index <- row.names(mrpresso$`MR-PRESSO results`$`Outlier Test`[mrpresso$`MR-PRESSO results`$`Distortion Test`$`Outliers Indices`, ])
            }

            e_o_dat_clean1 <- e_o_dat_clean1[!(rownames(e_o_dat_clean1) %in% c(outlier_index)), ]  

        }

      #mark outlier SNP
        e_o_dat_clean$outlier <- "no";
        e_o_dat_clean$outlier[!(rownames(e_o_dat_clean) %in% rownames(e_o_dat_clean1))] <- "yes"                               

      print(paste("step 5: MR PRESSO test to detect outlier, found", nrow(e_o_dat_clean) - nrow(e_o_dat_clean1), "outlier SNPs, and left", nrow(e_o_dat_clean1), "SNPs", ", the dim of e_o_dat_clean1 dataset is", dim(e_o_dat_clean1)[1], dim(e_o_dat_clean1)[2]))

    } else {
       e_o_dat_clean$outlier <- "no";
       e_o_dat_clean1 <- e_o_dat_clean

      print(paste("step 5: MR PRESSO test to detect outlier, found 0 outlier SNPs, and left", nrow(e_o_dat_clean1), "SNPs", ", the dim of e_o_dat_clean1 dataset is", dim(e_o_dat_clean1)[1], dim(e_o_dat_clean1)[2]))
    }

    print("after these instruments selection process, we then use e_o_dat_clean1 dataset to conduct causal inference")
  ##
##

#MR-analysis 
  #1.PVE analysis
    if ( as.numeric(args[12]) == 1 ) {  #for binary exposure
        PVE_out <- func.Vg(data = e_o_dat_clean1, PA = "eaf.exposure", BETA = "beta.exposure", K = as.numeric(args[13])) #K, the prevalence of binary trait in population
        PVE   <- sum(PVE_out$Vg, na.rm = T)
    } else {
        PVE <- PVE_func_2(e_o_dat_clean1, scale = T, lambda = NA) #for quantitative exposure
    }
    PVE_F <- data.frame(heritability = PVE)    
    #output
    write.table(PVE_F, paste("result/", args[14], "/",  args[3], "_to_", args[2], ".csv", sep = ""), append = TRUE, row.names = F, col.names = T, quote = F, sep = ",")
  ##

  #2.overlap bias
    if ( as.numeric(args[15]) == 1 ) {
    #N, sample size of exposure GWAS; K, number of valid IVs
    tsmr_bias <- bias_TS(exposure = args[3], outcome = args[2], N = as.numeric(args[11]), K = nrow(e_o_dat_clean1), rsq = PVE, 
                         olsbias = e_o_mr[e_o_mr$method == "MR.Corr", ]$b, overlap.prop = as.numeric(args[16]), 
                         var_x = 1, var_y = NA, binary = T, prop.case = as.numeric(args[17]))
    } else {
    tsmr_bias <- bias_TS(exposure = args[3], outcome = args[2], N = as.numeric(args[11]), K = nrow(e_o_dat_clean1), rsq = PVE, 
                         olsbias = e_o_mr[e_o_mr$method == "MR.Corr", ]$b, overlap.prop = as.numeric(args[16]), 
                         var_x = 1, var_y = 1, binary = F, prop.case = NA)      
    }
    #output
    write.table(tsmr_bias, paste("result/", args[14], "/", args[3], "_to_", args[2], ".csv", sep = ""), append = TRUE, row.names = F, col.names = T, quote = F, sep = ",")
  ##

  #3.F statistics
    x <- e_o_dat_clean1$beta.exposure^2/e_o_dat_clean1$se.exposure^2 # x is the F statistics of SNPj  
    theta <- function(x) { mean( x ) } 
    boot_result <- bootstrap(x, 10000, theta)
    F_mean <- mean(boot_result$thetastar) 
    F_lower <- quantile(boot_result$thetastar, .025)
    F_upper <- quantile(boot_result$thetastar, .975)
    F_result <- data.frame(F_mean = F_mean, F_lower = F_lower, F_upper = F_upper)
    write.table(F_result, paste("result/", args[14], "/", args[3], "_to_", args[2], ".csv", sep = ""), append = TRUE, row.names = F, col.names =T, quote = F, sep = ",")
  ##

  #4.Cochran's Q heteriogeneity test
    het <- mr_heterogeneity(e_o_dat_clean1, method_list = c("mr_ivw"))
    write.table(het, paste("result/", args[14], "/", args[3], "_to_", args[2], ".csv", sep = ""), append = TRUE, row.names = F, col.names =T, quote = F, sep = ",")
  ##

  #5.IVW random effect, MR-Egger, Median test
    mr_result <- mr(e_o_dat_clean1, method_list = c("mr_egger_regression", "mr_ivw", "mr_weighted_median", "mr_weighted_mode")); 
		
  #6.BWMR test
    BWMR <- BWMR(e_o_dat_clean1$beta.exposure, e_o_dat_clean1$beta.outcome, e_o_dat_clean1$se.exposure, e_o_dat_clean1$se.outcome)
    BWMR_result <- data.frame(id.exposure = e_o_dat_clean1$id.exposure[1], id.outcome = e_o_dat_clean1$id.outcome[1], outcome = e_o_dat_clean1$outcome[1], exposure = e_o_dat_clean1$exposure[1], 
                              method = "BWMR", nsnp = length(e_o_dat_clean1$SNP), b = BWMR$beta, se = BWMR$se_beta, pval = BWMR$P_value)
    BWMR_result2 <- data.frame(beta = BWMR$beta, se = BWMR$se_beta, pval = BWMR$P_value)                         
    write.table(BWMR_result2, paste("result/", args[14], "/", args[3], "_to_", args[2], ".csv", sep = ""), append = TRUE, row.names = F, col.names =T, quote = F, sep = ",")
    mr_result <- rbind(mr_result, BWMR_result2)

  #7.MR-RAPS 
    raps_res <- mr.raps.simple.robust(b_exp = e_o_dat_clean1$beta.exposure, b_out = e_o_dat_clean1$beta.outcome, se_exp = e_o_dat_clean1$se.exposure, se_out = e_o_dat_clean1$se.outcome, loss.function = "huber")

    raps_res2 <- data.frame(id.exposure = mr_result$id.exposure[1], id.outcome = mr_result$id.outcome[1], outcome = mr_result$outcome[1], exposure = mr_result$exposure[1], 
                            method = "RAPS", nsnp = mr_result$nsnp[1], b = raps_res$beta.hat, se = raps_res$beta.se, pval = raps_res$beta.p.value)
    mr_result <- rbind(mr_result, raps_res2)

  #8.MR.Corr2 
    set.seed(20220218)
    opt = list(agm = 0.001, bgm = 0.001, aal = 0.001, bal = 0.001, a = 1, b = nrow(e_o_dat_clean1), maxIter = as.numeric(args[10]), thin = 10, burnin = 1000);
    ResIndep = MRcorr(e_o_dat_clean1$beta.exposure, e_o_dat_clean1$beta.outcome, e_o_dat_clean1$se.exposure, e_o_dat_clean1$se.outcome, opt)
                     
    ResIndep2 <- data.frame(id.exposure = mr_result$id.exposure[1], id.outcome = mr_result$id.outcome[1], outcome = mr_result$outcome[1], exposure = mr_result$exposure[1],
                            method = "MR.Corr", nsnp = mr_result$nsnp[1], b = mean(ResIndep$Beta0res), se = sd(ResIndep$Beta0res), pval = 2*(1 - pnorm(abs(mean(ResIndep$Beta0res)/sd(ResIndep$Beta0res)))))
    mr_result <- rbind(mr_result, ResIndep2)

    mr_result_1 <- generate_odds_ratios(mr_result)
    write.table(mr_result_1, paste("result/", args[14], "/", args[3], "_to_", args[2], ".csv", sep = ""), append = TRUE, row.names = F, col.names =T, quote = F, sep = ",")
  ##

  #9.combined all results
    mr_result$method <- as.character(mr_result$method)
    mr_result_plot <- mr_result
    mr_result_plot <- mr_result_plot[order(mr_result_plot$method), ]
    mr_result_plot$method <- gsub("Inverse variance weighted", "IVW", mr_result_plot$method)
    print(mr_result_plot)
    write.table(mr_result_plot, paste("result/", args[14], "/", args[3], "_to_", args[2], ".csv", sep = ""), append = TRUE, row.names = F, col.names =T, quote = F, sep = ",")
  ##
  
  #10.output the plot results
    #forest plot
      res_single <- mr_singlesnp(e_o_dat_clean1, all_method = c("mr_ivw"))
      mr_forest_plot(res_single, x_size = 12, y_size = 4)
      ggsave(paste0("result/", args[14], "/", args[2], "_to_", args[3], "_Forest_plot.pdf"), plot = last_plot(), width = 25, height = 25, units = "cm", device=cairo_pdf)

    #leave-one-out plot
      res_loo <- mr_leaveoneout(e_o_dat_clean1, method = mr_ivw)
      res_loo$SNP <- as.character(res_loo$SNP)
      res_loo[(res_loo$SNP == "All"), ]$SNP <- "All-IVW(mre)"
      mr_leaveoneout_plot(res_loo, x_size = 12, y_size = 4)
      ggsave(paste0("result/", args[14], "/", args[2], "_to_", args[3], "_Leave_one_out_plot.pdf"), plot = last_plot(), width = 25, height = 25, units = "cm", device=cairo_pdf)

    #scatter plot
      mr_scatter_plot_no_egger_nolegend(mr_result_plot, e_o_dat_clean1)
      ggsave(paste0("result/", args[14], "/", args[2], "_to_", args[3], "_Scatter_plot_nolegend.pdf"), plot = last_plot(), width = 30, height = 20, units = "cm", device=cairo_pdf)

    #funnel plot
      res_single <- mr_singlesnp(e_o_dat_clean1, all_method=c("mr_egger_regression", "mr_ivw", "mr_weighted_median", "mr_weighted_mode"));
      res_single <- rbind(res_single, 
                          data.frame(exposure = res_single$exposure[1], outcome = res_single$outcome[1], id.exposure = res_single$id.exposure[1], id.outcome = res_single$id.outcome[1], 
                                     samplesize = res_single$samplesize[1], SNP = "All - RAPS", b = raps_res$beta.hat, se = raps_res$beta.se, p = raps_res$beta.p.value))

      mr_funnel_plot_no_egger_nolegend(mr_result_plot, res_single)
      ggsave(paste0("result/", args[14], "/", args[2], "_to_", args[3], "_Funnel_plot_nolegend.pdf"), plot = last_plot(), width = 20, height = 20, units = "cm", device=cairo_pdf)
  ##  
##
