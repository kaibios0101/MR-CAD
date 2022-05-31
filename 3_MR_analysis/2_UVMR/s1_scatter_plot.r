################################################################
#  Descriptive: 
#    Scatter plot
#    
#  Author: 
#    kai wang
#
#  Date:
#    03/23/2022
#
#  Revised Author:
#
#  Date:
#
#  Revised data: 
#################################################################

mr_scatter_plot <- function(mr_result_plot, dat)
{
	# dat <- subset(dat, paste(id.outcome, id.exposure) %in% paste(mr_result_plot$id.outcome, mr_result_plot$id.exposure))
	requireNamespace("ggplot2", quietly=TRUE)
	requireNamespace("plyr", quietly=TRUE)
	mrres <- plyr::dlply(dat, c("id.exposure", "id.outcome"), function(d)
	{
		d <- plyr::mutate(d)
		if(nrow(d) < 2 | sum(d$mr_keep) == 0)
		{
			return(blank_plot("Insufficient number of SNPs"))
		}
		d <- subset(d, mr_keep)
		index <- d$beta.exposure < 0
		d$beta.exposure[index] <- d$beta.exposure[index] * -1
		d$beta.outcome[index] <- d$beta.outcome[index] * -1
		mrres <- subset(mr_result_plot, id.exposure == d$id.exposure[1] & id.outcome == d$id.outcome[1])
		mrres$a <- 0
		
	#annotation info
		#MR.Corr results
			MR.Corr.b  <- formatC(mr_result_plot[mr_result_plot$method == "MR.Corr", ]$b,  format = 'f', digits = 2)
                        MR.Corr.se <- formatC(mr_result_plot[mr_result_plot$method == "MR.Corr", ]$se, format = 'f', digits = 2)


			if (mr_result_plot[mr_result_plot$method == "MR.Corr", ]$pval >= 1e-2 ) 
			{
				MR.Corr.pval <- paste("= ", formatC(mr_result_plot[mr_result_plot$method == "MR.Corr", ]$pval, format = 'f', digits = 3), sep = "")
			} else {
		         	MR.Corr.pval <- paste("= ", formatC(mr_result_plot[mr_result_plot$method == "MR.Corr", ]$pval, format = 'e', digits = 2), sep = "")
			}
		
	#MR results
	  mrres <- mrres[mrres$method != "MR Egger" & mrres$method != "MR Egger (SIMEX)" & mrres$method != "Weighted median" & mrres$method != "Weighted mode", ]
    mrres$method <- factor(mrres$method, levels = c("MR.Corr", "IVW", "BWMR", "RAPS"), labels = c("MR.Corr", "IVW", "BWMR", "RAPS"))

			ggplot2::ggplot(data = d, aes(x = beta.exposure, y = beta.outcome)) +
			ggplot2::geom_errorbarh(data = d, aes(xmin = beta.exposure - se.exposure, xmax = beta.exposure + se.exposure), colour = "#107ab0", height = 0, size = 0.6, alpha = 0.5) +
			ggplot2::geom_errorbar(data = d, aes(ymin = beta.outcome - se.outcome, ymax = beta.outcome + se.outcome), colour = "#107ab0", width = 0, size = 0.6, alpha = 0.5) +
			ggplot2::geom_point(data = d, aes(text = paste("SNP:", SNP)), colour = "#107ab0", size = 3) +
      ggplot2::scale_colour_manual(values = c("#AD002AFF", "#925E9FFF", "#FDAF91FF", "#00468BFF", "#0099B4FF", "#42B540FF", "#ED0000FF")) +
			ggplot2::geom_abline(data = mrres, aes(intercept = a, slope = b, colour = method), show.legend = TRUE, size = 1.2) +
			ggplot2::geom_abline(aes(intercept = 0, slope = 0), colour = "black", show.legend = F, size = 0.8, alpha = 0.5) +
			ggplot2::labs(colour = "MR method", x = "", y = "") +
			ggplot2::theme(
                plot.margin = unit(c(0.3, 0.3, 0.3, 0.3), "inches"), 
                panel.background = element_rect(fill = "white"), 
                                              axis.title = element_text(size = 25),
                                              axis.title.x = element_text(vjust = -2),
                                              axis.title.y = element_text(vjust = 2),
                                              axis.text = element_text(size = 20, colour = "black"), 
                axis.line = element_line(colour = "black"), 
                legend.direction = "vertical", 
                legend.background = element_rect(colour = NA, fill = "white"), 
                legend.justification = c(0.98, 0.98), 
                legend.position = "none", 
                legend.title = element_text(size = 16), 
                legend.text = element_text(size = 12), 
                legend.key = element_rect( colour = "white", fill = "white"),
                                legend.key.size = unit(0.3, "inches") ) +
			ggplot2::guides(colour = guide_legend(ncol = 1))

	})
	mrres
}
