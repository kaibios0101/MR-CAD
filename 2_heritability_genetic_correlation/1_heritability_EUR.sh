################################################################
#  Descriptive: 
#    estimate the heritability and genetic correlation in EUR
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
  #CAD
    dir1=/work_dir/data/summary_data/FinnGen/IHD
    cd $dir1
    
    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/munge_sumstats.py \
      --sumstats $dir1/meta.CAD.C4D.FinG.sumstats.gz \
      --out $dir1/corr/meta.CAD.C4D.FinG.sumstats.ldsc \
      --N 283472.7 \
      --merge-alleles /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/w_hm3.snplist

    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
      --h2 $dir1/corr/meta.CAD.C4D.FinG.sumstats.ldsc.sumstats.gz \
      --ref-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
      --w-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
      --samp-prev 0.3298934 \
      --pop-prev 0.0677 \
      --out $dir1/corr/meta.CAD.C4D.FinG.h2 
  ##

  #T2D
    dir1=/work_dir/data/summary_data/DIAGRAM
    cd $dir1  

    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/munge_sumstats.py \
      --sumstats $dir1/LDSC/h2/T2D.sumstats.ldsc \
      --out $dir1/LDSC/h2/T2D.sumstats.ldsc2 \
      --merge-alleles /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/w_hm3.snplist

    /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
      --h2 $dir1/LDSC/h2/T2D.sumstats.ldsc2.sumstats.gz \
      --ref-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
      --w-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
      --samp-prev 0.04317585 \
      --pop-prev 0.073 \
      --out $dir1/LDSC/h2/T2D.h2 
  ##

  #quantitative traits
    dir1=/work_dir/data/summary_data/UKBB_NEALE
    cd $dir1

    for i in Height.irnt BMI.irnt FG.irnt HbA1c.irnt HDL.irnt LDL.irnt TG.irnt TC.irnt SBP.irnt DBP.irnt CRP.irnt 
              WBC.irnt Lym.irnt Mono.irnt Neutro.irnt Eosino Baso Plt.irnt RBC.irnt MCV.irnt MCH.irnt 
              MCHC.irnt Hb.irnt Ht.irnt TBil.irnt AST.irnt ALT.irnt ALP.irnt GGT.irnt TP.irnt Alb.irnt sCr.irnt 
              BUN.irnt UA.irnt Ca.irnt P.irnt
      do
      /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/munge_sumstats.py \
        --sumstats $dir1/clean/${1}.sumstats \
        --out $dir1/LDSC/h2/${1}.sumstats.ldsc \
        --merge-alleles /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/w_hm3.snplist

      /opt/software/miniconda3/envs/ldsc/bin/python /home/opt/software/ldsc/ldsc.py \
        --h2 $dir1/LDSC/h2/${1}.sumstats.ldsc.sumstats.gz \
        --ref-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
        --w-ld-chr /home/opt/software/ldsc/ref_data/EUR/eur_w_ld_chr/ \
        --out $dir1/LDSC/h2/${1}.h2 
    done
  ##
##  