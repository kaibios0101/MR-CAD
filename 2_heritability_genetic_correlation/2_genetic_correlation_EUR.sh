################################################################
#  Descriptive: 
#    genetic correlation by LDSC in EUR
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

#EUR
  dir1=/work_dir/project/doctoral_project/MR/LDSC/UKBB/corr/data
  dir2=/work_dir/data/summary_data/UKBB_NEALE/LDSC/h2
  cd $dir1

  for i in ALP ALT AST Alb BMI FG CRP Ca DBP HDL Hb HbA1c Height Ht LDL Lym MCH MCHC MCV Mono Neutro Plt RBC SBP TBil TC TG TP UA WBC sCr GGT eGFR Na P BUN
    do 
      ln -s $dir2/${i}.irnt.sumstats.ldsc.sumstats.gz $dir1/${i}.sumstats.gz
    done

  for i in Baso Eosino
    do 
      ln -s $dir2/${i}.sumstats.ldsc.sumstats.gz $dir1/${i}.sumstats.gz
    done

  ln -s /work_dir/data/summary_data/DIAGRAM/LDSC/h2/T2D.UKBB.ldsc.sumstats.gz $dir1/T2D.sumstats.gz
  ln -s /work_dir/data/summary_data/C4D/CAD.sumstats.ldsc.sumstats.gz $dir1/CAD.sumstats.gz
  ln -s /work_dir/data/summary_data/FinnGen/IHD/corr/meta.CAD.C4D.FinG.sumstats.ldsc.sumstats.gz $dir1/CAD.C4D.FinG.sumstats.gz

  #genetic correlation 
    dir1=/work_dir/project/doctoral_project/MR/LDSC/UKBB

    for i in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
      do 
        for j in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --out $dir1/corr/result/v1/${i}.${j} 
          done
      done
    
    for i in T2D 
      do 
        for j in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --out $dir1/corr/result/v1/${i}.${j} \
                  --samp-prev 0.04317585,nan  \
                  --pop-prev 0.073,nan 
          done
      done

    for i in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
      do 
        for j in T2D 
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --out $dir1/corr/result/v1/${i}.${j} \
                  --samp-prev nan,0.04317585  \
                  --pop-prev nan,0.073
          done
      done

    for i in CAD
      do 
        for j in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --out $dir1/corr/result/v1/${i}.${j} \
                  --samp-prev 0.3298934,nan  \
                  --pop-prev 0.0677,nan 
          done
      done

    for i in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso RBC MCV MCHC MCH Hb Ht Plt TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
      do 
        for j in CAD
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --out $dir1/corr/result/v1/${i}.${j} \
                  --samp-prev nan,0.3298934  \
                  --pop-prev nan,0.0677
          done
      done

    for i in T2D CAD
      do 
        for j in T2D CAD
          do 
              /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
                  --rg $dir1/corr/data/${i}.sumstats.gz,$dir1/corr/data/${j}.sumstats.gz \
                  --ref-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --w-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
                  --out $dir1/corr/result/v1/${i}.${j} \
                  --samp-prev 0.04317585,0.3298934  \
                  --pop-prev 0.073,0.0677
          done
      done
  #
#

cd /work_dir/project/doctoral_project/MR/LDSC/UKBB/corr/result/v1

for i in CAD Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
  do
    for j in CAD Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
      do
      cat ${i}.${j}.log | grep ^/work_dir/ | sed 's/[ ][ ]*/\t/g' | cut -f 3 >> corr.eur
    done
  done  

for i in CAD Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
  do
    for j in CAD Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
      do
      cat ${i}.${j}.log | grep ^/work_dir/ | sed 's/[ ][ ]*/\t/g' | cut -f 4 >> corse.eur
    done
  done  

for i in CAD Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
  do
    for j in CAD Height BMI FG HbA1c T2D HDL LDL TG TC SBP DBP CRP TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht
      do
      cat ${i}.${j}.log | grep ^/work_dir/ | sed 's/[ ][ ]*/\t/g' | cut -f 6 >> corp.eur
    done
  done  
  