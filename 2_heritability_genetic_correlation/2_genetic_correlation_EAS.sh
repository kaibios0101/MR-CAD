################################################################
#  Descriptive: 
#    genetic correlation by LDSC in EAS
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


#EAS
  dir1=/work_dir/project/doctoral_project/MR/LDSC/BBJ/corr/data
  dir2=/work_dir/data/summary_data/BBJ/LDSC/h2
  cd $dir1

  for i in ALP ALT AST Alb BMI FG Baso CRP Ca DBP Eosino HDL Hb HbA1c Height Ht LDL Lym MCHC MCH MCV Mono Neutro Plt RBC SBP T2D TBil TC TG TP UA WBC sCr eGFR GGT P BUN
    do 
      ln -s $dir2/${i}.sumstats.ldsc.sumstats.gz $dir1/${i}.sumstats.gz
    done
      
      ln -s $dir2/CAD.v21.sumstats.ldsc.sumstats.gz $dir1/CADv21.sumstats.gz

  #genetic correlation 
    dir1=/work_dir/project/doctoral_project/MR/LDSC/BBJ

    for i in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
      do 
        for j in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --out $dir1/corr/result/v4/${i}.${j} 
          done
      done
    
    for i in T2D 
      do 
        for j in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --out $dir1/corr/result/v4/${i}.${j} \
                  --samp-prev 0.1909326,nan  \
                  --pop-prev 0.075,nan 
          done
      done

    for i in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
      do 
        for j in T2D 
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --out $dir1/corr/result/v4/${i}.${j} \
                  --samp-prev nan,0.1909326  \
                  --pop-prev nan,0.075 
          done
      done

    for i in CADv21 
      do 
        for j in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --out $dir1/corr/result/v4/${i}.${j} \
                  --samp-prev 0.138,nan  \
                  --pop-prev 0.0524,nan 
          done
      done

    for i in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
      do 
        for j in CADv21 
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --out $dir1/corr/result/v4/${i}.${j} \
                  --samp-prev nan,0.138  \
                  --pop-prev nan,0.0524 
          done
      done

    for i in T2D CADv21 
      do 
        for j in T2D CADv21 
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
                  --out $dir1/corr/result/v4/${i}.${j} \
                  --samp-prev 0.1909326,0.138  \
                  --pop-prev 0.075,0.0524
          done
      done
  #
#

cd /work_dir/project/doctoral_project/MR/LDSC/BBJ/corr/result/v1

for i in CADv21 Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
  do
    for j in CADv21 Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
      do
      cat ${i}.${j}.log | grep ^/work_dir/ | sed 's/[ ][ ]*/\t/g' | cut -f 3 >> corr.eas
    done
  done  

for i in CADv21 Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
  do
    for j in CADv21 Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
      do
      cat ${i}.${j}.log | grep ^/work_dir/ | sed 's/[ ][ ]*/\t/g' | cut -f 4 >> corse.eas
    done
done  

for i in CADv21 Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
  do
    for j in CADv21 Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
      do
      cat ${i}.${j}.log | grep ^/work_dir/ | sed 's/[ ][ ]*/\t/g' | cut -f 6 >> corp.eas
    done
done  
