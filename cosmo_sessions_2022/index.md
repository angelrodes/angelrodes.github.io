# MATLAB cosmo sessions 2022

<!--
> Draft of the sessions I will be delivering soon.
-->


> These sessions require some basic understanding of the MATLAB/Octave language. [Here](https://angelrodes.github.io/Matlab_for_Geoscientists/) you can find an introductory course. 

Online sessions on the usage and understanding of scripts that might be useful on the interpretation of cosmonuclide data.

We will go through some existing scripts to learn some useful methods to work with cosmo-related data in MATLAB/Octave.

Ángel Rodés, 2022 \
[angelrodes.com](https://angelrodes.wordpress.com/)

## Sessions

1. ICP-OES data reduction (24/01/2022)
    * [Slides](https://docs.google.com/presentation/d/e/2PACX-1vR2xctVePGAuNEMkh7fJjNJ69uUoh5nZGex0U1TH-QxE0nF8IKKNOoEAh2Gbm_p-8lJBGLnTZaS-mDF/pub?start=false&loop=false&delayms=3000)
    * Scripts: [ICPOES-datared](https://github.com/angelrodes/ICPOES-datared). Download all the files in the previous link.
    * These scripts are used to calibrate ICP-OES data using the data from all standards, to perform some quality checks, and output data in a useful format.
    * We will go through **ICPOESdatared_vXX.m** to understand how the script imports the data exported from Qtegra, performs the analyte calibrations and averages, plots results, and display results in a excel-friendly format.
2. Statistics (26/01/2022)
    * Scripts: [Cosmogenic Exposure Age Averages (CEAA)](https://github.com/angelrodes/CEAA) , [Cosmo-Ages Plotter (CAP)](https://github.com/angelrodes/CAP) and [Cosmo-Ages Sequence Calculator (CASC)](https://github.com/angelrodes/CASC).   Download all the files in the previous links.
    * We will learn how to produce [camelplots](https://cosmognosis.wordpress.com/2011/07/25/what-is-a-camel-diagram-anyway/), the different [methods to get age averages](https://angelrodes.wordpress.com/2020/12/07/cosmogenic-exposure-age-averages/) and identify outliers, and how to work with sequential ages in MATLAB.
3. Burial dating (31/01/2022)
    * [Working with constant and time-dependent production rates consistently](https://angelrodes.wordpress.com/2021/12/15/average-cosmogenic-production-rate-calculator/).
    * How to plot bananas in MATLAB. Script: [banana.m](https://raw.githubusercontent.com/angelrodes/angelrodes.github.io/main/cosmo_sessions_2022/banana.m).
    * Methods for calculating burial ages.

<!--
3. AMS raw data (tba)
    * Manipulating files and folders (*script coming soon*).
    * Input data from text files and organise it.
    * Plotting time series.
-->

<!--
AMS data
https://drive.google.com/drive/u/1/folders/1cMc5_PBexoFGcrwxKsTgQVXr8rYYqN36
cuenta elmonobueno
-->

<!--
https://doodle.com/poll/qtutiw26d286d26h?utm_source=poll&utm_medium=link
-->


