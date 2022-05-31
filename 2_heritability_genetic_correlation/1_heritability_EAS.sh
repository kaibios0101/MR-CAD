################################################################
#  Descriptive: 
#    estimate the heritability and genetic correlation in EAS
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

##
  dir1=/work_dir/data/summary_data/BBJ
  cd $dir1

  #CAD
    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/munge_sumstats.py \
      --sumstats $dir1/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.backup \
      --out $dir1/LDSC/h2/CAD.v21.sumstats.ldsc \
      --merge-alleles /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/w_hm3.snplist

    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
      --h2 $dir1/LDSC/h2/CAD.v21.sumstats.ldsc.sumstats.gz \
      --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
      --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
      --samp-prev 0.1539102 \
      --pop-prev 0.0524 \
      --out $dir1/LDSC/h2/CAD.v21.h2   
  ##

  #T2D
    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/munge_sumstats.py \
      --sumstats $dir1/T2D/T2D.sumstats.gz \
      --out $dir1/LDSC/h2/T2D.sumstats.ldsc \
      --merge-alleles /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/w_hm3.snplist

    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
      --h2 $dir1/LDSC/h2/T2D.sumstats.ldsc.sumstats.gz \
      --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
      --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
      --samp-prev 0.1909326 \
      --pop-prev 0.075 \
      --out $dir1/LDSC/h2/T2D.h2 
  ##

  #Height
    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/munge_sumstats.py \
      --sumstats $dir1/Height/Height.sumstats \
      --out $dir1/LDSC/h2/Height.sumstats.ldsc \
      --N 159148 \
      --merge-alleles /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/w_hm3.snplist

    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
      --h2 $dir1/LDSC/h2/Height.sumstats.ldsc.sumstats.gz \
      --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
      --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
      --out $dir1/LDSC/h2/Height.h2 
  ##

  #BMI
    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/munge_sumstats.py \
      --sumstats $dir1/BMI/BMI.sumstats \
      --out $dir1/LDSC/h2/BMI.sumstats.ldsc \
      --N 158284 \
      --merge-alleles /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/w_hm3.snplist

    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
      --h2 $dir1/LDSC/h2/BMI.sumstats.ldsc.sumstats.gz \
      --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
      --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
      --out $dir1/LDSC/h2/BMI.h2 
  ##

  for i in Height BMI FG HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
    do
    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/munge_sumstats.py \
      --sumstats $dir1/${i}/${i}.sumstats \
      --out $dir1/LDSC/h2/${i}.sumstats.ldsc \
      --merge-alleles /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/w_hm3.snplist

    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
      --h2 $dir1/LDSC/h2/${i}.sumstats.ldsc.sumstats.gz \
      --ref-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
      --w-ld-chr /home/opt/software/ldsc/ref_data/EAS/eas_ldscores/ \
      --out $dir1/LDSC/h2/${i}.h2 
  done
##