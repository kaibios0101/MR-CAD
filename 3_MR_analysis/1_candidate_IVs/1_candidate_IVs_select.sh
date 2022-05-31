################################################################
#  Descriptive: 
#    1. select SNP with (P<0.05 each population and the same direction of effect size) 
#    2. select candidate independent IVs with the clump algorithm 
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
  
#prepare the candidate IV list
  for i in Height BMI FG HbA1c T2D HDL LDL TG TC CRP SBP DBP WBC Mono Neutro Baso Eosino Lym RBC Hb Ht MCH MCHC MCV Plt ALP ALT AST TP Alb GGT sCr TBil BUN UA Ca P CAD
    do
    qsub s1_candidate_IVs.pbs -F "${i} 5e-8 0.01 1000"
  done

    qsub s1_candidate_IVs_CAD.pbs -F "CAD 5e-8 0.01 1000"
##

#we extract all the significant SNPs (<5e-8) in the meta-analysis of 37 risk factors for removing pleiotropy
  dir1=/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB
  mkdir $dir1/CAD_CAD/meta/data/IV
  cat <(echo "Exposure SNP" | awk 'BEGIN{FS=" "; OFS="\t"}{print $0}') \
      <(cat $dir1/Height_CAD/meta/data/IV/Height_meta_signSNP | sed '1d' | awk -v var="Height" 'BEGIN{FS="\t"; OFS="\t"}{print var, $1}' ) \
      >> $dir1/CAD_CAD/meta/data/IV/pleio_signSNP_list

  for i in BMI FG HbA1c T2D HDL LDL TG TC CRP SBP DBP WBC Mono Neutro Baso Eosino Lym RBC Hb Ht MCH MCHC MCV Plt ALP ALT AST TP Alb GGT sCr TBil BUN UA Ca P
    do
      cat $dir1/${i}_CAD/meta/data/IV/${i}_meta_signSNP | sed '1d' | awk -v var="${i}" 'BEGIN{FS="\t"; OFS="\t"}{print var, $1}' \
          >> $dir1/CAD_CAD/meta/data/IV/pleio_signSNP_list
  done
##
