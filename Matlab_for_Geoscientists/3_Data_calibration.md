Data calibration
================

What is a calibration?
----------------------

**Calibrations**

Geochemical analysis often require calibrating a machine. A calibration
is a method that compares

-   Nominal values of something we consider *real* (e.g. known
    concentrations of Fe in a solution), and

-   Directly measured data (e.g. counts per second from an ICP machine)

To perform a calibration we usually need to measure a set of known
samples (standards) in a machine.

 

Our standards will be a group of samples (usually artificial) containing
no analyte (e.g a tube with water) or a known value of the analyte (e.g.
a tube with liquid containing 10.2 parts per million of iron). Standards
containing no analyte are usually called *blanks*, and the known values
are often called *nominal* data. Excepting the blanks, the nominal
values of the standards are expected to have an associated uncertainty
(e.g. [Fe]=10.2±0.1 ppm).

Also, the machine we are using will be probably repeating the
measurement on the same sample for 3 times or more. Therefore, the
measured data will also have an associated uncertainty, usually the
standard deviation of the measurements from the same sample.

Calibration tools
-----------------

**Plotting data with x and y errors**


The first thing we should do to start calibrating any data is compare it
graphically.

Create the script **my_first_calibration.m** and copy the following
ICP calibration data:

```Matlab
    % Nominal concentrations of iron in some standards
    STDSnominal=[0,0.98,4.56,10.78,19.34,0,1.05,5.1,9.94,18.95];
    % associated uncertainties
    STDSnominal_uncert=[0,0.02,0.06,0.11,0.19,0,0.02,0.06,0.10,0.19];
    % ICP measured values of standards in counts per second (cps)
    STDScps=[425,1724,7443,15221,30973,146,1832,7378,15124,27701];
    % associated uncertainties
    STDScps_uncert=[214,140,377,329,381,249,311,280,1129,1140];
```
 

The simplest way of representing these data with uncertainties is:

```Matlab
    x=STDSnominal;
    dx=STDSnominal_uncert;
    y=STDScps;
    dy=STDScps_uncert;

    figure
    hold on
    for n=1:length(x)
      plot([x(n),x(n)],[y(n)-dy(n),y(n)+dy(n)],'-b')
      plot([x(n)+dx(n),x(n)-dx(n)],[y(n),y(n)],'-b')
    end
    plot(x,y,'.b')
```

 

However, when we have both x and y uncertainties, the error bars do
not fully represent the probability distribution of the data in the 2-D
space. Assuming that σx and σy are independent (no
coviariance), the probability distribution at a point ( xi , yi )
can be defined by its Χ² value respect our data x, y,
σx and σy:

![image](https://latex.codecogs.com/gif.latex?\bg_black%20\chi^2=(\frac{x_i-x}{\sigma_x})^2+(\frac{y_i-y}{\sigma_y})^2)

Assuming that all the points with $\chi^2=1$ are at the one-sigma
confidence level boundary, we could solve the previous equation as:

![image](https://latex.codecogs.com/gif.latex?\bg_black%20x_i=x+\sigma_x%20\cdot%20\cos{(\theta)})

![image](https://latex.codecogs.com/gif.latex?\bg_black%20y_i=y+\sigma_y%20\cdot%20\sin{(\theta)})

being τ between 0 and 2*π (note that
![image](https://latex.codecogs.com/gif.latex?\bg_black%20\sin^2{(\theta)}+\cos^2{(\theta)})
 is always 1).
 

We can use this property to draw the ellipses corresponding to our data
within uncertainties:

```Matlab
    figure
    hold on
    for n=1:length(x)
      theta=linspace(0,2*pi,100);
      xi=x(n)+dx(n)*cos(theta);
      yi=y(n)+dy(n)*sin(theta);
      plot(xi,yi,'-b') % plot ellipse
    end
    plot(x,y,'+b') % plot central point
```

Note that ellipsis from samples with no uncertainty in one of the axis
(e.g. blanks) look exactly as error bars.

**Linear regression** 

A line is the simplest way of relating 2 sets of data (e.g. known
concentrations and signals given by a machine). One of the most used
methods to fit a line to our dataset is the "least-squares" regression.
This method minimizes the square of the distances between the line and
our data. Fortunately, there is a direct solution to solve this problem.
The general formulas to fit a line y=a*x+b to n data by
least-squares are:

![image](https://latex.codecogs.com/gif.latex?\bg_black%20a=%20\frac%20{n%20\cdot%20(\sum x_{i}y_{i})%20-%20(\sum x_{i})%20\cdot%20(\sum y_{i})}%20{n%20\cdot%20(\sum x_{i}^{2})%20-%20(\sum x_{i})^2})

 

In MATLAB/Octave, we can create the function `leastsquares.m` as:

```Matlab
    function [ myfit ] = leastsquares( x,y )
      a=(length(x)*sum(x.*y)-sum(x)*sum(y))/(length(x)*sum(x.^2)-sum(x)^2);
      b=(sum(x.^2)*sum(y)-sum(x)*sum(x.*y))/(length(x)*sum(x.^2)-sum(x)^2);
      myfit = @(x) a*x+b;
    end
```

and the average error of the data **calibrated** using `leastsquares`
will be:

```Matlab
    myfiterror= mean(abs(y-myfit(x))
```
 

*Exercises:*

-   Plot the ICP data above together with its linear fit.

-   Use this data to calibrate a measurement of 9000 cps.

-   How would you propagate the uncertainty of the calibration?


-   Does `myfiterror` fully represent the calibration uncertainty?

    *We have not used the uncertainties in our calculations!*

**Interpolation and smoothing** 

When we have a curve defined as y=f(x) we might be interested in
getting the xi value corresponding to a yi. This is the case of
the function `myfit(x)`, where x represent concentrations and y are
signals obtained by ICP. The function `leastsquares` is a line and it
would not be difficult to calculte the inverse function mathematically:

![image](https://latex.codecogs.com/gif.latex?\bg_black%20y=a%20\cdot%20x%20+%20b%20\Rightarrow%20x=(y-b)/a)

However, we often need to fill the gaps from *incomplete* datasets. For
example, the file `gistemp.csv` contains an estimate of global surface
temperature change every 5 years ([GISTEMP data](http://data.giss.nasa.gov/gistemp/)).


Create a new script,load the data and plot it:

```Matlab
    gistempdata=csvread('gistemp.csv',1,0);
    years=gistempdata(:,1);
    temp=gistempdata(:,2);

    figure
    hold on
    plot(years,temp,'*k')
```
 

If we want to estimate the global surface temperature change every year,
we need to interpolate the data. To do so, we can use the built-in
function `interp1`. By default `interp1(x,y,x0)` will return the linear
interpolation of the `x,y` dataset at `x0`. Try:

```Matlab
    myyears=min(years):1:max(years);
    mytemp=interp1(years,temp,myyears);
    plot(myyears,mytemp,'.-r')
```

*To avoid errors, the `x` values in `interp1(x,y,x0)` should be
sorted and not repeated. If your data is not sorted, you can use sort
the data using `sort`: `[x2,order]=sort(x); y2=y(order);`*


The linear interpolation is the default method used by `interp1`, so
`interp1(x,y,x0)` is equivalent to `interp1(x,y,x0,’linear’)`. But we
can use other methods, such as `’spline’`, or `’nearest’` to interpolate
our data. To see the differences, try:

```Matlab
    myyears=min(years):1:max(years);
    mytemp=interp1(years,temp,myyears,'spline');
    plot(myyears,mytemp,'.-b')
```

Apart of the method, we can ask `interp1` to also extrapolate data by
adding `’extrap’` after the method. If you want to know more about
`interp1`, type `help interp1`.

*Exercise: use extrapolation to predict the global surface temperature
change during the next century.*

 

In other cases, instead of increasing the resolution of our data, we
might be interested in *smoothing* it (e.g. to remove high frequency
noise). For example:

```Matlab
     smoothingtime=50;
     yearssmooth=1900:10:2000;
     for n=1:length(yearssmooth)
        % select data around the year yearssmooth(n)
        selecteddata=(abs(yearssmooth(n)-years)<smoothingtime/2);
        tempsmooth(n)=mean(temp(selecteddata));
     end
     plot(yearssmooth,tempsmooth,'-m')
```

This method is called "moving average".

*Exercise: extrapolate the smoothed temperatures to predict the global
surface temperature change during the next century.*

Spectrometry data
-----------------

**Blank Equivalent Concentration**

In spectrometry,the Blank Equivalent Concentration (BEC) is defined as
the concentration that would correspond to the signal of the blank. It
is usually determined by the following formula:

![image](https://latex.codecogs.com/gif.latex?\bg_black%20BEC%20=%20\frac{I_{blank}}{I_{standard}-I_{blank}}%20\cdot%20C_{standard})

being I the signals measured, usually in counts per second (cps), and
C the nominal concentration. Considering that we are going to be
working with datasets involving several standards, we can define the BEC
graphically as the negative of the x-intercept of our calibration line.


![Graphical calculation of the Blank Equivalent Concentration (BEC)
according to the calibration represented by the red
line.[]{label="bec"}](bec.pdf){#bec width="100%"}

Graphical calculation of the Blank Equivalent Concentration (BEC)
according to the calibration represented by the red
line.

 

The BEC gives us an idea of how the background level of our machine
compares with the measurements of our standards. We could think that a
low BEC value implies that our measurements are going to be more
precise. However, the precision of the measurements will depend on the
**stability** of the background rather than the background value.

 


![Two blank measurements compared. The measurements of the analyte \#1
in the blank show a lower background, but the background of the analyte
\#2 measurements is more
precise.[]{label="backgrounds"}](backgrounds.pdf){#backgrounds
width="100%"}

Two blank measurements compared. The measurements of the analyte #1
in the blank show a lower background, but the background of the analyte
#2 measurements is more
precise.

 

The stability of the background is what defines the precision of our
measurements, rather then the background value. Similarly, we should
calculate the variability of our BEC to get an idea of the noise of our
measurements in concentration units. There are different ways of
calculating the BEC "noise" (σBEC). We could just calculate it
based on the scatter of our blank data. However, this would not reflect
the scatter of our standards. The next figure shows the σBEC calculated from the
uncertainty of our calibration.

*Exercise: recycle the code generated before (calculation of
`myfiterror`) to calculate the *uncertainty* of the BEC corresponding to
the calibration data.* Tip: you can use maths to get the inverse
of `myfit` or use `interp1`.


![Graphical calculation of the Blank Equivalent Concentration (BEC) and
its uncertainty $\sigma_{BEC}$.[]{label="bec2"}](bec2.pdf){#bec2
width="100%"}

Graphical calculation of the Blank Equivalent Concentration (BEC) and
its uncertainty σBEC.

**Limits of detection and quantification**

The Limit of Detection (LOD) or Detection Limit is defined as the
smallest measurable concentration. It is the concentration of a
theoretical sample that will produce a signal strong enough to be
distinguishable from the background noise. Assuming that this signal is
going to have a noise similar to the background, the difference between
the signals from the sample and the blank should be bigger than two
times the noise. That is why the LOD is numerically defined as
LOD=3*noise. This is often calculated by calibrating the
concentration corresponding to Iblank+3*σIblank,
being σIblank the standard deviation of the intensities
measured on blank samples.

 

This approach assumes that our theoretical smallest measurable samples
will produce a signal as scattered as our blank. However, sometimes, the
measures of our samples are more similar to standards than to blanks
(e.g. due to matrix effects). This is why considering
LOD=3*σBEC would be a more conservative way of
calculating our LOD.

Likewise, the Limit of Quantification (LOQ) is usually defined as 10
times the blank noise, so the uncertainty associated with the lowest
sample that can produce quantitative data is $\sim 10$%. As for the LOD,
we can calculate the LOQ using the BEC uncertainty:
LOQ=10*σBEC.

**Calibrating data** 

Once we have calculated the algorithms that relate the ICP signal with
concentrations and concentration uncertainties, we are ready to
calibrate the signals from our "unknown samples" in our script
`my_first_calibration.m`:

```Matlab
    % ICP measured values of unknowns in counts per second (cps)
    SAMPLEScps=[9782,28746,13471,5870,28173,30492,13739,3588,813,12805];
    % associated uncertainties
    SAMPLEScps_uncert=[181,1042,1214,76,2899,2532,809,243,275,716];
```

To make this easier, we can define our calibration line as a reference
`xcal` and `ycal`:

```Matlab
    xcal=linspace(min(x),max(x),100);
    ycal=myfit(xcal);
```

and transform the signals `yunk` into concentrations `xunk` using
`interp1`:

```Matlab
    yunk=SAMPLEScps; dyunk=SAMPLEScps_uncert;
    xunk=interp1(ycal,xcal,yunk,'linear','extrap')
```

 

As the calibration is a line, we can also transform the measurement
uncertainties into concentrations using:

```Matlab
    measurementuncert=...
        ( interp1(ycal,xcal,yunk+dyunk,'linear','extrap')-...
          interp1(ycal,xcal,yunk-dyunk,'linear','extrap') )/2
```


The measurement uncertainty is the **internal uncertainty** of our data,
which is the errors we should use to compare our samples between them.
However, as usually we want to compare our data with data that has not
been calibrated simultaneously (e.g. samples measured one month ago), we
should also include the calibration uncertainty into the **external
uncertainty** (`dxunk`):

```Matlab
    calibrationuncert=...
      ( interp1(ycal,xcal,yunk+myfiterror,'linear','extrap')-...
        interp1(ycal,xcal,yunk-myfiterror,'linear','extrap') )/2
    dxunk=sqrt(calibrationuncert.^2+measurementuncert.^2);
```
 

Including the graphical representation of the unknown data, the script
**my_first_calibration.m** could be something similar to this:

```Matlab
    %% This is my first calibration script

    clear % clear all previous data
    close all hidden % close all figures

    % Nominal concentrations of iron in some standards
    STDSnominal=[0,0.98,4.56,10.78,19.34,0,1.05,5.1,9.94,18.95];
    % associated uncertainties
    STDSnominal_uncert=[0,0.02,0.06,0.11,0.19,0,0.02,0.06,0.10,0.19];
    % ICP measured values of standards in counts per second (cps)
    STDScps=[425,1724,7443,15221,30973,146,1832,7378,15124,27701];
    % associated uncertainties
    STDScps_uncert=[214,140,377,329,381,249,311,280,1129,1140];
    x=STDSnominal; dx=STDSnominal_uncert;
    y=STDScps; dy=STDScps_uncert;

    % ICP measured values of unknowns in counts per second (cps)
    SAMPLEScps=[9782,28746,13471,5870,28173,30492,13739,3588,813,12805];
    % associated uncertainties
    SAMPLEScps_uncert=[181,1042,1214,76,2899,2532,809,243,275,716];
    yunk=SAMPLEScps; dyunk=SAMPLEScps_uncert;

    %% Calibration and uncertainty
    myfit = leastsquares(x,y);
    myfiterror= mean(abs(y-myfit(x)));

    %% Calibration line
    xcal=linspace(min(x),max(x),100);
    ycal=myfit(xcal);
    ycalerror=myfiterror;

    %% BEC, LOD, LOQ
    bec=-interp1(ycal,xcal,0,'linear','extrap');
    dbec=interp1(ycal,xcal,myfiterror,'linear','extrap')+bec;
    LOD=3*dbec;
    LOQ=10*dbec;

    %% Calibrate unknowns
    xunk=interp1(ycal,xcal,yunk,'linear','extrap');
    calibrationuncert=...
      interp1(ycal,xcal,yunk+myfiterror,'linear','extrap')-xunk;
    measurementuncert=...
      interp1(ycal,xcal,yunk+dyunk,'linear','extrap')-xunk;
    dxunk=sqrt(calibrationuncert.^2+measurementuncert.^2);

    %% Start a figure
    figure
    hold on

    % plot the unknowns with error-bars
    for n=1:length(xunk)
      plot(xunk(n),yunk(n),'.k')
      plot([xunk(n)-dxunk(n),xunk(n)+dxunk(n)],[yunk(n),yunk(n)],'-k')
      plot([xunk(n),xunk(n)],[yunk(n)-dyunk(n),yunk(n)+dyunk(n)],'-k')
    end

    % plot the standards with ellipsis
    for n=1:length(x)
      theta=linspace(0,2*pi,100);
      xi=x(n)+dx(n)*cos(theta);
      yi=y(n)+dy(n)*sin(theta);
      plot(xi,yi,'-b')
    end
    plot(x,y,'.b')

    % plot the calibration
    plot(xcal,ycal,'-r')
    plot(xcal,ycal+myfiterror,'--r')
    plot(xcal,ycal-myfiterror,'--r')

    % put labels
    ylabel('Intensity (cps)')
    xlabel('Concentration (ppm)')
```
 

And the generated figure will be similar to this:

![Example of figure output of a calibration. Blanks and standards are
depicted in blue, unknowns in black and the calibration line within
uncertainty in
red.[]{label="calibrationfig"}](calibrationfig.pdf){#calibrationfig
width="100%"}

Example of figure output of a calibration. Blanks and standards are
depicted in blue, unknowns in black and the calibration line within
uncertainty in
red.

 


-   As you can see in the figure, the previous script overestimate the
    uncertainties of the lowest concentrations by considering
    `myfiterror` as a constant, where it should be a function of the ICP
    signal. Therefore, we obtain overestimated LOD and LOQs. You can try
    to improve the simplistic `mean(abs(y-myfit(x)))` with some other
    code.

-   Also, note that we have ignored the uncertainties of the calibration
    data `STDSnominal_uncert` and `STDScps_uncert`. We should also
    transmit those uncertainties in the external uncertainties. We could
    do that mathematically (calculating the partial derivatives for the
    formulas in the `leastsquares.m` function) or programmatically
    (fitting a large number of different lines with data generated using
    `normrnd `).

An example of a full propagation of uncertainties is shown in
`my_second_calibration.m`.

 


![Another example of calibration. Here, the scatter and the
uncertainties of the standards are fully
propagated.[]{label="calibrationfig2"}](calibration2.pdf){#calibrationfig2
width="100%"}

Another example of calibration. Here, the scatter and the
uncertainties of the standards are fully
propagated.

 

Finally, you can convert your script into a function that you can use in
the future to calibrate your own data:

```Matlab
    function [ SAMPLESppm SAMPLESppm_uncert] = calibfunction(STDSppm,STDSppm_uncert,...
                                                             STDScps,STDScps_uncert,...
                                                             SAMPLEScps,SAMPLEScps_uncert)

        % Paste here some of the code used in my_first_calibration
        %  - Remember no to paste the input data (STDSppm,SAMPLEScps, etc.)
        %  - Do not paste the plotting code unless you need it!

    end
```

**Reporting data with uncertainties**

At the end of our scripts we will probably want to include an easy way
of exporting the numerical results we obtained, like the concentrations
and uncertainties `xunk` and `dxunk`. The simplest way is by printing
what we want in the command window using the built in function `disp`.
As we want to mix our numerical parameters with strings, we will have to
use `num2str` to transform our numbers into strings.

 

```Matlab
    clc % clear the command window
    disp(['Blank equivalent concentration: ' num2str(bec) ' ppm'])
    disp(['Limit of detection: ' num2str(LOD) ' ppm'])
    disp(['Limit of quantification: ' num2str(LOQ) ' ppm'])
    disp(['Concentrations and uncertainties:'])
    for n=1:length(xunk)
      disp([num2str(xunk(n)) ' +/- ' num2str(dxunk(n))])
    end
111

*If we want to be able to paste our copy and paste our data in Excel, we
can replace `’±’` by the tab character `char(9)`.*

 

A common mistake when reporting data with errors is using more digits
than the significant figures. For example, the last numbers of 6.3976
from the data 6.3976±0.46537 are meaningless. A couple of
significant figures in the uncertainty is usually enough, so in our
report we should just write 6.40±0.47, as this distribution is
identical to 6.3976±0.46537. We can use `round` to trim useless
digits from our `mu±sigma` data:

```Matlab
    decimalpositions=1-floor(log10(sigma));
    newmu=round(mu,decimalpositions);
    newsigma=round(sigma,decimalpositions);
```

 

*Exercise:* Add the "reporting code" in `my_first_calibration.m` to:

-   Displays the concentrations below the LOD as "< *LOD* ppm".

-   Displays the concentrations below the LOQ as "~ *conc.* ppm".

-   Displays the concentrations above the LOQ "*conc.* ± *uncert.*
    ppm" using only their significant figures.

Exercise: ICP-OES data calibration
----------------------------------

**ICP-OES data calibration**

The file `ICPdata_GU20171012.csv` ([here](https://github.com/angelrodes/Matlab_for_Geoscientists/blob/main/files_and_scripts/ICPdata_GU20171012.csv?raw=true)) contains real raw ICP-OES data
exported from the ICP machine (one line per analyte in chronological
order) and an extra column with the nominal concentrations of the
standards in ppm.

Write a script that reduces the ICP-OES data and report calibrated
concentrations for each analyte.

![ICP-OES at
SUERC.[]{label="ICPOESmachine"}](ICPOESmachine.jpg){#ICPOESmachine
width="70%"}

ICP-OES at
SUERC.

**Tips**

Some useful functions that you might need:

-   `fopen` and `textscan` (see [previous session](https://angelrodes.github.io/Matlab_for_Geoscientists/2_Importing_data_and_Statistics)).

-   `STD=\simisnan(nominal)` select lines containing nominal values (the values in the `nominal` array are **not-not**-a-number).

-   `unique(analytename)` returns a list of unique values of `analytename`.

-   `strcmp(string, list_of_strings)` returns the positions of the `string` in the array `list_of_strings`. This is useful when you want to work with only the lines that refer to a specific analyte.

    E.g. inside this loop:

```Matlab
    for this_analyte=unique(analytename)’
        selectdata=strcmp(this_analyte, analytename);

        % ...and work with `selectdata` in here...

    end.
```
