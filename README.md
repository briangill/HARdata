#Coursera Getting and Cleaning Data Project: Human Activity Recognition Using Smartphones

The goal of this project was to download and clean a dataset on Human Activity Recognition Using Smartphones, processing the data into a tidy dataset.

A description of the data for the project and its source can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, and the actual raw data can be downloaded as a zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

This repo contains four files:
* **README.md**: This file.
* [**HAR_summary.txt**](https://github.com/briangill/HARdata/HAR_summary.txt): The final tidy dataset.
* [**CodeBook.md**](https://github.com/briangill/HARdata/CodeBook.md): A codebook describing the variables in the final dataset, the source of the data, basic details of the study design, and details of how the data were processed.
* [**run_analysis.R**](https://github.com/briangill/HARdata/run_analysis.R): An R script which performs all steps to download and process the raw data to produce the final tidy dataset.

To reproduce the process of downloading and cleaning the data, all that needs to be done is to source the file [run_analysis.R](https://github.com/briangill/HARdata/run_analysis.R) in R. The script will perform the entire process of downloading the raw data, storing it in the R working directory, unzipping the file, loading all necessary data into R, and processing it to create the file HAR_summary.txt, which will be saved in the working directory. **Note:** The R script makes use of the **dplyr** package, which must be installed prior to running the script.