# MATLAB cosmo sessions 2022

> Draft of the sessions I will be delivering soon.

Online sessions on the usage and understanding of scripts that might be useful on the interpretation of cosmonuclide data.

We will go through some existing scripts to learn some useful methods to work with cosmo-related data in MATLAB/Octave.

These sessions require some basic understanding of MATLAB/Octave language. [Here](https://angelrodes.github.io/Matlab_for_Geoscientists/} you can find an introductory course. 

Ángel Rodés, 2022 \
[angelrodes.com](https://angelrodes.wordpress.com/)

## Sessions

1. ICP-OES data reduction
    * Scripts: [ICPOES-datared](https://github.com/angelrodes/ICPOES-datared). Download all the files in the previous link.
    * These scripts are used to calibrate ICP-OES data using the data from all standards, to perfrom some quality checks, and output data in a useful fromat.
    * We will go through **ICPOESdatared_vXX.m** to understand how the script imports the data exported from Qtegra, performs the analyte calibrations and averages, plots results, and diplay results in a excel-friendly format.
2. Statistics
    * Scripts: [Cosmogenic Exposure Age Averages (CEAA)](https://github.com/angelrodes/CEAA) and [Cosmo-Ages Sequence Calculator (CASC)](https://github.com/angelrodes/CASC).   Download all the files in the previous links.
    * We will learn how to produce camelplots, the different [methods to get age averages](https://angelrodes.wordpress.com/2020/12/07/cosmogenic-exposure-age-averages/) and identify outliers, and how to work with sequential ages in MATLAB.
3. Burial dating
    * [Working with constant and time-dependent production rates consitently](https://angelrodes.wordpress.com/2021/12/15/average-cosmogenic-production-rate-calculator/).
    * How to plot bananas in MATLAB (*script coming soon*).
    * Methods for calculating burial ages.
3. AMS raw data
    * Manipulating files and folders.
    * Input data from text files and organizing it.
    * Plotting time series.
