################################################################
#  Descriptive: 
#     forest plot
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

mr_forest_plot <- function(singlesnp_results, x_size, y_size, exponentiate = FALSE)
{
	requireNamespace("ggplot2", quietly = TRUE)
	requireNamespace("plyr", quietly = TRUE)
	res <- plyr::dlply(singlesnp_results, c("id.exposure", "id.outcome"), function(d)
	{
		d <- plyr::mutate(d)
		if(sum(!grepl("All", d$SNP)) < 2) {
			return(
				blank_plot("Insufficient number of SNPs")
			)
		}
		levels(d$SNP)[levels(d$SNP) == "All - Inverse variance weighted (multiplicative random effects)"] <- "All-IVW(re)"
		levels(d$SNP)[levels(d$SNP) == "All - Inverse variance weighted"] <- "All-IVW(mre)"
		levels(d$SNP)[levels(d$SNP) == "All - MR Egger"] <- "All-Egger"
		am <- grep("All", d$SNP, value=TRUE)
		d$up <- d$b + 1.96 * d$se
		d$lo <- d$b - 1.96 * d$se
		d$tot <- 0.01
		d$tot[d$SNP %in% am] <- 1
		d$SNP <- as.character(d$SNP)
		nom <- d$SNP[! d$SNP %in% am]
		nom <- nom[order(d$b)]
		d <- rbind(d, d[nrow(d),])
		d$SNP[nrow(d)-1] <- ""
		d$b[nrow(d)-1] <- NA
		d$up[nrow(d)-1] <- NA
		d$lo[nrow(d)-1] <- NA
		d$SNP <- ordered(d$SNP, levels=c(am, "", nom))

		xint <- 0

		if(exponentiate)
		{
			d$b <- exp(d$b)
			d$up <- exp(d$up)
			d$lo <- exp(d$lo)
			xint <- 1
		}

		ggplot2::ggplot(data = d, aes(x = b, y = SNP)) +
		ggplot2::geom_point(aes(colour = as.factor(tot))) +
		ggplot2::geom_vline(xintercept = xint, linetype = "dotted", colour = "grey") +
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
			legend.position="none")
	})
	res
}