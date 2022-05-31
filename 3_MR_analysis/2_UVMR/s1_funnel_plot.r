################################################################
#  Descriptive: 
#    funnel plot
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

mr_funnel_plot <- function(mr_result_plot, singlesnp_results)
{
	requireNamespace("ggplot2", quietly=TRUE)
	requireNamespace("plyr", quietly=TRUE)
	res <- plyr::dlply(singlesnp_results, c("id.exposure", "id.outcome"), function(d)
	{
		d <- plyr::mutate(d)
		if(sum(!grepl("All", d$SNP)) < 2) {
			return(
				blank_plot("Insufficient number of SNPs")
			)
		}
		am <- grep("All", d$SNP, value=TRUE)
		d$SNP <- gsub("All - ", "", d$SNP)
		am <- gsub("All - ", "", am)
    mr_result_plot <- mr_result_plot[mr_result_plot$method != "MR Egger" & mr_result_plot$method != "MR Egger (SIMEX)" & mr_result_plot$method != "Weighted median" & mr_result_plot$method != "Weighted mode", ]
    mr_result_plot$method <- factor(mr_result_plot$method, levels = c("MR.Corr", "IVW", "MR PRESSO", "BWMR", "RAPS"), labels = c("MR.Corr", "IVW", "MR PRESSO", "BWMR", "RAPS"))

        
		ggplot2::ggplot(data = subset(d, ! SNP %in% am), aes(y = 1/se, x = b)) +
		ggplot2::geom_point(colour = "#107ab0", size = 3) +
    ggplot2::geom_vline(data = mr_result_plot, aes(xintercept = b, colour = method), show.legend = TRUE, size = 1) +
    ggplot2::labs(x = "", y = "") +
    ggplot2::scale_colour_manual(values = c("#AD002AFF", "#925E9FFF", "#FDAF91FF", "#00468BFF", "#0099B4FF", "#42B540FF", "#ED0000FF")) +
    ggplot2::theme(
            plot.margin = unit(c(0.3, 0.3, 0.3, 0.3), "inches"), 
            plot.title = element_text(size = 30, hjust = 0.5, vjust = 3),
            panel.background = element_rect(fill = "white"), 
            axis.title = element_text(size = 30),
            axis.title.x = element_text(vjust = -2),
            axis.title.y = element_text(vjust = 2),
            axis.line = element_line(colour = "black"), 
            axis.text = element_text(size = 25, colour = "black"), 
            legend.direction = "vertical", 
            legend.background = element_rect(colour = NA, fill = "white"), 
            legend.title = element_text(size = 16), 
            legend.text = element_text(size = 12), 
            legend.justification = c(1.00, 1.00), 
            legend.position = "none", 
            legend.key = element_rect( colour = "white", fill = "white"),
            legend.key.size = unit(0.3,"inches") )
	})
	res
}
