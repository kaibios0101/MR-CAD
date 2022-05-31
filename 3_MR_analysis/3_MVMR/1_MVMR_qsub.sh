################################################################
#  Descriptive: 
#    MVMR analysis (job list)
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

#mkdir directory
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/BMI_HbA1c_LDL_TG_SBP_Height_2_CAD/EAS/result
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/HbA1c_LDL_TG_SBP_Height_BMI_2_CAD/EAS/result
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/LDL_TG_SBP_Height_BMI_HbA1c_2_CAD/EAS/result
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/TG_SBP_Height_BMI_HbA1c_LDL_2_CAD/EAS/result
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/SBP_Height_BMI_HbA1c_LDL_TG_2_CAD/EAS/result
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_2_CAD/EAS/result
          
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/BMI_HbA1c_LDL_TG_SBP_Height_2_CAD/EUR/result
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/HbA1c_LDL_TG_SBP_Height_BMI_2_CAD/EUR/result
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/LDL_TG_SBP_Height_BMI_HbA1c_2_CAD/EUR/result
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/TG_SBP_Height_BMI_HbA1c_LDL_2_CAD/EUR/result
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/SBP_Height_BMI_HbA1c_LDL_TG_2_CAD/EUR/result
  mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_2_CAD/EUR/result
  

  for i in RBC Hb Ht UA
    do
      for j in EAS EUR
        do
        mkdir /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_${i}_2_CAD/${j}/result
      done
  done
##

#MVMR analysis
#BBJ
  #RBC
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_RBC_2_CAD/EAS/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp7_2_out.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              Height CAD meta/data/IV/IV.Height.intersection.BBJ \
              BMI meta/data/IV/IV.BMI.intersection.BBJ \
              HbA1c meta/data/IV/IV.HbA1c.intersection.BBJ \
              LDL meta/data/IV/IV.LDL.intersection.BBJ \
              TG meta/data/IV/IV.TG.intersection.BBJ \
              SBP meta/data/IV/IV.SBP.intersection.BBJ \
              RBC meta/data/IV/IV.RBC.intersection.BBJ \
              EAS CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/BBJ/Height/Height.sumstats.gz \
              /work_dir/data/summary_data/BBJ/BMI/BMI.sumstats.gz \
              /work_dir/data/summary_data/BBJ/HbA1c/HbA1c.sumstats.gz \
              /work_dir/data/summary_data/BBJ/LDL/LDL.sumstats.gz \
              /work_dir/data/summary_data/BBJ/TG/TG.sumstats.gz \
              /work_dir/data/summary_data/BBJ/SBP/SBP.sumstats.gz \
              /work_dir/data/summary_data/BBJ/RBC/RBC.sumstats.gz \
              /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
              MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_RBC_2_CAD/EAS/result/MVMR.results.csv \
              1.409 1.297 1.000 0.821 1.262 0.948 0.742"
  
  #Hb
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_Hb_2_CAD/EAS/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp7_2_out.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              Height CAD meta/data/IV/IV.Height.intersection.BBJ \
              BMI meta/data/IV/IV.BMI.intersection.BBJ \
              HbA1c meta/data/IV/IV.HbA1c.intersection.BBJ \
              LDL meta/data/IV/IV.LDL.intersection.BBJ \
              TG meta/data/IV/IV.TG.intersection.BBJ \
              SBP meta/data/IV/IV.SBP.intersection.BBJ \
              Hb meta/data/IV/IV.Hb.intersection.BBJ \
              EAS CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/BBJ/Height/Height.sumstats.gz \
              /work_dir/data/summary_data/BBJ/BMI/BMI.sumstats.gz \
              /work_dir/data/summary_data/BBJ/HbA1c/HbA1c.sumstats.gz \
              /work_dir/data/summary_data/BBJ/LDL/LDL.sumstats.gz \
              /work_dir/data/summary_data/BBJ/TG/TG.sumstats.gz \
              /work_dir/data/summary_data/BBJ/SBP/SBP.sumstats.gz \
              /work_dir/data/summary_data/BBJ/Hb/Hb.sumstats.gz \
              /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
              MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_Hb_2_CAD/EAS/result/MVMR.results.csv \
              1.409 1.297 1.000 0.821 1.262 0.948 0.707"

  #Ht
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_Ht_2_CAD/EAS/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp7_2_out.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              Height CAD meta/data/IV/IV.Height.intersection.BBJ \
              BMI meta/data/IV/IV.BMI.intersection.BBJ \
              HbA1c meta/data/IV/IV.HbA1c.intersection.BBJ \
              LDL meta/data/IV/IV.LDL.intersection.BBJ \
              TG meta/data/IV/IV.TG.intersection.BBJ \
              SBP meta/data/IV/IV.SBP.intersection.BBJ \
              Ht meta/data/IV/IV.Ht.intersection.BBJ \
              EAS CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/BBJ/Height/Height.sumstats.gz \
              /work_dir/data/summary_data/BBJ/BMI/BMI.sumstats.gz \
              /work_dir/data/summary_data/BBJ/HbA1c/HbA1c.sumstats.gz \
              /work_dir/data/summary_data/BBJ/LDL/LDL.sumstats.gz \
              /work_dir/data/summary_data/BBJ/TG/TG.sumstats.gz \
              /work_dir/data/summary_data/BBJ/SBP/SBP.sumstats.gz \
              /work_dir/data/summary_data/BBJ/Ht/Ht.sumstats.gz \
              /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
              MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_Ht_2_CAD/EAS/result/MVMR.results.csv \
              1.409 1.297 1.000 0.821 1.262 0.948 0.732"

  #UA
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_UA_2_CAD/EAS/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp7_2_out.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              Height CAD meta/data/IV/IV.Height.intersection.BBJ \
              BMI meta/data/IV/IV.BMI.intersection.BBJ \
              HbA1c meta/data/IV/IV.HbA1c.intersection.BBJ \
              LDL meta/data/IV/IV.LDL.intersection.BBJ \
              TG meta/data/IV/IV.TG.intersection.BBJ \
              SBP meta/data/IV/IV.SBP.intersection.BBJ \
              UA meta/data/IV/IV.UA.intersection.BBJ \
              EAS CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/BBJ/Height/Height.sumstats.gz \
              /work_dir/data/summary_data/BBJ/BMI/BMI.sumstats.gz \
              /work_dir/data/summary_data/BBJ/HbA1c/HbA1c.sumstats.gz \
              /work_dir/data/summary_data/BBJ/LDL/LDL.sumstats.gz \
              /work_dir/data/summary_data/BBJ/TG/TG.sumstats.gz \
              /work_dir/data/summary_data/BBJ/SBP/SBP.sumstats.gz \
              /work_dir/data/summary_data/BBJ/UA/UA.sumstats.gz \
              /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
              MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_UA_2_CAD/EAS/result/MVMR.results.csv \
              1.409 1.297 1.000 0.821 1.262 0.948 0.931"

  #Height
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/BMI_HbA1c_LDL_TG_SBP_Height_2_CAD/EAS/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              BMI CAD meta/data/IV/IV.BMI.intersection.BBJ \
              HbA1c meta/data/IV/IV.HbA1c.intersection.BBJ \
              LDL meta/data/IV/IV.LDL.intersection.BBJ \
              TG meta/data/IV/IV.TG.intersection.BBJ \
              SBP meta/data/IV/IV.SBP.intersection.BBJ \
              Height meta/data/IV/IV.Height.intersection.BBJ \
              EAS CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/BBJ/BMI/BMI.sumstats.gz \
              /work_dir/data/summary_data/BBJ/HbA1c/HbA1c.sumstats.gz \
              /work_dir/data/summary_data/BBJ/LDL/LDL.sumstats.gz \
              /work_dir/data/summary_data/BBJ/TG/TG.sumstats.gz \
              /work_dir/data/summary_data/BBJ/SBP/SBP.sumstats.gz \
              /work_dir/data/summary_data/BBJ/Height/Height.sumstats.gz \
              /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
              MVMR/v1/BMI_HbA1c_LDL_TG_SBP_Height_2_CAD/EAS/result/MVMR.results.csv \
              1.297 1.000 0.821 1.262 0.948 1.409"  

  #BMI
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/HbA1c_LDL_TG_SBP_Height_BMI_2_CAD/EAS/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              HbA1c CAD meta/data/IV/IV.HbA1c.intersection.BBJ \
              LDL meta/data/IV/IV.LDL.intersection.BBJ \
              TG meta/data/IV/IV.TG.intersection.BBJ \
              SBP meta/data/IV/IV.SBP.intersection.BBJ \
              Height meta/data/IV/IV.Height.intersection.BBJ \
              BMI meta/data/IV/IV.BMI.intersection.BBJ \
              EAS CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/BBJ/HbA1c/HbA1c.sumstats.gz \
              /work_dir/data/summary_data/BBJ/LDL/LDL.sumstats.gz \
              /work_dir/data/summary_data/BBJ/TG/TG.sumstats.gz \
              /work_dir/data/summary_data/BBJ/SBP/SBP.sumstats.gz \
              /work_dir/data/summary_data/BBJ/Height/Height.sumstats.gz \
              /work_dir/data/summary_data/BBJ/BMI/BMI.sumstats.gz \
              /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
              MVMR/v1/HbA1c_LDL_TG_SBP_Height_BMI_2_CAD/EAS/result/MVMR.results.csv \
              1.000 0.821 1.262 0.948 1.409 1.297"  

  #HbA1c
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/LDL_TG_SBP_Height_BMI_HbA1c_2_CAD/EAS/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              LDL CAD meta/data/IV/IV.LDL.intersection.BBJ \
              TG meta/data/IV/IV.TG.intersection.BBJ \
              SBP meta/data/IV/IV.SBP.intersection.BBJ \
              Height meta/data/IV/IV.Height.intersection.BBJ \
              BMI meta/data/IV/IV.BMI.intersection.BBJ \
              HbA1c meta/data/IV/IV.HbA1c.intersection.BBJ \
              EAS CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/BBJ/LDL/LDL.sumstats.gz \
              /work_dir/data/summary_data/BBJ/TG/TG.sumstats.gz \
              /work_dir/data/summary_data/BBJ/SBP/SBP.sumstats.gz \
              /work_dir/data/summary_data/BBJ/Height/Height.sumstats.gz \
              /work_dir/data/summary_data/BBJ/BMI/BMI.sumstats.gz \
              /work_dir/data/summary_data/BBJ/HbA1c/HbA1c.sumstats.gz \
              /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
              MVMR/v1/LDL_TG_SBP_Height_BMI_HbA1c_2_CAD/EAS/result/MVMR.results.csv \
              0.821 1.262 0.948 1.409 1.297 1.000"  

  #LDL
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/TG_SBP_Height_BMI_HbA1c_LDL_2_CAD/EAS/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              TG CAD meta/data/IV/IV.TG.intersection.BBJ \
              SBP meta/data/IV/IV.SBP.intersection.BBJ \
              Height meta/data/IV/IV.Height.intersection.BBJ \
              BMI meta/data/IV/IV.BMI.intersection.BBJ \
              HbA1c meta/data/IV/IV.HbA1c.intersection.BBJ \
              LDL meta/data/IV/IV.LDL.intersection.BBJ \
              EAS CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/BBJ/TG/TG.sumstats.gz \
              /work_dir/data/summary_data/BBJ/SBP/SBP.sumstats.gz \
              /work_dir/data/summary_data/BBJ/Height/Height.sumstats.gz \
              /work_dir/data/summary_data/BBJ/BMI/BMI.sumstats.gz \
              /work_dir/data/summary_data/BBJ/HbA1c/HbA1c.sumstats.gz \
              /work_dir/data/summary_data/BBJ/LDL/LDL.sumstats.gz \
              /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
              MVMR/v1/TG_SBP_Height_BMI_HbA1c_LDL_2_CAD/EAS/result/MVMR.results.csv \
              1.262 0.948 1.409 1.297 1.000 0.821"  

  #TG
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/SBP_Height_BMI_HbA1c_LDL_TG_2_CAD/EAS/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              SBP CAD meta/data/IV/IV.SBP.intersection.BBJ \
              Height meta/data/IV/IV.Height.intersection.BBJ \
              BMI meta/data/IV/IV.BMI.intersection.BBJ \
              HbA1c meta/data/IV/IV.HbA1c.intersection.BBJ \
              LDL meta/data/IV/IV.LDL.intersection.BBJ \
              TG meta/data/IV/IV.TG.intersection.BBJ \
              EAS CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/BBJ/SBP/SBP.sumstats.gz \
              /work_dir/data/summary_data/BBJ/Height/Height.sumstats.gz \
              /work_dir/data/summary_data/BBJ/BMI/BMI.sumstats.gz \
              /work_dir/data/summary_data/BBJ/HbA1c/HbA1c.sumstats.gz \
              /work_dir/data/summary_data/BBJ/LDL/LDL.sumstats.gz \
              /work_dir/data/summary_data/BBJ/TG/TG.sumstats.gz \
              /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
              MVMR/v1/SBP_Height_BMI_HbA1c_LDL_TG_2_CAD/EAS/result/MVMR.results.csv \
              0.948 1.409 1.297 1.000 0.821 1.262"  

  #SBP
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_2_CAD/EAS/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              Height CAD meta/data/IV/IV.Height.intersection.BBJ \
              BMI meta/data/IV/IV.BMI.intersection.BBJ \
              HbA1c meta/data/IV/IV.HbA1c.intersection.BBJ \
              LDL meta/data/IV/IV.LDL.intersection.BBJ \
              TG meta/data/IV/IV.TG.intersection.BBJ \
              SBP meta/data/IV/IV.SBP.intersection.BBJ \
              EAS CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/BBJ/Height/Height.sumstats.gz \
              /work_dir/data/summary_data/BBJ/BMI/BMI.sumstats.gz \
              /work_dir/data/summary_data/BBJ/HbA1c/HbA1c.sumstats.gz \
              /work_dir/data/summary_data/BBJ/LDL/LDL.sumstats.gz \
              /work_dir/data/summary_data/BBJ/TG/TG.sumstats.gz \
              /work_dir/data/summary_data/BBJ/SBP/SBP.sumstats.gz \
              /work_dir/data/summary_data/BBJ/CAD/hum0014_v21_CAD_v1/CAD.v21.sumstats.gz \
              MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_2_CAD/EAS/result/MVMR.results.csv \
              1.409 1.297 1.000 0.821 1.262 0.948"  
  #
##

#UKB
  for i in RBC Hb Ht UA
      do
      cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_${i}_2_CAD/EUR/result
      qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp7_2_out.pbs \
            -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
                Height CAD meta/data/IV/IV.Height.intersection.UKBB \
                BMI meta/data/IV/IV.BMI.intersection.UKBB \
                HbA1c meta/data/IV/IV.HbA1c.intersection.UKBB \
                LDL meta/data/IV/IV.LDL.intersection.UKBB \
                TG meta/data/IV/IV.TG.intersection.UKBB \
                SBP meta/data/IV/IV.SBP.intersection.UKBB \
                ${i} meta/data/IV/IV.${i}.intersection.UKBB \
                EUR CAD_CAD/meta/data/IV/pleio_signSNP_list \
                /work_dir/data/summary_data/UKBB_NEALE/clean/Height.irnt.sumstats.gz \
                /work_dir/data/summary_data/UKBB_NEALE/clean/BMI.irnt.sumstats.gz \
                /work_dir/data/summary_data/UKBB_NEALE/clean/HbA1c.irnt.sumstats.gz \
                /work_dir/data/summary_data/UKBB_NEALE/clean/LDL.irnt.sumstats.gz \
                /work_dir/data/summary_data/UKBB_NEALE/clean/TG.irnt.sumstats.gz \
                /work_dir/data/summary_data/UKBB_NEALE/clean/SBP.irnt.sumstats.gz \
                /work_dir/data/summary_data/UKBB_NEALE/clean/${i}.irnt.sumstats.gz \
                /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
                MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_${i}_2_CAD/EUR/result/MVMR.results.csv \
                1.000 1.000 1.000 1.000 1.000 1.000 1.000"
  done    

  #Height
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/BMI_HbA1c_LDL_TG_SBP_Height_2_CAD/EUR/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              BMI CAD meta/data/IV/IV.BMI.intersection.UKBB \
              HbA1c meta/data/IV/IV.HbA1c.intersection.UKBB \
              LDL meta/data/IV/IV.LDL.intersection.UKBB \
              TG meta/data/IV/IV.TG.intersection.UKBB \
              SBP meta/data/IV/IV.SBP.intersection.UKBB \
              Height meta/data/IV/IV.Height.intersection.UKBB \
              EUR CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/UKBB_NEALE/clean/BMI.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/HbA1c.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/LDL.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/TG.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/SBP.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/Height.irnt.sumstats.gz \
              /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
              MVMR/v1/BMI_HbA1c_LDL_TG_SBP_Height_2_CAD/EUR/result/MVMR.results.csv \
              1.000 1.000 1.000 1.000 1.000 1.000"  

  #BMI
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/HbA1c_LDL_TG_SBP_Height_BMI_2_CAD/EUR/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              HbA1c CAD meta/data/IV/IV.HbA1c.intersection.UKBB \
              LDL meta/data/IV/IV.LDL.intersection.UKBB \
              TG meta/data/IV/IV.TG.intersection.UKBB \
              SBP meta/data/IV/IV.SBP.intersection.UKBB \
              Height meta/data/IV/IV.Height.intersection.UKBB \
              BMI meta/data/IV/IV.BMI.intersection.UKBB \
              EUR CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/UKBB_NEALE/clean/HbA1c.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/LDL.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/TG.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/SBP.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/Height.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/BMI.irnt.sumstats.gz \
              /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
              MVMR/v1/HbA1c_LDL_TG_SBP_Height_BMI_2_CAD/EUR/result/MVMR.results.csv \
              1.000 1.000 1.000 1.000 1.000 1.000"   

  #HbA1c
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/LDL_TG_SBP_Height_BMI_HbA1c_2_CAD/EUR/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              LDL CAD meta/data/IV/IV.LDL.intersection.UKBB \
              TG meta/data/IV/IV.TG.intersection.UKBB \
              SBP meta/data/IV/IV.SBP.intersection.UKBB \
              Height meta/data/IV/IV.Height.intersection.UKBB \
              BMI meta/data/IV/IV.BMI.intersection.UKBB \
              HbA1c meta/data/IV/IV.HbA1c.intersection.UKBB \
              EUR CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/UKBB_NEALE/clean/LDL.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/TG.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/SBP.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/Height.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/BMI.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/HbA1c.irnt.sumstats.gz \
              /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
              MVMR/v1/LDL_TG_SBP_Height_BMI_HbA1c_2_CAD/EUR/result/MVMR.results.csv \
              1.000 1.000 1.000 1.000 1.000 1.000"   

  #LDL
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/TG_SBP_Height_BMI_HbA1c_LDL_2_CAD/EUR/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              TG CAD meta/data/IV/IV.TG.intersection.UKBB \
              SBP meta/data/IV/IV.SBP.intersection.UKBB \
              Height meta/data/IV/IV.Height.intersection.UKBB \
              BMI meta/data/IV/IV.BMI.intersection.UKBB \
              HbA1c meta/data/IV/IV.HbA1c.intersection.UKBB \
              LDL meta/data/IV/IV.LDL.intersection.UKBB \
              EUR CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/UKBB_NEALE/clean/TG.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/SBP.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/Height.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/BMI.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/HbA1c.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/LDL.irnt.sumstats.gz \
              /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
              MVMR/v1/TG_SBP_Height_BMI_HbA1c_LDL_2_CAD/EUR/result/MVMR.results.csv \
              1.000 1.000 1.000 1.000 1.000 1.000"   

  #TG
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/SBP_Height_BMI_HbA1c_LDL_TG_2_CAD/EUR/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              SBP CAD meta/data/IV/IV.SBP.intersection.UKBB \
              Height meta/data/IV/IV.Height.intersection.UKBB \
              BMI meta/data/IV/IV.BMI.intersection.UKBB \
              HbA1c meta/data/IV/IV.HbA1c.intersection.UKBB \
              LDL meta/data/IV/IV.LDL.intersection.UKBB \
              TG meta/data/IV/IV.TG.intersection.UKBB \
              EUR CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/UKBB_NEALE/clean/SBP.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/Height.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/BMI.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/HbA1c.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/LDL.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/TG.irnt.sumstats.gz \
              /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
              MVMR/v1/SBP_Height_BMI_HbA1c_LDL_TG_2_CAD/EUR/result/MVMR.results.csv \
              1.000 1.000 1.000 1.000 1.000 1.000"   

  #SBP
    cd /work_dir/project/doctoral_project/MR/MR_BBJ_UKBB/MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_2_CAD/EUR/result
    qsub /work_dir/project/doctoral_project/MR/MR_BCX/run_script/MVMR_exp6_2_out_v4-1b.pbs \
          -F "/work_dir/project/doctoral_project/MR/MR_BBJ_UKBB \
              Height CAD meta/data/IV/IV.Height.intersection.UKBB \
              BMI meta/data/IV/IV.BMI.intersection.UKBB \
              HbA1c meta/data/IV/IV.HbA1c.intersection.UKBB \
              LDL meta/data/IV/IV.LDL.intersection.UKBB \
              TG meta/data/IV/IV.TG.intersection.UKBB \
              SBP meta/data/IV/IV.SBP.intersection.UKBB \
              EUR CAD_CAD/meta/data/IV/pleio_signSNP_list \
              /work_dir/data/summary_data/UKBB_NEALE/clean/Height.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/BMI.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/HbA1c.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/LDL.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/TG.irnt.sumstats.gz \
              /work_dir/data/summary_data/UKBB_NEALE/clean/SBP.irnt.sumstats.gz \
              /work_dir/data/summary_data/FinnGen/IHD/meta.CAD.C4D.FinG.sumstats.gz \
              MVMR/v1/Height_BMI_HbA1c_LDL_TG_SBP_2_CAD/EUR/result/MVMR.results.csv \
              1.000 1.000 1.000 1.000 1.000 1.000"   
  ##
##
