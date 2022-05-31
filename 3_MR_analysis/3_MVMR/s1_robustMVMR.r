#' Perform the robust multivariable Mendelian randomization analysis
#'
#' @description The \pkg{robustMVMR} perform the robust multivariable Mendelian
#'     randomization ('robustMVMR') analysis in the two-sample MR setting based on the
#'     MM-estimator.The conventional multivariable Mendelian randomization (MVMR) estimate
#'     the causal effect by employing the weighted least square estimators, in
#'     which the inverse variance of the SNPs-outcome association is arbitrarily
#'     selected as the weights with an additional assumption about the
#'     heteroskedastic error. When all the instrument assumptions of MVMR are
#'     satisfied; that is,
#'     \itemize{
#'       \item{the variant is associated with at least 1 of the risk factor;}
#'       \item{the variant is not associated with a confounder of any of the
#'                  risk-outcome associations;}
#'       \item{the variant is conditionally independent of the outcome given
#'                  the risk factors and confounders;}
#'       \item{the variants are required to be independent;}
#'       \item{the heteroskedastic error;}
#'       \item{the linearity and homogeneity of all associations.}
#'     }
#'
#'     Violation of any one of the aforementioned assumptions can cause severe
#'     bias in MVMR. The \pkg{robustMVMR} produces the robust causal effect and
#'     robust standard errors based on the MM-estimates, which has been demonstrated
#'     to protect against the heteroskedasticity, autocorrelation, and the
#'     presence of outliers.The interested reader is referred to Yohai (1987) paper
#'     and Crousx et al (2004) paper. In MR setting, outliers of the multi-instruments
#'     may indicate the horizontal pleiotropic effect, which has been comprehensively
#'     discussed in Verbnck et al (2018)[www.nature.com/articles/s41588-018-0099-7]
#'     in univariable MR setting.
#'
#'     Notable, the assumption of heteroskedastic error in MVMR setting has a
#'     key role in estimating the causal effect and its standard error. However,
#'     recent advances suggest that the estimated effect derived from the conventional
#'     MVMR may be biased, especially when the exposures are highly correlated and
#'     the correlation matrix of these exposures is unknown. And, such scenarios often
#'     happen in the MVMR setting, especially when the multiple independent
#'     instruments are clumped by using the 1000 Genome Project as the reference.
#'     Furthermore, the function of these selected variants are not fully understood;
#'     that is, the horizontal pleiotropy (or outliers) may also arise. The
#'     results from Verbank et al (2018) paper reported that almost half
#'     (around 48\%) of significant causal relationship in MR suffered from the
#'     horizontal pleiotropy. The effect of the horizontal pleiotropy on the
#'     "true" causal estimates ranged from -131\% to 201\%, with a false-positive
#'     rate of 10\%. In such a case, the \pkg{robustMVMR} would provide better
#'     estimates and standard errors of the causal effect than those in the
#'     conventional MVMR.
#'
#'     Furthermore, the overall conditional F-statistic for testing conditional weak
#'     instrument bias and the modified Q-statistic for testing the instrument
#'     validity in the multivariable Mendelian randomization proposed by
#'     Sanderson et al. (2020) are also provided in \pkg{robustMVMR}. Along with
#'      the overall conditional F-statistic, a pairwise conditional F-statistic
#'     matrix is also provided to identify the possible source of conditional
#'     weak instrument bias.
#'
#'     Lastly, the data-driven result about the correlation matrix of exposure
#'     is also reported in \pkg{robustMVMR}. Such a matrix is derived from the
#'     standard error of each exposure under the heteroskedasticity assumption. The
#'     further using of this matrix should be cautious.
#'
#'     An example paper using \pkg{robustMVMR} can be found here:
#'     Yang et al. (2021) Genetic evidence on the association of interleukin
#'     (IL)-1-mediated chronic inflammation with airflow obstruction: A Mendelian
#'     randomization study. COPD: Journal of Chronic Obstructive
#'     Pulmonary Disease. <doi:10.1080/15412555.2021.1955848>.
#'
#' @param betaGY A numeric vector of the beta-coefficient for the SNPs-outcome associations.
#'                  For the binary outcome, the log-odds ratio estimates from the
#'                  logistic regression analysis are strongly recommended.
#' @param sebetaGY The numeric vector of the standard errors for the SNPs-outcome associations.
#' @param pvalbetaGY The numeric vector of P values for the SNPs-outcome associations.
#' @param betaGX A matrix of the beta-coefficient for the SNPs-exposures associations.
#' @param sebetaGX The matrix of the standard error for the SNPs-exposure associations.
#' @param pvalbetaGX The matrix of P values for the SNPs-exposure associations.
#' @param pval_threshold The threshold of the P value for selecting the genetic variants for exposures.
#'                         By default, \code{pval_threshold = 1e-05}.
#' @param plot The option for return the scatter plot with the marginal effect of each exposure.
#'               By default, \code{plot = FALSE}.
#'
#' @importFrom lmtest bptest
#' @import "ggplot2","stats","robustbase"
#'
#' @seealso \code{\link[lmtest]{bptest}} and \code{\link[robustbase]{lmrob}}
#'
#' @references
#' \itemize{
#'   \item{1. Yohai, V.J. (1987) High breakdown-point and high efficiency robust estimates for regression. \strong{The Annals of Statistics}, pp.642-656.}
#'   \item{2. Croux, C., Dhaene, G. and Hoorelbeke, D. (2004) Robust standard errors for robust estimators. \strong{CES-Discussion paper series (DPS) 03.16}, pp.1-20.}
#'   \item{3. Verbanck, M., Chen, C.Y., Neale, B. and Do, R. (2018) Detection of widespread horizontal pleiotropy in causal relationships inferred from Mendelian randomization between complex traits and diseases. \strong{Nature genetics}, 50(5), pp.693-698.}
#'   \item{4. Sanderson, E., Davey Smith, G., Windmeijer, F. and Bowden, J. (2019) An examination of multivariable Mendelian randomization in the single-sample and two-sample summary data settings. \strong{International journal of epidemiology}, 48(3), pp.713-727.}
#'   \item{5. Yang, Z., Schooling, C.M., and Kwok, M.K. (2021) Genetic evidence on the association of interleukin (IL)-1-mediated chronic inflammation with airflow obstruction: A Mendelian randomization study. \strong{COPD: Journal of Chronic Obstructive Pulmonary Disease}. doi:10.1080/15412555.2021.1955848.}
#' }
#'
#' @return A list contains nine components, including
#'     \describe{
#'       \item{Breusch_Pagen_test}{The \strong{Breusch Pagen test} for the heteroskedasticity assumption. Rejecting the NULL hypothesis indicate the violation of the heteroskedastic error.}
#'       \item{mvMRResult_homo_robust}{The results from the robust multivariable Mendelian randomization with the weights being 1.}
#'       \item{mvMRResult_heter_burgess}{The results from the conventional MVMR analysis with the weights being \code{1/sebetaGY^2}.}
#'       \item{mvMRResult_heter_robust}{The results from the robust multivariable Mendelian randomization with the weights being \code{1/sebetaGY^2}. Of these, the conditional F-statistic is also reported.}
#'       \item{marginalEffect}{The results from the robust univariable Mendelian randomization based on the validity instruments with the weights being \code{1/sebetaGY^2}.}
#'       \item{Conditional_F_statistic_matrix}{The pair-wise conditional F-statistics of exposures included in the robust MVMR analysis.}
#'       \item{Q_pleiotropy_test}{The modified Q-statistic for testing the instrument validity used in the robust MVMR analysis.}
#'       \item{rho_Exposures}{The correlation matrix of exposures included in the robust MVMR analysis. \strong{It is worth noting that this is a data-driven result.}}
#'       \item{plots}{The scatter plot of the marginal effect of each exposure on the outcome.}
#'     }
#'
#' @examples
#' data(IL1_LUSC)
#' ## -- SNP-outcome data
#' betaGY <-  IL1_LUSC[,"beta.LUSC"]
#' sebetaGY <- IL1_LUSC[,"sebeta.LUSC"]
#' pvalbetaGY <- IL1_LUSC[,"pval.LUSC"]
#' ## -- SNP-exposure data
#' betaGX <- IL1_LUSC[,c("beta.IL1A_Sun", "beta.IL1B_Ahola", "beta.IL1RA_Ahola")]
#' sebetaGX <- IL1_LUSC[,c("se.IL1A_Sun", "se.IL1B_Ahola", "se.IL1RA_Ahola")]
#' pvalbetaGX <- IL1_LUSC[,c("pval.IL1A_Sun", "pval.IL1B_Ahola", "pval.IL1RA_Ahola")]
#' ## -- Robust MVMR
#' fit <- robustMVMR(betaGY = betaGY, sebetaGY = sebetaGY, pvalbetaGY = pvalbetaGY,
#'                   betaGX = betaGX, sebetaGX = sebetaGX, pvalbetaGX = pvalbetaGX,
#'                   pval_threshold = 1e-05, plot = FALSE)
#' ## -- Main results of the robust MVMR
#' fit$mvMRResult_heter_robust
#' ## -- The modified Q-statistic for testing instrument validity
#' fit$Q_pleiotropy_test
#' ## -- The pair-wise conditional F-statistic matrix
#' fit$Conditional_F_statistic_matrix
#' ## -- The correlation matrix of the exposures
#' fit$rho_Exposures
#'
#' @export
#'
robustMVMR <- function(betaGY, sebetaGY, pvalbetaGY,
                       betaGX, sebetaGX, pvalbetaGX,
                       pval_threshold = 1e-05,
                       plot = FALSE) {

    out <- outLCI <- outUCI <- exp <- expLCI <- expUCI <- NULL
    control_init <- lmrob.control(k.max = 10000)

    ## -- Breusch Pagen test for heteroskedasticity
    bpTest <- lmtest::bptest(lm(betaGY ~ betaGX - 1))
    Breusch_Pagen <- bpTest$statistic
    pvalBreusch_Pagen <- bpTest$p.value
    datBPT <- data.frame(Breusch_Pagen = Breusch_Pagen,
                         pvalBreusch_Pagen = pvalBreusch_Pagen)

    ## -- Using the robust linear regression analysis via robustbase::lmrob() with
    ## -- an assumption about the homoscedastic error.
    reg_homo_robust <- robustbase::lmrob(betaGY ~ betaGX - 1, control = control_init)
    pointRes_homo_robust <- summary(reg_homo_robust)$coefficients[, 1]
    seRes_homo_robust <- summary(reg_homo_robust)$coefficients[, 2]
    Index <- colnames(betaGX)
    # Index <- substr(Index, 6, nchar(Index))
    Wald_homo_robust <- pointRes_homo_robust/seRes_homo_robust
    pval_homo_robust <- pnorm(-abs(Wald_homo_robust)) * 2
    ## -- Obtain the result
    datRes_homo_robust <- data.frame(Index = c(Index),
                                     betaXY = c(pointRes_homo_robust),
                                     sebetaXY = c(seRes_homo_robust),
                                     WaldbetaXY = c(Wald_homo_robust),
                                     PvalbetaXY = c(pval_homo_robust))

    ## -- The conventional MVMR method proposed by Burgess.
    reg_heter_se <- lm(betaGY ~ betaGX - 1, weights = 1 / sebetaGY ^ 2)
    pointRes_heter_se <- summary(reg_heter_se)$coefficients[, 1]
    seRes_heter_se <- summary(reg_heter_se)$coefficients[, 2]
    sigmaRes_heter_se <- summary(reg_heter_se)$sigma
    if (nrow(betaGX) >= 3) {
        seResModified_heter_se <- seRes_heter_se / min(1, sigmaRes_heter_se)
    } else {
        seResModified_heter_se <- seRes_heter_se / sigmaRes_heter_se
    }
    Index <- colnames(betaGX)
    # Index <- substr(Index, 6, nchar(Index))
    Wald_heter_se <- pointRes_heter_se/seResModified_heter_se
    pval_heter_se <- pnorm(-1 * abs(Wald_heter_se)) * 2
    ## -- Obtain the results
    datRes_heter_se <- data.frame(Index = c(Index),
                                  betaXY = c(pointRes_heter_se),
                                  sebetaXY = c(seResModified_heter_se),
                                  WaldbetaXY = c(Wald_heter_se),
                                  PvalbetaXY = c(pval_heter_se))

    ## -- Robust linear regression analysis via robustbase::lmrob()
    reg_heter_robust <- robustbase::lmrob(betaGY ~ betaGX - 1, weights = 1 / sebetaGY ^ 2, control = control_init)
    pointRes_heter_robust <- summary(reg_heter_robust)$coefficients[, 1]
    # if (nrow(betaGX) >= 3) {
    #   seRes_heter_robust <- summary(reg_heter_robust)$coefficients[, 2]/min(1,summary(reg_heter_robust)$sigma)
    # } else {
    seRes_heter_robust <- summary(reg_heter_robust)$coefficients[, 2]/summary(reg_heter_robust)$sigma
    # }
    Index_heter_robust <- colnames(betaGX)
    # Index_heter_robust <- substr(Index_heter_robust, 6, nchar(Index_heter_robust))
    Wald_heter_robust <- pointRes_heter_robust/seRes_heter_robust
    pval_heter_robust <- pnorm(-1 * abs(Wald_heter_robust)) * 2
    ## -- Obtain the result
    datRes_heter_robust <- data.frame(Index = c(Index_heter_robust),
                                      betaXY = c(pointRes_heter_robust),
                                      sebetaXY = c(seRes_heter_robust),
                                      WaldbetaXY = c(Wald_heter_robust),
                                      PvalbetaXY = c(pval_heter_robust))

    betaXYSB <- function(fit) {
        res <- as.data.frame(fit)
        res$betaXYLCI <- res$betaXY - 1.96 * res$sebetaXY
        res$betaXYUCI <- res$betaXY + 1.96 * res$sebetaXY
        return(res)
    }
    datRes_homo_robustNew <- betaXYSB(fit = datRes_homo_robust)
    datRes_heter_seNew <- betaXYSB(fit = datRes_heter_se)
    datRes_heter_robustNew <- betaXYSB(fit = datRes_heter_robust)


    ## -- Correlation between exposures or the estimated coefficients
    rho <- summary(reg_heter_robust, correlation = TRUE, complete = FALSE)$correlation
    # cov2cor(vcov(reg_heter_robust))
    attr(rho, "eigen") <- NULL
    attr(rho, "weights") <- NULL

    ## -- Heterogeneity test for instrument validity (pleiotropy): QA formula (13)
    ## -- Reference. Sanderson et al. Int J Epidemiol, 2019; 48(3): 713-727.
    ## -- Assume that the correlation between the exposures is 0.
    weight <- sebetaGY^2 + sebetaGX^2 %*% matrix(pointRes_heter_robust^2, ncol = 1)
    Q_pleiotropy_test <- sum((betaGY - reg_heter_robust$fitted.values)^2/weight)
    ## -- Post-hoc analysis by using the correlation derived from the robust
    ## --   weighted linear regression model.
    if ((dim(betaGX)[1] - 2) > 0) {
        pvalue_Q_pleiotropy_test <- pchisq(Q_pleiotropy_test,
                                           df = dim(betaGX)[1] - 2,
                                           lower.tail = FALSE)
    } else {
        pvalue_Q_pleiotropy_test <- pnorm(sqrt(Q_pleiotropy_test),
                                          lower.tail = FALSE)*2
    }
    datQPt <- data.frame(Q_pleiotropy_test = c(Q_pleiotropy_test),
                         pvalQ_pleiotropy_test = c(pvalue_Q_pleiotropy_test))


    ## -- Heterogeneity test for instrument strength: QX formula (12)
    nameList <- colnames(betaGX)
    if (is.null(nameList)) {
        nameList <- paste("X", 1:ncol(betaGX), sep  ="")
        colnames(betaGX) <- nameList
    }
    ## -- Pairwise conditional F-statistic
    Q_instrument_strength_matrix <- matrix(NA, nrow = ncol(betaGX), ncol = ncol(betaGX))
    colnames(Q_instrument_strength_matrix) <- paste(nameList, "->", sep = "")
    rownames(Q_instrument_strength_matrix) <- paste(nameList, sep = "")
    for (iQx in 1:length(nameList)) {
        betaGYNew <- betaGX[, colnames(betaGX) %in% nameList[iQx]]
        sebetaGYNew <- sebetaGX[, colnames(betaGX) %in% nameList[iQx]]
        if (iQx < length(nameList)) {
            for (jQx in (iQx + 1):length(nameList)) {
                betaGXNew <- betaGX[, colnames(betaGX) %in% nameList[jQx]]
                sebetaGXNew <- sebetaGX[, colnames(betaGX) %in% nameList[jQx]]

                ## X -> Y
                fitReg1 <- lm(betaGYNew ~ betaGXNew - 1)
                QXY <- sum( (betaGYNew - coefficients(fitReg1)*betaGXNew)^2 / (sebetaGYNew^2 + coefficients(fitReg1)^2*sebetaGXNew^2) ) / (nrow(betaGX) - 1)
                Q_instrument_strength_matrix[iQx, jQx] <- round(QXY,2)

                ## Y -> X
                fitReg2 <- lm(betaGXNew ~ betaGYNew - 1)
                QYX <- sum( (betaGXNew - coefficients(fitReg2)*betaGYNew)^2 / (sebetaGYNew^2 + coefficients(fitReg1)^2*sebetaGXNew^2) ) / (nrow(betaGX) - 1)
                Q_instrument_strength_matrix[jQx, iQx] <- round(QYX,2)
            }
        }
    }
    ## -- Overall conditional F-statistic when the number of exposures is larger
    ## --   than 2 using the robust weighted linear regression
    ## -- Reference: Formula (4) and (7). Sanderson et al. Testing and correcting
    ## --   or weak and pleiotropic instruments two-sample multivariable Mendelian
    ## --   randomization. 2020; bioRxiv.
    Q_instrument_strength <-  NULL
    if (length(nameList) > 2) {
        for (iQx2 in 1:length(nameList)) {
            betaGYNew2 <- betaGX[, colnames(betaGX) %in% nameList[iQx2]]
            sebetaGYNew2 <- sebetaGX[, colnames(betaGX) %in% nameList[iQx2]]
            betaGXNew2 <- betaGX[, !colnames(betaGX) %in% nameList[iQx2]]
            sebetaGXNew2 <- sebetaGX[, !colnames(betaGX) %in% nameList[iQx2]]

            fitReg3 <- robustbase::lmrob(betaGYNew2 ~ betaGXNew2 - 1, weights = 1/sebetaGYNew2^2, control = control_init)
            QXY2 <- sum( (betaGYNew2 - betaGXNew2 %*% matrix(coefficients(fitReg3), ncol = 1))^2 / (sebetaGYNew2^2 + sebetaGXNew2^2 %*% matrix(coefficients(fitReg3)^2, ncol = 1)) ) / (nrow(betaGX) - ncol(betaGX) + 1)
            Q_instrument_strength <- c(Q_instrument_strength, QXY2)
        }
    } else if (length(nameList) == 2) {
        iQx2 <- 1
        betaGYNew2 <- betaGX[, colnames(betaGX) %in% nameList[iQx2]]
        sebetaGYNew2 <- sebetaGX[, colnames(betaGX) %in% nameList[iQx2]]
        betaGXNew2 <- betaGX[, !colnames(betaGX) %in% nameList[iQx2]]
        sebetaGXNew2 <- sebetaGX[, !colnames(betaGX) %in% nameList[iQx2]]

        ## X -> Y
        fitReg4 <- lm(betaGYNew2 ~ betaGXNew2 - 1)
        QXY3 <- sum( (betaGYNew2 - coefficients(fitReg4)*betaGXNew2)^2 / (sebetaGYNew2^2 + coefficients(fitReg4)^2*sebetaGXNew2^2) ) / (nrow(betaGX) - 1)
        Q_instrument_strength <- c(Q_instrument_strength, QXY3)

        ## Y -> X
        fitReg5 <- lm(betaGXNew2 ~ betaGYNew2 - 1)
        QYX4 <- sum( (betaGXNew2 - coefficients(fitReg5)*betaGYNew2)^2 / (sebetaGYNew2^2 + coefficients(fitReg5)^2*sebetaGXNew2^2) ) / (nrow(betaGX) - 1)
        Q_instrument_strength <- c(Q_instrument_strength, QYX4)
    }
    datQ_instrument_strength <- data.frame(
        Index = nameList,
        cond_F_stat = Q_instrument_strength
    )
    datQ_instrument_strength$Index <- as.character(datQ_instrument_strength$Index)

    ## ------ Sensitivity analysis of MVMR Egger regression
    MVMREgger_homo_robust <- MVMREgger_heter_burgess <- MVMREgger_heter_robust <- data.frame()
    for (iMVMREgger in 1:length(nameList)) {
        betaGXNew <- betaGX
        betaGYNew <- betaGY
        idx <- betaGX[,iMVMREgger] < 0
        betaGYNew[idx] <- -betaGY[idx]
        betaGXNew[idx, iMVMREgger] <- -betaGX[idx, iMVMREgger]
        betaGXNew[idx,-iMVMREgger] <- -betaGX[idx,-iMVMREgger]

        ## -- Multivarable Egger regression with an assumption about the homoscedastic error
        summary_homo_robust <- summary(robustbase::lmrob(betaGYNew ~ betaGXNew, control = control_init))
        thetaEgger_homo_robust <- summary_homo_robust$coef[1,1]
        thetaEggerse_homo_robust <- summary_homo_robust$coef[1,2]/summary_homo_robust$sigma
        pvalue_homo_robust <- 2*pnorm(-abs(thetaEgger_homo_robust/thetaEggerse_homo_robust))
        datTmp8 <- data.frame(Index = nameList[iMVMREgger],
                              MVMREgger_beta = thetaEgger_homo_robust,
                              MVMREgger_sebeta = thetaEggerse_homo_robust,
                              MVMREgger_pval = pvalue_homo_robust)
        MVMREgger_homo_robust <- rbind(MVMREgger_homo_robust, datTmp8)

        ## -- Multivariable Egger regression
        summary_heter_se <- summary(robustbase::lmrob(betaGYNew ~ betaGXNew, weights = 1 / sebetaGY ^ 2, control = control_init))
        thetaEgger_heter_se <- summary_heter_se$coef[1,1]
        if (nrow(betaGX) >= 3) {
            thetaEggerse_heter_se <- summary_heter_se$coef[1,2]/min(1,summary_heter_se$sigma)
        } else {
            thetaEggerse_heter_se <- summary_heter_se$coef[1,2]/summary_heter_se$sigma
        }
        pvalue_heter_se <- 2*pnorm(-abs(thetaEgger_heter_se/thetaEggerse_heter_se))
        datTmp9 <- data.frame(Index = nameList[iMVMREgger],
                              MVMREgger_beta = thetaEgger_heter_se,
                              MVMREgger_sebeta = thetaEggerse_heter_se,
                              MVMREgger_pval = pvalue_heter_se)
        MVMREgger_heter_burgess <- rbind(MVMREgger_heter_burgess, datTmp9)

        ## -- Multivariable Egger regression
        summary_heter_robust <- summary(robustbase::lmrob(betaGYNew ~ betaGXNew, weights = 1 / sebetaGY ^ 2, control = control_init))
        thetaEgger_heter_robust <- summary_heter_robust$coef[1,1]
        if (nrow(betaGX) >= 3) {
            thetaEggerse_heter_robust <- summary_heter_robust$coef[1,2]/min(1,summary_heter_robust$sigma)
        } else {
            thetaEggerse_heter_robust <- summary_heter_robust$coef[1,2]/summary_heter_robust$sigma
        }
        pvalue_heter_robust <- 2*pnorm(-abs(thetaEgger_heter_robust/thetaEggerse_heter_robust))
        datTmp10 <- data.frame(Index = nameList[iMVMREgger],
                               MVMREgger_beta = thetaEgger_heter_robust,
                               MVMREgger_sebeta = thetaEggerse_heter_robust,
                               MVMREgger_pval = pvalue_heter_robust)
        MVMREgger_heter_robust <- rbind(MVMREgger_heter_robust, datTmp10)
    }
    MVMREgger_homo_robust$Index <- as.character(MVMREgger_homo_robust$Index)
    MVMREgger_heter_burgess$Index <- as.character(MVMREgger_heter_burgess$Index)
    MVMREgger_heter_robust$Index <- as.character(MVMREgger_heter_robust$Index)
    datRes_homo_robustNew$Index <- as.character(datRes_homo_robustNew$Index)
    datRes_homo_robustNew <- merge(datRes_homo_robustNew, MVMREgger_homo_robust,
                                    by = "Index", all.x = TRUE)

    datRes_heter_seNew$Index <- as.character(datRes_heter_seNew$Index)
    datRes_heter_seNew <- merge(datRes_heter_seNew, MVMREgger_heter_burgess,
                                by = "Index", all.x = TRUE)

    datRes_heter_robustNew$Index <- as.character(datRes_heter_robustNew$Index)
    datRes_heter_robustNewTmp <- merge(datRes_heter_robustNew, MVMREgger_heter_robust,
                                    by = "Index", all.x = TRUE)
    datRes_heter_robustNewNew <- merge(datRes_heter_robustNewTmp, datQ_instrument_strength,
                                    by = "Index", all.x = TRUE)


    ## Plot of marginal SNPs effect on the outcome
    effList <- nsnpList <- seList <- pvalList <- NULL
    p <- list()
    for (iExp in 1:length(nameList)) {
        ## Obtain the subset of SNPs for each exposure
        pvalbetaGXNew <- pvalbetaGX[,colnames(betaGX) %in% nameList[iExp]]
        idxExp <- (pvalbetaGXNew <= pval_threshold)
        betaGXNew <- betaGX[idxExp, colnames(betaGX) %in% nameList[iExp]]
        sebetaGXNew <- sebetaGX[idxExp, colnames(betaGX) %in% nameList[iExp]]
        betaGYNew <- betaGY[idxExp]
        sebetaGYNew <- sebetaGY[idxExp]

        ## Conduct the marginal weighted linear regression analysis
        lmFit <- summary(robustbase::lmrob(betaGYNew ~ betaGXNew - 1, weights = 1/sebetaGYNew^2, control = control_init))
        eff <- lmFit$coefficients[,1]
        effList <- c(effList, eff)
        nsnp <- length(betaGXNew)
        nsnpList <- c(nsnpList, nsnp)
        # if(nsnp >= 3) {
        #   se  <- lmFit$coefficients[,2]/min(1,lmFit$sigma)
        # } else {
        se  <- lmFit$coefficients[,2]/lmFit$sigma
        # }
        seList <- c(seList, se)
        pval <- 2*pnorm(-abs(eff/se))
        pvalList <- c(pvalList, pval)

        flip <- (betaGXNew <= 0)
        betaGXNew[flip] <- -1 * betaGXNew[flip]
        betaGYNew[flip] <- -1 * betaGYNew[flip]
        da <- data.frame(exp = betaGXNew,
                         expLCI = betaGXNew - 1.96*sebetaGXNew,
                         expUCI = betaGXNew + 1.96*sebetaGXNew,
                         out = betaGYNew,
                         outLCI = betaGYNew - 1.96*sebetaGYNew,
                         outUCI = betaGYNew + 1.96*sebetaGYNew)
        xmin <- min(da$expLCI) - 0.1
        xmax <- max(da$expUCI) + 0.1
        ymin <- min(da$outLCI) - 0.1
        ymax <- max(da$outUCI) + 0.1
        p[[iExp]] <- ggplot2::ggplot(data = da, ggplot2::aes(x = exp, y = out)) +
            ggplot2::theme_classic() +
            ggplot2::geom_point() +
            ggplot2::geom_linerange(ggplot2::aes(ymin = outLCI, ymax = outUCI)) +
            ggplot2::geom_errorbarh(ggplot2::aes(xmin = expLCI, xmax = expUCI, height = 0)) +
            ggplot2::geom_abline(intercept = 0, slope = eff, color = "blue", size = 1.2) +
            ggplot2::geom_hline(yintercept = 0, color = "gray") +
            ggplot2::geom_vline(xintercept = 0, color = "gray") +
            ggplot2::scale_x_continuous(limits = c(xmin, xmax), expand = c(0,0)) +
            ggplot2::scale_y_continuous(limits = c(ymin, ymax), expand = c(0,0)) +
            ggplot2::labs(x = paste("SNP effect on ", gsub("beta.", "", nameList[iExp]), sep = ""),
                          y = "Robust marginal SNP effect on outcome (WLSE)", sep = "")
    }

    marginalEffect_heter_robust <- data.frame(
        Index = as.character(Index),
        nSNP = nsnpList,
        betaXY = effList,
        sebetaXY = seList,
        pval = pvalList,
        betaXYLCI = effList - 1.96*seList,
        betaXYUCI = effList + 1.96*seList
    )

    if (plot) {
        return(list(Breusch_Pagen_test = datBPT,
                    mvMRResult_homo_robust = datRes_homo_robustNew,
                    mvMRResult_heter_burgess = datRes_heter_seNew,
                    mvMRResult_heter_robust = datRes_heter_robustNewNew,
                    marginalEffect_heter_robust = marginalEffect_heter_robust,
                    Conditional_F_statistic_matrix = Q_instrument_strength_matrix,
                    Q_pleiotropy_test = datQPt,
                    rho_Exposures = rho,
                    plots = p))
    } else {
        return(list(Breusch_Pagen_test = datBPT,
                    mvMRResult_homo_robust = datRes_homo_robustNew,
                    mvMRResult_heter_burgess = datRes_heter_seNew,
                    mvMRResult_heter_robust = datRes_heter_robustNewNew,
                    marginalEffect_heter_robust = marginalEffect_heter_robust,
                    Conditional_F_statistic_matrix = Q_instrument_strength_matrix,
                    Q_pleiotropy_test = datQPt,
                    rho_Exposures = rho))
    }

}