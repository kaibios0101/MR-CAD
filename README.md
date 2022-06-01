# MR of Coronary Artery Disease

This repository includes scripts to reproduce the main results presented in the following paper:

Kai Wang, Xian Shi, Ziwei Zhu, Xingjie Hao, Liangkai Chen, Shanshan Cheng, Roger S. Y. Foo and Chaolong Wang*. Mendelian randomization analysis of 37 clinical factors and coronary artery disease in East Asian and European populations. *Genome Medicine*.

In the following sections, we will describe step by step how to reproduce the results. The scripts are placed into three directories. Please enter into each of these directories and run the scripts according to the description described below. **The scripts here are meant for reproduction of the results in the paper.**

## 1_data_preparation

Run the following scripts sequentially to download the raw GWAS summary statistics of each trait, tidy the summary data, and meta-analyze the summary data. **Specify the working directory at the start of each script.**

1. `1_GWAS_sumstats_EAS.sh`: download and process the raw GWAS summary statistics of East Asian population.
2. `1_GWAS_sumstats_EUR.sh`: download and process the raw GWAS summary statistics of European population.

- Here we utilize PBS/Torque scheduler to speed up the process. Users should modify the relevant commands so that they can be run on their own computer cluster.

3. `2_meta_EAS_EUR.sh`: meta-analyze the processed GWAS summary data from East Asian and European populations.

## 2_heritability_genetic_correlation

Run the following scripts sequentially to compute SNP-based heritability and genetic correlations among traits. **Specify the working directory at the start of each script.**

1. `1_heritability_EAS.sh`: compute SNP-based heritability of each trait in East Asian population.
2. `1_heritability_EUR.sh`: compute SNP-based heritability of each trait in European population.
3. `2_genetic_correlation_EAS.sh`: compute genetic correlations among traits in East Asian population.
4. `2_genetic_correlation_EUR.sh`: compute genetic correlations among traits in European population.

## 3_MR_analysis

Run the following scripts sequentially to select candidate instrumental variables (IVs), and perform univariable MR (UVMR) and multivariable MR (MVMR) analysis. **Specify the working directory at the start of each script**.

1. `1_candidate_IVs`: This directory includes corresponding codes to select candidate IVs for each risk factor (exposure).

   - `1_candidate_IVs_select.sh`: Shell script of selecting candidate IVs.
2. `2_UVMR`: This directory includes corresponding codes to perform univariable MR (UVMR) analysis.

   * `1_UVMR_qsub.sh`: Shell script of all UVMR analysis jobs and reverse UVMR analysis jobs.
3. `3_MVMR`: This directory includes corresponding codes to perform multivariable MR (MVMR) analysis.

   * `1_MVMR_qsub.sh`: Shell script of all MVMR analysis jobs.
