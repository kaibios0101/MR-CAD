################################################################
#  Descriptive: 
#    perform univariable MR analysis (job list)
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


#################################################################################################
########univariable MR analysis of 37 risk factors on CAD

  #mkdir dir
    for i in Height BMI FG HbA1c T2D HDL LDL TG TC CRP SBP DBP WBC Mono Neutro Baso Eosino Lym RBC Hb Ht MCH MCHC MCV Plt ALP ALT AST TP Alb GGT sCr TBil BUN UA Ca P 
      do
      mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/${i}_CAD/meta/result/EAS/v1
      mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/${i}_CAD/meta/result/EUR/v1
    done
  ##

  ##ALT--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ALT_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          ALT CAD meta data/IV/IV.ALT.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 134182 0 0 EAS/v1 1 0.632 0.138 EAS 1.186" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ALT_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          ALT CAD meta data/IV/IV.ALT.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 344136 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##AST--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/AST_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          AST CAD meta data/IV/IV.AST.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 134154 0 0 EAS/v1 1 0.631 0.138 EAS 1.361" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/AST_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          AST CAD meta data/IV/IV.AST.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 342990 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Alb--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Alb_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Alb CAD meta data/IV/IV.Alb.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 102223 0 0 EAS/v1 1 0.481 0.138 EAS 0.619"

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Alb_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Alb CAD meta data/IV/IV.Alb.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 315268 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##ALP--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ALP_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          ALP CAD meta data/IV/IV.ALP.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 105030 0 0 EAS/v1 1 0.494 0.138 EAS 1.000" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ALP_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          ALP CAD meta data/IV/IV.ALP.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 344292 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##BMI--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/BMI_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          BMI CAD meta data/IV/IV.BMI.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 158284 0 0 EAS/v1 1 0.745 0.138 EAS 1.297" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/BMI_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          BMI CAD meta data/IV/IV.BMI.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 354831 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Baso--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Baso_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Baso CAD meta data/IV/IV.Baso.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 62076 0 0 EAS/v1 1 0.292 0.138 EAS 1.536" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Baso_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Baso CAD meta data/IV/IV.Baso.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 349856 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##CRP--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/CRP_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          CRP CAD meta data/IV/IV.CRP.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 75391 0 0 EAS/v1 1 0.355 0.138 EAS 1.630" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/CRP_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          CRP CAD meta data/IV/IV.CRP.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 343524 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Ca--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Ca_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Ca CAD meta data/IV/IV.Ca.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 71701 0 0 EAS/v1 1 0.337 0.138 EAS 0.731" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Ca_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Ca CAD meta data/IV/IV.Ca.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 315153 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##DBP--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/DBP_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          DBP CAD meta data/IV/IV.DBP.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 136615 0 0 EAS/v1 1 0.643 0.138 EAS 0.836" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/DBP_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          DBP CAD meta data/IV/IV.DBP.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 340162 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Eosino--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Eosino_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Eosino CAD meta data/IV/IV.Eosino.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 62076 0 0 EAS/v1 1 0.292 0.138 EAS 0.713" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Eosino_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Eosino CAD meta data/IV/IV.Eosino.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 349856 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##FG--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/FG_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          FG CAD meta data/IV/IV.FG.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 93146 0 0 EAS/v1 1 0.438 0.138 EAS 1.035" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/FG_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          FG CAD meta data/IV/IV.FG.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 314916 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##GGT--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/GGT_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          GGT CAD meta data/IV/IV.GGT.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 118309 0 0 EAS/v1 1 0.557 0.138 EAS 1.661" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/GGT_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          GGT CAD meta data/IV/IV.GGT.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 344104 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##HDL--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/HDL_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          HDL CAD meta data/IV/IV.HDL.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 70657 0 0 EAS/v1 1 0.333 0.138 EAS 0.959" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/HDL_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          HDL CAD meta data/IV/IV.HDL.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 315133 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##HbA1c--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/HbA1c_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          HbA1c CAD meta data/IV/IV.HbA1c.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 42970 0 0 EAS/v1 1 0.202 0.138 EAS 1.000" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/HbA1c_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          HbA1c CAD meta data/IV/IV.HbA1c.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 344182 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Hb--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Hb_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Hb CAD meta data/IV/IV.Hb.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 108769 0 0 EAS/v1 1 0.512 0.138 EAS 0.707" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Hb_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Hb CAD meta data/IV/IV.Hb.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 350474 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Height--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Height_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Height CAD meta data/IV/IV.Height.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 159148 0 0 EAS/v1 1 0.749 0.138 EAS 1.409" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Height_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Height CAD meta data/IV/IV.Height.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 360388 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Ht--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Ht_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Ht CAD meta data/IV/IV.Ht.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 108757 0 0 EAS/v1 1 0.512 0.138 EAS 0.732" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Ht_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Ht CAD meta data/IV/IV.Ht.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 350475 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##LDL--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/LDL_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          LDL CAD meta data/IV/IV.LDL.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 72866 0 0 EAS/v1 1 0.343 0.138 EAS 0.821" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/LDL_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          LDL CAD meta data/IV/IV.LDL.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 343621 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Lym--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Lym_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Lym CAD meta data/IV/IV.Lym.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 62076 0 0 EAS/v1 1 0.292 0.138 EAS 1.695" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Lym_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Lym CAD meta data/IV/IV.Lym.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 349856 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##MCHC--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MCHC_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          MCHC CAD meta data/IV/IV.MCHC.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 108728 0 0 EAS/v1 1 0.512 0.138 EAS 1.000" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MCHC_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          MCHC CAD meta data/IV/IV.MCHC.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 5000 350468 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##MCH--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MCH_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          MCH CAD meta data/IV/IV.MCH.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 108054 0 0 EAS/v1 1 0.509 0.138 EAS 0.915" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MCH_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          MCH CAD meta data/IV/IV.MCH.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 350472 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##MCV--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MCV_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          MCV CAD meta data/IV/IV.MCV.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 108256 0 0 EAS/v1 1 0.510 0.138 EAS 0.850" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MCV_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          MCV CAD meta data/IV/IV.MCV.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 350473 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Mono--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Mono_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Mono CAD meta data/IV/IV.Mono.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 62076 0 0 EAS/v1 1 0.292 0.138 EAS 1.618" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Mono_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Mono CAD meta data/IV/IV.Mono.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 349856 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Neutro--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Neutro_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Neutro CAD meta data/IV/IV.Neutro.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 62076 0 0 EAS/v1 1 0.292 0.138 EAS 0.943" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Neutro_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Neutro CAD meta data/IV/IV.Neutro.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 349856 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##P--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/P_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          P CAD meta data/IV/IV.P.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 42793 0 0 EAS/v1 1 0.201 0.138 EAS 0.820" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/P_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          P CAD meta data/IV/IV.P.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 314658 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##Plt--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Plt_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Plt CAD meta data/IV/IV.Plt.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 108208 0 0 EAS/v1 1 0.509 0.138 EAS 0.883" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Plt_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Plt CAD meta data/IV/IV.Plt.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 350474 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##RBC--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/RBC_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          RBC CAD meta data/IV/IV.RBC.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 108794 0 0 EAS/v1 1 0.512 0.138 EAS 0.742" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/RBC_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          RBC CAD meta data/IV/IV.RBC.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 350475 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##SBP--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/SBP_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          SBP CAD meta data/IV/IV.SBP.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 136597 0 0 EAS/v1 1 0.643 0.138 EAS 0.948" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/SBP_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          SBP CAD meta data/IV/IV.SBP.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 340159 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##T2D--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/T2D_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          T2D CAD meta data/IV/IV.T2D.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 191764 1 0.075 EAS/v1 1 0.903 0.138 EAS 1.000" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/T2D_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          T2D CAD meta data/IV/IV.T2D.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 442817 1 0.10 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##TBil--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/TBil_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          TBil CAD meta data/IV/IV.TBil.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 5000 110207 0 0 EAS/v1 1 0.519 0.138 EAS 0.897" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/TBil_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          TBil CAD meta data/IV/IV.TBil.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 342829 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##TC--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/TC_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          TC CAD meta data/IV/IV.TC.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 128305 0 0 EAS/v1 1 0.604 0.138 EAS 1.147" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/TC_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          TC CAD meta data/IV/IV.TC.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 344278 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 

  ##-----------------------------------------------------------------------------------------------

  ##TG--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/TG_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          TG CAD meta data/IV/IV.TG.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 105597 0 0 EAS/v1 1 0.497 0.138 EAS 1.262" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/TG_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          TG CAD meta data/IV/IV.TG.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 343992 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 

  ##-----------------------------------------------------------------------------------------------

  ##TP--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/TP_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          TP CAD meta data/IV/IV.TP.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 113509 0 0 EAS/v1 1 0.534 0.138 EAS 0.714" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/TP_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          TP CAD meta data/IV/IV.TP.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 314921 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##UA--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/UA_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          UA CAD meta data/IV/IV.UA.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 109029 0 0 EAS/v1 1 0.513 0.138 EAS 0.931" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/UA_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          UA CAD meta data/IV/IV.UA.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 343836 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##WBC--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/WBC_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          WBC CAD meta data/IV/IV.WBC.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 107964 0 0 EAS/v1 1 0.508 0.138 EAS 1.150" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/WBC_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          WBC CAD meta data/IV/IV.WBC.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 350470 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##sCr--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/sCr_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          sCr CAD meta data/IV/IV.sCr.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 142097 0 0 EAS/v1 1 0.669 0.138 EAS 0.909" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/sCr_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          sCr CAD meta data/IV/IV.sCr.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 344104 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------

  ##BUN--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/BUN_CAD/meta/result/EAS/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          BUN CAD meta data/IV/IV.BUN.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 139818 0 0 EAS/v1 1 0.658 0.138 EAS 0.818" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/BUN_CAD/meta/result/EUR/v1
      qsub /work_dir/project/doctoral_project/MR/run_script/UVMR.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          BUN CAD meta data/IV/IV.BUN.intersection.UKBB \
          /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 10000 344052 0 0 EUR/v1 1 0 0.2276202 EUR 1.000" 
  ##-----------------------------------------------------------------------------------------------
##



#################################################################################################
########reverse MR analysis of CAD on RBC Hb Ht UA

  #mkdir dir
    for i in RBC Hb Ht UA
      do
      mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/${i}_CAD/meta/result/EAS/v1_reverse
      mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/${i}_CAD/meta/result/EUR/v1_reverse
    done
  ##

  ##RBC--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/RBC_CAD/meta/result/ld_1e-1_r_5e2/EAS/v1_reverse
      qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/UVMR_reverse.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          RBC CAD meta data/IV/IV.CAD.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/RBC/RBC.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 101091.644 1 0.0524 ld_1e-1_r_5e2/EAS/v1_reverse 0 0.512 0" 
    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/RBC_CAD/meta/result/ld_1e-1_r_5e2/EUR/v1_reverse
      qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/UVMR_reverse.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          RBC CAD meta data/IV/IV.CAD.intersection.UKBB \
          /work_dir/data/summary_data/UKBB_NEALE/clean/RBC.irnt.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 283472.673 1 0.0677 ld_1e-1_r_5e2/EUR/v1_reverse 0 0 0" 
  ##-----------------------------------------------------------------------------------------------

  ##Hb--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Hb_CAD/meta/result/ld_1e-1_r_5e2/EAS/v1_reverse
      qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/UVMR_reverse.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Hb CAD meta data/IV/IV.CAD.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/Hb/Hb.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 101091.644 1 0.0524 ld_1e-1_r_5e2/EAS/v1_reverse 0 0.512 0" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Hb_CAD/meta/result/ld_1e-1_r_5e2/EUR/v1_reverse
      qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/UVMR_reverse.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Hb CAD meta data/IV/IV.CAD.intersection.UKBB \
          /work_dir/data/summary_data/UKBB_NEALE/clean/Hb.irnt.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 283472.673 1 0.0677 ld_1e-1_r_5e2/EUR/v1_reverse 0 0 0" 
    #
  ##-----------------------------------------------------------------------------------------------

  ##Ht--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Ht_CAD/meta/result/ld_1e-1_r_5e2/EAS/v1_reverse
      qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/UVMR_reverse.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Ht CAD meta data/IV/IV.CAD.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/Ht/Ht.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 101091.644 1 0.0524 ld_1e-1_r_5e2/EAS/v1_reverse 0 0.512 0" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/Ht_CAD/meta/result/ld_1e-1_r_5e2/EUR/v1_reverse
      qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/UVMR_reverse.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          Ht CAD meta data/IV/IV.CAD.intersection.UKBB \
          /work_dir/data/summary_data/UKBB_NEALE/clean/Ht.irnt.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 283472.673 1 0.0677 ld_1e-1_r_5e2/EUR/v1_reverse 0 0 0" 
  ##-----------------------------------------------------------------------------------------------

  ##UA--------------------------------------------------------------------------------------------
    #EAS
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/UA_CAD/meta/result/ld_1e-1_r_5e2/EAS/v1_reverse
      qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/UVMR_reverse.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          UA CAD meta data/IV/IV.CAD.intersection.BBJ \
          /work_dir/data/summary_data/BBJ/UA/UA.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 101091.644 1 0.0524 ld_1e-1_r_5e2/EAS/v1_reverse 0 0.513 0" 

    #EUR
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/UA_CAD/meta/result/ld_1e-1_r_5e2/EUR/v1_reverse
      qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/UVMR_reverse.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/ \
          UA CAD meta data/IV/IV.CAD.intersection.UKBB \
          /work_dir/data/summary_data/UKBB_NEALE/clean/UA.irnt.sumstats.gz \
          CAD_CAD/meta/data/IV/pleio_signSNP_list \
          10000 100 1000 283472.673 1 0.0677 ld_1e-1_r_5e2/EUR/v1_reverse 0 0 0" 
    #
  ##-----------------------------------------------------------------------------------------------
##