#*********************************************************************************
# Calculates the variance in liability explained by a single biallelic loci.
# PA: allele frequency of the risk allele (denoted A)
# RR1: relative risk of Aa (one risk allele) compared to aa (no risk allele)
# RR2: relative risk of AA (two risk alleles) compared to aa (no risk allele)
# K:  overall probability of disease in population
# Returns the variance explained (Vg) and the mean liability for each genotype (the overall liability is normalized to mean 0 and variance 1)
# cite: So H.C., Gui A.H.S., Cherny S.S. and Sham P.C. (2011) Evaluating the heritability explained by known susceptibility variants: 
#       a survey of ten complex diseases. Genetic Epidemiology. 
#*********************************************************************************

#**********************************************disease or binary trait
#function
func.Vg <- function (data, PA = "EAF", BETA = "BETA", K) {
Paa = (1 - data[, PA])^2
PAa = 2 * data[, PA] * (1 - data[, PA])
PAA = data[, PA]^2
RR1 = exp(data[, BETA])
RR2 = exp(2 * data[, BETA])
muaa = 0
faa = K/(Paa + PAa * RR1 + PAA * RR2)
fAa = RR1 * faa
fAA = RR2 * faa 
T = qnorm(1 - faa) 
muAa = T - qnorm(1 - fAa)
muAA = T - qnorm(1 - fAA)
mean.all = PAa * muAa + PAA * muAA
Vg = Paa * (muaa - mean.all)^2 + PAa * (muAa - mean.all)^2 + PAA * (muAA - mean.all)^2
actual.Vg =  Vg / (1 + Vg) 
VR = 1 - actual.Vg 
actual.T = Paa * sqrt(VR) * qnorm(1 - faa) + PAa * sqrt(VR) * qnorm(1 - fAa) + PAA * sqrt(VR) * qnorm(1 - fAA)
actual.muaa = actual.T - sqrt(VR) * qnorm(1 - faa)
actual.muAa = actual.T - sqrt(VR) * qnorm(1 - fAa)
actual.muAA = actual.T - sqrt(VR) * qnorm(1 - fAA)

res <- data.frame(Vg = actual.Vg, muaa = actual.muaa, muAa = actual.muAa, muAA = actual.muAA)
res2 <- cbind(data, res)
return(res2)
} 

#example:
#Identification of six new genetic loci associated with atrial fibrillation in the Japanese population
#tmp <- data.frame(SNP = c("rs1218568", "rs639652", "rs7626624", "rs2220427"),
#                  EAF = c(0.06130, 0.54010, 0.07780, 0.45470),
#                  BETA  = c(log(1.15340), log(1.13500), log(1.11628), log(1.70648)))

#func.Vg(data = tmp, PA = "EAF", BETA = "BETA", K = 0.005) #T2D



#**********************************************quantitative trait
#function
