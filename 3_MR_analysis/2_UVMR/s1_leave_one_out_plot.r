################################################################
#  Descriptive: 
#    leave one out plot
#
#  Author: 
#    kai wang
#
#  Date:
#    03/22/2022
#
#  Revised Author:
#
#  Revised data:
#################################################################

mr_leaveoneout_plot <- function(leaveoneout_results, x_size, y_size)
{
	requireNamespace("ggplot2", quietly=TRUE)
	requireNamespace("plyr", quietly=TRUE)
	res <- plyr::dlply(leaveoneout_results, c("id.exposure", "id.outcome"), function(d)
	{
		d <- plyr::mutate(d)
		# Need to have at least 3 SNPs because IVW etc methods can't be performed with fewer than 2 SNPs
		if(sum(!grepl("All-IVW(mre)", d$SNP)) < 3) {
			return(
				blank_plot("Insufficient number of SNPs")
			)
		}
		d$up <- d$b + 1.96 * d$se
		d$lo <- d$b - 1.96 * d$se
		d$tot <- 1
		d$tot[d$SNP != "All-IVW(mre)"] <- 0.01
		d$SNP <- as.character(d$SNP)
		nom <- d$SNP[d$SNP != "All-IVW(mre)"]
		nom <- nom[order(d$b)]
		d <- rbind(d, d[nrow(d),])
		d$SNP[nrow(d)-1] <- ""
		d$b[nrow(d)-1] <- NA
		d$up[nrow(d)-1] <- NA
		d$lo[nrow(d)-1] <- NA
		d$SNP <- ordered(d$SNP, levels = c("All-IVW(mre)", "", nom))

		ggplot2::ggplot(data = d, aes(x = b, y = SNP)) +
		ggplot2::geom_point(aes(colour = as.factor(tot))) +
		ggplot2::geom_vline(xintercept = 0, linetype = "dotted") +
		ggplot2::geom_hline(aes(yintercept = which(levels(SNP) %in% "")), colour = "grey") +
		ggplot2::geom_errorbarh(aes(xmin = lo, xmax = up, size = as.factor(tot), colour = as.factor(tot)), height = 0) +
		ggplot2::scale_colour_manual(values = c("#107ab0", "#FF0000")) +
		ggplot2::scale_size_manual(values = c(0.3, 1)) +
		ggplot2::labs(x = paste0("Genetic associations with ", d$exposure[1], " on ", d$outcome[1]), y = "SNPs") +
    ggplot2::theme(
              plot.margin = unit(c(0.2, 0.3, 0.2, 0.3), "inches"),
              plot.title = element_text(size = 30, hjust = 0.5, vjust = 3),
              panel.background = element_rect(fill = "white"), 
              axis.title.x = element_text(size = 25, vjust = 0),
              axis.title.y = element_text(size = 25, vjust = 2),
              axis.text.x = element_text(size = x_size, colour = "black", face = "bold"),
              axis.text.y = element_text(size = y_size, colour = "black"), 
              axis.line = element_line(colour = "black"), 
              axis.ticks.y = element_line(size = 0),
              legend.position = "none")
	})
	res
}
