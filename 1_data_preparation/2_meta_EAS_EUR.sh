################################################################
#  Descriptive: 
#    1. filter by the P value over than 0.05
#    2. meta analysis for each traits from EAS and EUR 
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

#1. filter by P<0.05
  dir1=/work_dir/data/summary_data/meta/BBJ_UKBB/MR
  cd $dir1

  #EAS
    for i in Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
      do
        cat /work_dir/data/summary_data/BBJ/${i}/${i}.sumstats | awk 'BEGIN{FS="\t"; OFS="\t"}{if ($9 == "P" || $9 < 5e-2) print}' > $dir1/raw/${i}.sumstats.BBJ
    done

        zcat /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz | awk 'BEGIN{FS="\t"; OFS="\t"}{if ($9 == "P" || $9 < 5e-2) print}' > $dir1/raw/CAD.v21.sumstats.BBJ
  ##

  #EUR
    for i in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Plt RBC MCV MCH MCHC Hb Ht TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
      do
        cat /work_dir/data/summary_data/UKBB_NEALE/clean/${i}.irnt.sumstats | awk 'BEGIN{FS="\t"; OFS="\t"}{if ($9 == "P" || $9 < 5e-2) print}' > $dir1/raw/${i}.irnt.sumstats.UKBB
    done

    for i in Baso Eosino
      do
        cat /work_dir/data/summary_data/UKBB_NEALE/clean/${i}.sumstats | awk 'BEGIN{FS="\t"; OFS="\t"}{if ($9 == "P" || $9 < 5e-2) print}' > $dir1/raw/${i}.sumstats.UKBB
    done

    for i in T2D
      do
        zcat /work_dir/data/summary_data/DIAGRAM/clean/${i}.Mahajan.2018b.UKBB.sumstats.gz | awk 'BEGIN{FS="\t"; OFS="\t"}{if ($9 == "P" || $9 < 5e-2) print}' > $dir1/raw/${i}.sumstats.DIAGRAM.UKBB
    done

        zcat /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz | awk 'BEGIN{FS="\t"; OFS="\t"}{if ($6 == "P" || $6 < 5e-2) print}' > $dir1/raw/CAD.sumstats.C4D.FinG
  ##
##

#2. meta-analysis: metal software
  #with input from above data, such as Height.sumstats.BBJ + Height.sumstats.UKBB
  for i in CAD.v21.C4D.FinG Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
    do
      metal $dir1/raw/metal.${i}
  done  

  for i in CAD.v21.C4D.FinG Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
    do
      cat <(echo "SNP EA NEA BETA SE P DIR"  | awk 'BEGIN{FS=" "; OFS="\t"}{print $1, $2, $3, $4, $5, $6, $7}') \
          <(cat $dir1/raw/${i}1.tbl | sed 1d | awk 'BEGIN{FS="\t"; OFS="\t"}{print $1, toupper($2), toupper($3), $4, $5, $6, $7}') \
          | bgzip > $dir1/clean/meta.${i}.gz
  done
##

#3. we also meta-analsys all traits without filtering P value, this meta-analyzed data will be used in the IV selection (remove pleiotropy)
  #with input from formated summary data, such as Height.sumstats + Height.irnt.sumstats
  dir2=/work_dir/data/summary_data/meta/BBJ_UKBB/MR2
  for i in CAD.v21.C4D.FinG Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
    do
      metal $dir2/raw/metal.${i}
  done  

  for i in CAD.v21.C4D.FinG Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
    do
      cat <(echo "SNP EA NEA BETA SE P DIR"  | awk 'BEGIN{FS=" "; OFS="\t"}{print $1, $2, $3, $4, $5, $6, $7}') \
          <(cat $dir2/raw/${i}1.tbl | sed 1d | awk 'BEGIN{FS="\t"; OFS="\t"}{print $1, toupper($2), toupper($3), $4, $5, $6, $7}') \
          | bgzip > $dir2/clean/meta.${i}.gz
  done
##