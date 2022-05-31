################################################################
#  Descriptive: 
#    1. download GWAS summary statistics from relevant database in European population 
#    2. tidy the summary statistics 
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

##CAD
  #notes: CARDIoGRAMplusC4D
    dir1=/work_dir/data/summary_data/C4D
    cd $dir1
    wget -c http://www.cardiogramplusc4d.org/media/cardiogramplusc4d-consortium/data-downloads/cad.additive.Oct2015.pub.zip
    unzip $dir1/cad.additive.Oct2015.pub.zip
    
    #clean
        cat <(echo "SNP CHR POS EA NEA EAF BETA SE P INFO" | awk 'BEGIN{FS=" "; OFS="\t"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}') \
            <(cat $dir1/cad.add.160614.website.txt      | sed 1d | cut -f 1-7,9-11 | awk 'BEGIN{FS="\t"; OFS="\t"}{print $1, $2, $3, $4, $5, $6, $8, $9, $10, $7}') \
            | gzip > $dir1/CAD.sumstats.gz
  ##

  #notes: FinnGen
    dir1=/work_dir/data/summary_data/FinnGen/IHD
    cd $dir1
    wget -c https://storage.googleapis.com/finngen-public-data-r5/summary_stats/finngen_R5_I9_ISCHHEART.gz

    #clean
      for i in {1..22}; 
        do 
        awk 'BEGIN{FS="\t"; OFS="\t"}FNR==NR{a[$1":"$2":"$3":"$4]=$0}FNR<NR&&($1":"$2":"$4":"$5 in a){print a[$1":"$2":"$4":"$5], $0}' \
            <(zcat $dir1/download/finngen_R5_I9_ISCHHEART.gz) \
            <(zcat /opt/resource/dbsnp154_vcf/dbsnp154.hg38.chr${i}.pos.gz) \
            > $dir1/IHD.chr${i}.tmp1
        awk 'BEGIN{FS="\t"; OFS="\t"}FNR==NR{a[$1":"$2":"$3":"$4]=$0}FNR<NR&&($1":"$2":"$5":"$4 in a){print a[$1":"$2":"$5":"$4], $0}' \
            <(zcat $dir1/download/finngen_R5_I9_ISCHHEART.gz) \
            <(zcat /opt/resource/dbsnp154_vcf/dbsnp154.hg38.chr${i}.pos.gz) \
            > $dir1/IHD.chr${i}.tmp2
      done

      for i in {1..22};
        do
        cat <(cat $dir1/IHD.chr$i.tmp1) <(cat $dir1/IHD.chr$i.tmp2) >> $dir1/IHD.sumstats.tmp;
      done

      cat <(echo "SNP CHR POS EA NEA EAF BETA SE P" | awk 'BEGIN{FS=" "; OFS="\t"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9}') \
          <(cat $dir1/IHD.sumstats.tmp | awk 'BEGIN{FS="\t"; OFS="\t"}{print $19, $1, $2, $4, $3, $10, $8, $9, $7}') \
          | bgzip > $dir1/IHD.sumstats.gz
      rm $dir1/*tmp*
    ##

    #meta-analysis: CARDIoGRAMplusC4D + FinnGen with metal software
      metal $dir1/metal.CAD 
      #output file: CAD.C4D.FinG1.tbl
      cat <(echo "SNP EA NEA BETA SE P DIR"  | awk 'BEGIN{FS=" "; OFS="\t"}{print $1, $2, $3, $4, $5, $6, $7}') \
          <(cat $dir1/CAD.C4D.FinG1.tbl | sed 1d | awk 'BEGIN{FS="\t"; OFS="\t"}{print $1, toupper($2), toupper($3), $4, $5, $6, $7}') \
          | bgzip > $dir1/CAD.C4D.FinG.sumstats.gz
    ##
  ##
##

##T2D
  #link: http://diagram-consortium.org/downloads.html
    dir1=/work_dir/data/summary_data/DIAGRAM
    cd $dir2
    
    #extract the rs number info
      for i in {1..22}
        do
        awk 'BEGIN{FS="\t"; OFS="\t"}FNR==NR{a[$1":"$2":"$3]=$0}FNR<NR&&($1":"$2":"$4":"$5 in a){print a[$1":"$2":"$4":"$5], $0}' \
            <(cat $dir1/download/Mahajan.NatGenet2018b.UKBB.HRC.T2D.European.txt) \
            <(zcat /opt/resource/dbsnp154_vcf/dbsnp154.hg37.chr${2}.pos.gz) \
            > $dir1/clean/T2D.Mahajan.2018b.UKBB.chr${2}.tmp1
        awk 'BEGIN{FS="\t"; OFS="\t"}FNR==NR{a[$1":"$2":"$3]=$0}FNR<NR&&($1":"$2":"$5":"$4 in a){print a[$1":"$2":"$5":"$4], $0}' \
            <(cat $dir1/download/Mahajan.NatGenet2018b.UKBB.HRC.T2D.European.txt) \
            <(zcat /opt/resource/dbsnp154_vcf/dbsnp154.hg37.chr${2}.pos.gz) \
            > $dir1/clean/T2D.Mahajan.2018b.UKBB.chr${2}.tmp2
      done
      
    #pool all chr
      for i in {1..22}
        do
        cat <(cat $dir1/clean/T2D.Mahajan.2018b.UKBB.chr$i.tmp1) \
            <(cat $dir1/clean/T2D.Mahajan.2018b.UKBB.chr$i.tmp2) \
            >>  $dir1/clean/T2D.Mahajan.2018b.UKBB.chrall.tmp1
      done

    #clean
      cat <(echo "SNP CHR POS EA NEA EAF BETA SE P N" | awk 'BEGIN{FS=" "; OFS="\t"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}') \
          <(cat $dir1/clean/T2D.Mahajan.2018b.UKBB.chrall.tmp1 | cut -f 2-10,13 | awk 'BEGIN{FS="\t"; OFS="\t"}{print $10, $1, $2, $3, $4, $5, $6, $7, $8, $9}') \
          | gzip > $dir1/clean/T2D.Mahajan.2018b.UKBB.sumstats.gz
      rm $dir1/clean/*tmp*
  ##
##

#####################################
#for quantitative trats in UKB
  dir1=/work_dir/data/summary_data/UKBB_NEALE

  ##Height.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/50_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "50_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i Height.irnt"
      done
  ##

  ##BMI.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/21001_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "21001_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i BMI.irnt"
      done
  ##

  ##FG.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30740_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        sleep 2
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30740_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i FG.irnt"
      done
  ##

  ##HbA1c.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30750_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30750_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i HbA1c.irnt"
      done
  ##

  ##HDL.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30760_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30760_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i HDL.irnt"
      done
  ##

  ##LDL.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30780_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30780_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i LDL.irnt"
      done
  ##

  ##TG.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30870_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30870_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i TG.irnt"
      done
  ##

  ##TC.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30690_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30690_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i TC.irnt"
      done
  ##

  ##DBP.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/4079_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "4079_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i DBP.irnt"
      done
  ##

  ##SBP.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/4080_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "4080_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i SBP.irnt"
      done
  ##

  ##CRP.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30710_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30710_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i CRP.irnt"
      done
  ##

  ##WBC.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30710_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30710_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i WBC.irnt"
      done
  ##

  ##Lym.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30120_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30120_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i Lym.irnt"
      done
  ##

  ##Mono.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30130_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30130_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i Mono.irnt"
      done
  ##

  ##Neutro.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30130_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30130_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i Neutro.irnt"
      done
  ##

  ##Eosino
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30150.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30150.gwas.imputed_v3.both_sexes.tsv.bgz $i Eosino"
      done
  ##

  ##Baso
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30160.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30160.gwas.imputed_v3.both_sexes.tsv.bgz $i Baso"
      done
  ##

  ##Plt.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30080_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30080_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i Plt.irnt"
      done
  ##

  ##RBC.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30010_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30010_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i RBC.irnt"
      done
  ##

  ##MCV.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30040_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30040_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i MCV.irnt"
      done
  ##

  ##MCH.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30050_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30050_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i MCH.irnt"
      done

  ##

  ##MCHC.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30060_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30060_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i MCHC.irnt"
      done
  ##

  ##Hb.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30020_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30020_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i Hb.irnt"
      done
  ##

  ##Ht.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30030_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30030_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i Ht.irnt"
      done
  ##

  ##TBil.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30840_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30840_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i TBil.irnt"
      done
  ##

  ##AST.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30650_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30650_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i AST.irnt"
      done

  ##

  ##ALT.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30620_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30620_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i ALT.irnt"
      done
  ##

  ##ALP.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30610_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30610_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i ALP.irnt"
      done
  ##

  ##GGT.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30730_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30730_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i GGT.irnt"
      done
  ##

  ##TP.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30860_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30860_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i TP.irnt"
      done
  ##

  ##Alb.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30600_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30600_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i Alb.irnt"
      done

  ##

  ##sCr.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30700_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30700_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i sCr.irnt"
      done
  ##

  ##BUN.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30670_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
      
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30670_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i BUN.irnt"
      done
  ##

  ##UA.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30880_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
        
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30880_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i UA.irnt"
      done
  ##

  ##Ca.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30680_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
            
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30680_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i Ca.irnt"
      done
  ##

  ##P.irnt
      cd $dir1/download
      wget -c https://www.dropbox.com/s/xr36giwlmiflz1a/30810_irnt.gwas.imputed_v3.both_sexes.tsv.bgz?dl=1
                
      for i in {1..22}
        do
        qsub $dir1/clean/s1_chrpos_2_rsid_UKB.pbs -F "30810_irnt.gwas.imputed_v3.both_sexes.tsv.bgz $i P.irnt"
      done
  ##
##

#format
  for i in Height.irnt BMI.irnt FG.irnt HbA1c.irnt HDL.irnt LDL.irnt TG.irnt TC.irnt SBP.irnt DBP.irnt CRP.irnt 
          WBC.irnt Lym.irnt Mono.irnt Neutro.irnt Eosino Baso Plt.irnt RBC.irnt MCV.irnt MCH.irnt 
          MCHC.irnt Hb.irnt Ht.irnt TBil.irnt AST.irnt ALT.irnt ALP.irnt GGT.irnt TP.irnt Alb.irnt sCr.irnt 
          BUN.irnt UA.irnt Ca.irnt P.irnt
    do 
    qsub s1_quantitative_format_UKB.pbs -F "$i"
  done
##
