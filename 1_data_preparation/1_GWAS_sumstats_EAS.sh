################################################################
#  Descriptive: 
#    1. download GWAS summary statistics from relevant database in East Asian population 
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
  #summary dataset
    dir1=/work_dir/data/summary_data/BBJ/CAD
    cd $dir1
    wget -c https://humandbs.biosciencedbc.jp/files/hum0014/hum0014_v21_CAD_v1.zip
    unzip hum0014_v21_CAD_v1.zip
    
    #extract the rs number info
      for i in {1..22}
        do
        awk 'BEGIN{FS=" "; OFS="\t"}FNR==NR{a[$3]=$0}FNR<NR&&($1"_"$2"_"$4"_"$5 in a){print a[$1"_"$2"_"$4"_"$5], $0}' \
            <(zcat $dir1/hum0014_v21_CAD_v1/CAD.auto.rsq07.mac10.txt.gz) \
            <(zcat /opt/resource/dbsnp154_vcf/dbsnp154.hg37.chr${i}.pos.gz) \
            > $dir1/hum0014_v21_CAD_v1/CAD.chr$2.tmp1
        awk 'BEGIN{FS=" "; OFS="\t"}FNR==NR{a[$3]=$0}FNR<NR&&($1"_"$2"_"$5"_"$4 in a){print a[$1"_"$2"_"$5"_"$4], $0}' \
            <(zcat $dir1/hum0014_v21_CAD_v1/CAD.auto.rsq07.mac10.txt.gz) \
            <(zcat /opt/resource/dbsnp154_vcf/dbsnp154.hg37.chr${i}.pos.gz) \
            > $dir1/hum0014_v21_CAD_v1/CAD.chr$2.tmp2
      done

    #pool all chr
      for i in {1..22}
        do
        cat <(cat $dir1/hum0014_v21_CAD_v1/CAD.chr${i}.tmp1) \
            <(cat $dir1/hum0014_v21_CAD_v1/CAD.chr${i}.tmp2) \
            >>  $dir1/hum0014_v21_CAD_v1/CAD.chrall.tmp1
      done

    #clean
      cat <(echo "SNP CHR POS EA NEA EAF BETA SE P N" | awk 'BEGIN{FS=" "; OFS="\t"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}') \
          <(cat $dir1/hum0014_v21_CAD_v1/CAD.chrall.tmp1 | sed 's/ /\t/g'| cut -f 1-2,4-5,7-10,12,23 | awk 'BEGIN{FS=" "; OFS="\t"}{print $10, $1, $2, $4, $3, $5, $7, $8, $9, $6}') \
          | gzip > $dir1/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz
      rm $dir1/hum0014_v21_CAD_v1/*tmp*
    ## 
  ##     
##

##Height
  #summary dataset
    dir1=/work_dir/data/summary_data/BBJ/Height
    cd $dir1
    wget -c https://humandbs.biosciencedbc.jp/files/hum0014/hum0014.v15.ht.v1.zip
    unzip hum0014.v15.ht.v1.zip
    
    #extract the rs number info
      for i in {1..22}
        do
        awk 'BEGIN{FS="\t"; OFS="\t"}FNR==NR{a[$2":"$3":"$4":"$5]=$0}FNR<NR&&($1":"$2":"$4":"$5 in a){print a[$1":"$2":"$4":"$5], $0}' \
            <(zcat $dir1/hum0014.v15.ht.v1/2019_BBJ_Height_autosomes_BOLT.txt.gz | sed 's/ /\t/g')  \
            <(zcat /opt/resource/dbsnp154_vcf/dbsnp154.hg37.chr${i}.pos.gz) \
            > $dir1/Height.chr${i}.tmp1
        awk 'BEGIN{FS="\t"; OFS="\t"}FNR==NR{a[$2":"$3":"$4":"$5]=$0}FNR<NR&&($1":"$2":"$5":"$4 in a){print a[$1":"$2":"$5":"$4], $0}' \
            <(zcat $dir1/hum0014.v15.ht.v1/2019_BBJ_Height_autosomes_BOLT.txt.gz | sed 's/ /\t/g') \
            <(zcat /opt/resource/dbsnp154_vcf/dbsnp154.hg37.chr${i}.pos.gz) \
            > $dir1/Height.chr${i}.tmp2
      done

    #pool all chr
      for i in {1..22}
      do
        cat <(cat $dir1/Height.chr$i.tmp1) \
            <(cat $dir1/Height.chr$i.tmp2) \
            >>  $dir1/Height.chrall.tmp1
      done

      #ctrl+V and ctrl+M
      $dir1/Height.chrall.tmp2

    #clean
      cat <(echo "SNP CHR POS EA NEA EAF BETA SE P RSQ" | awk 'BEGIN{FS=" "; OFS="\t"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}') \
          <(cat $dir1/Height.chrall.tmp2 | cut -f 2-6,8-10,12,15| awk 'BEGIN{FS="\t"; OFS="\t"}{print $10, $1, $2, $4, $3, $5, $7, $8, $9, $6}') \
          | gzip > $dir1/Height.sumstats.gz
      rm $dir1/*tmp*
    ##
  ##
## 

##BMI
  #summary dataset
    mkdir /work_dir/data/summary_data/BBJ/BMI
    cd /work_dir/data/summary_data/BBJ/BMI
    wget -c https://humandbs.biosciencedbc.jp/files/hum0014/hum0014.v6.158k.v1.zip
    unzip hum0014.v6.158k.v1.zip
    cat <(zcat hum0014.v6.158k.v1/All_2017_BMI_BBJ_autosome.txt.gz | sed -n '1p' | awk 'BEGIN{FS="\t"; OFS="\t"}{print "SNP", "CHR", "POS", "EA", "NEA", "EAF", "BETA", "SE", "P", "R2"}') \
        <(zcat hum0014.v6.158k.v1/All_2017_BMI_BBJ_autosome.txt.gz | sed '1d'    | awk 'BEGIN{FS="\t"; OFS="\t"}{print $1, $2, $3, $5, $4, $6, $8, $9, $10, $7}') \
        | gzip > BMI.sumstats.gz
  ##
##

##BS(blood sugar: revised as FG)
  #summary dataset for BS
    mkdir /work_dir/data/summary_data/BBJ/BS
    cd /work_dir/data/summary_data/BBJ/BS
    wget -c https://humandbs.biosciencedbc.jp/files/hum0014/hum0014.v8.BS.zip
    unzip hum0014.v8.BS.zip
    cat <(cat hum0014.v7.BS/BBJ.BS.autosome.txt | sed -n '1p' | awk 'BEGIN{FS="\t"; OFS="\t"}{print "SNP", "CHR", "POS", "EA", "NEA", "EAF", "BETA", "SE", "P", "N"}') \
        <(cat hum0014.v7.BS/BBJ.BS.autosome.txt | sed '1d'    | awk 'BEGIN{FS="\t"; OFS="\t"}{print $1, $2, $3, $5, $4, $6, $8, $9, $10, $12}') \
        | gzip > FG.sumstats.gz
  ##
##  

##T2D
  #summary dataset
    dir1=/work_dir/data/summary_data/BBJ/T2D
    cd $dir1
    wget -c https://humandbs.biosciencedbc.jp/files/hum0014/hum0014.v13.T2DMmeta.v1.zip
    unzip hum0014.v13.T2DMmeta.v1.zip

    #extract the rs number info
      for i in {1..22}
        do
        awk 'BEGIN{FS="\t"; OFS="\t"}FNR==NR{a[$1]=$0}FNR<NR&&($1":"$2"_"$4"_"$5 in a){print a[$1":"$2"_"$4"_"$5], $0}' \
            <(cat $dir1/BBJ_sets1_2_3_4_BetaBased1.MAF_001.AtLeast2studies.AllChr.txt | sed 's/ /\t/g') \
            <(zcat /opt/resource/dbsnp154_vcf/dbsnp154.hg37.chr${i}.pos.gz) \
            > $dir1/T2D.BBJ.chr${i}.tmp1
        awk 'BEGIN{FS="\t"; OFS="\t"}FNR==NR{a[$1]=$0}FNR<NR&&($1":"$2"_"$5"_"$4 in a){print a[$1":"$2"_"$5"_"$4], $0}' \
            <(cat $dir1/BBJ_sets1_2_3_4_BetaBased1.MAF_001.AtLeast2studies.AllChr.txt | sed 's/ /\t/g') \
            <(zcat /opt/resource/dbsnp154_vcf/dbsnp154.hg37.chr${i}.pos.gz) \
            > $dir1/T2D.BBJ.chr${i}.tmp2
      done

    #pool all chr
      for i in {1..22}
      do
        cat <(cat $dir1/T2D.BBJ.chr$i.tmp1) \
            <(cat $dir1/T2D.BBJ.chr$i.tmp2) \
            >>  $dir1/T2D.chrall.tmp1
      done

    #clean
      cat <(echo "SNP CHR POS EA NEA EAF BETA SE P N" | awk 'BEGIN{FS=" "; OFS="\t"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}') \
          <(cat $dir1/T2D.chrall.tmp1 | cut -f 2-7,10-12,15| awk 'BEGIN{FS="\t"; OFS="\t"}{print $10, $8, $9, $1, $2, $3, $4, $5, $6, $7}') \
          | gzip > $dir1/T2D.sumstats.gz
      rm $dir1/*tmp*
    ##
  ##
##

##prepare GWAS summary statistics for HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P

  for i in HbA1c HDL LDL TG TC SBP DBP CRP WBC Lym Mono Neutro Eosino Baso Plt RBC MCV MCH MCHC Hb Ht TBil AST ALT ALP GGT TP Alb sCr BUN UA Ca P
  do
    mkdir /work_dir/data/summary_data/BBJ/${i}
    cd /work_dir/data/summary_data/BBJ/${i}
    wget -c https://humandbs.biosciencedbc.jp/files/hum0014/hum0014.v8.${i}.zip
    unzip hum0014.v8.${i}.zip
    cat <(cat hum0014.v7.${i}/BBJ.${i}.autosome.txt | sed -n '1p' | awk 'BEGIN{FS="\t"; OFS="\t"}{print "SNP", "CHR", "POS", "EA", "NEA", "EAF", "BETA", "SE", "P", "N"}') \
        <(cat hum0014.v7.${i}/BBJ.${i}.autosome.txt | sed '1d'    | awk 'BEGIN{FS="\t"; OFS="\t"}{print $1, $2, $3, $5, $4, $6, $8, $9, $10, $12}') \
        | gzip > ${i}.sumstats.gz   
  done
##
