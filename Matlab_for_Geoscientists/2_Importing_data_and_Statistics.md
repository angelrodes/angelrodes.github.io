Importing data & Statistics
===========================

**Import functions**

We can import our data in many ways. There are lots of built-in
functions that can be used to input data from different file types and
different formats: `input`, `importdata`, `load`, `xlsread`, `imread`,
`geotiffread`, `arcgridread`, `usgsdem`, etc. Here we will learn some of
the simplest and more universal ways of doing it: using `csvread`,
`textscan` and directly pasting data in a dialog box with `inputdlg`.

Importing .csv files
--------------------

**.csv files**

CSV stands for "comma-separated values". CSV files are text files widely
used to store tabular data in a simple format. All spreadsheet
manipulation programs, as Microsoft Excel, are able to import and export
CSV files. Each line in a CSV file corresponds to a row in a
spreadsheet. Values from different columns are separated by commas.

![image](https://user-images.githubusercontent.com/53089531/131827040-76767a47-a523-4951-85ee-eeeced24de81.png)
You can download this file [here](https://github.com/angelrodes/Matlab_for_Geoscientists/blob/main/files_and_scripts/munros_lon_lat_feet.csv?raw=true) (right click > Save Link As...)

`csvread(filename, row, col)` reads data from the comma-separated value
formatted file starting at the specified row and column. The row and
column arguments are zero based, so that row=0 and col=0 specify the
first value in the file.

Note that only numeric data can be read using `csvread`. For example,
the file `munros_lon_lat_feet.csv` ([here](https://github.com/angelrodes/Matlab_for_Geoscientists/blob/main/files_and_scripts/munros_lon_lat_feet.csv?raw=true)) contains text and data:

```
  -------------- ----------- ----------- ------
  Name,          long,       lat,        feet
  Ben Nevis ,    -5.00352,   56.79697,   4409
  Ben Macdui ,   -3.6691,    57.07042,   4295
  Braeriach ,    -3.72885,   57.07824,   4252
  Cairn Toul ,   -3.71092,   57.05432,   4236
  ...            ...         ...         ...
  -------------- ----------- ----------- ------
```

So the orders `csvread(’munros_lon_lat_feet.csv’,0,0)` does not work or
do not import the Munros' names. To import the numerical data from this
file we should use: `munrodata=csvread(’munros_lon_lat_feet.csv’,1,1)`

Importing data from text files using `fopen` and `textscan`
-----------------------------------------------------------

**`fopen` and `textscan`**

We can import tabulated data, including text strings, from any text
file. To do so, we need to know how many rows with headers are in the
file (in this case: `1`) , what is the symbol that delimiters the
columns (in this case: `,` ), and the type of data in the different
columns. In this case, the first column contains text (`%s` for
*string*) and the three next columns contain numbers (`%f` for
*floating-point number*):

```Matlab
    fid = fopen('munros_lon_lat_feet.csv');
    munrodata = textscan(fid, '%s %f %f %f',...
       'HeaderLines', 1,'Delimiter',',');
    fclose(fid);
```

Once imported our data, we can organize it in different arrays:

```Matlab
    names=munrodata{1};
    lon=munrodata{2};
    lat=munrodata{3};
    feet=munrodata{4};
```

Input dialog
------------

**Dialogs**

We can also input our data copied from a spreadsheet (like Excel) using
`inputdlg` as a string and then convert it into a matrix using
`textscan`:

```Matlab
    cstr = inputdlg ('Paste from excel','Input new data');
    mydata=textscan(cstr{1}, '%s %f %f %f');
```

When using this method to input data remember that:

-   The **text strings** (usually sample names) **should not contain
    spaces** or certain symbols.

-   **Avoid empty cells**: you can use a `0` or `NaN` instead.

-   You should only copy rows with data. Avoid copying the headers.

The normal distribution
-----------------------

**Gaussian distribution**

Most analytical data are considered **Gaussian (or normal)
distributions**. This means that the true value of whatever we
are measuring could be equally higher or lower that the measured central
value (the data) and its probability is:

![image](https://latex.codecogs.com/gif.latex?\bg_white%20P=\frac{1}{\sqrt{2\pi\sigma^2}}%20\cdot%20e^{-\frac{(x-\mu)^2}{2\sigma^2}})

where x are the possible values, μ is the central value (the
mean), and σ is the uncertainty (the standard deviation).


![image](https://user-images.githubusercontent.com/53089531/131827714-459b3e5d-3919-46ff-936d-cdb304d3bfe2.png)

For the normal distribution, the values less than one standard
deviation away from the mean account for 68.27% of the set; while two
standard deviations from the mean account for 95.45%; and three standard
deviations account for 99.73%. Author: Dan Kernler, [Wikipedia](https://en.wikipedia.org/wiki/Normal_distribution).

Create a function called **normalprobs.m** that calculates the
probabilities of an array x, given a piece of data as μ±σ:

```Matlab
    function [P]=normalprobs(x,mu,sigma) 
      % Calculates the probability of x based on a gaussian mu +/- sigma
      P=1/(2*pi*sigma^2)^0.5*exp(-(x-mu).^2./(2*sigma^2));
    end
```

Then compare the following plots:

-   `hist(normrnd(56,15,1,1000))`

-   `plot(1:100,normalprobs(1:100,56,15))`

Calculating the average
-----------------------

**Averages**

Geochronologists often produce a set of ages to date one geologic event.
**Each of these ages are always the result of fitting a model** to the
analytical data, usually some concentration(s) in a rock or mineral.
Generally, the relatively simple models used to generate "standard\"
ages are based in assumptions on how the nature works. But the processes
that rule the concentrations in nature are always much more complicate
than assumed by our model. Thus, we should always expect some scatter in
our apparent ages due to this natural "noise\". However, in principle we
don't known how much scatter can we attribute to the differences between
the nature and our model.


As we have seen before, any analytical data has also associated some
uncertainty related to the precision of our measurements (the error
bars). This **known** uncertainty should also contribute to the scatter
of our data.

Before calculating the average of our ages, we should understand what
kind of uncertainty will dominate our averaged age. If we don't have
many samples, a simple way of checking this is just plotting our ages.
If we have a large dataset, we can also compare our scatter with our
individual uncertainties using `std`(ages) and `median`(errors).


For example:

```Matlab
    %% Group opf ages from LGM moraines
    ages=[27311,18071,19698,19868,25357,21515,19486,18784,19311,...
          14342,19412,18064,18554,18092,18194,19647,19390,18634,...
          19900,18069];
    errors=[8839,2263,1893,1780,1568,2754,2720,2516,1414,1265,...
            2239,1389,3249,1287,1385,1323,1482,2044,1787,3392];
    %% Plot ages
      figure % start a new figure
      hold on % keep all plotted elements
      for n=1:length(ages)
        % plot the error line
        plot([n,n],[ages(n)-errors(n),ages(n)+errors(n)],'-b')
        % plot the central data 
        plot(n,ages(n),'.b') 
      end
    %% Calculations
      SCATTER=std(ages)
      ANALYTICAL_UNCERT=median(errors)
```

Comparing scatter and analytical uncertainties, we can decide which is
the best way of averaging our data:

-   If scatter is much bigger (orders of magnitude) than our analytical
    errors, we can just ignore the analytical uncertainties.

-   If the scatter is about the same or a few times bigger than the
    analytical errors, our final age should reflect both the analytical
    and model uncertainties.

-   If the scatter is much smaller than the analytical errors, we are
    probably overestimating our analytical uncertainties. We should
    check our previous calculations.

Types of "averages"
--------------------

**Average of a group of numbers**

The most used type of average is the mean: `mean(ages)`, which is the
same as `sum(ages)/length(ages)`. The uncertainty of the mean is the
standard deviation: `std(ages)`, which is

```Matlab
     sqrt(sum((ages-mean(ages)).^2)/(length(ages)-1))
```

The Standard Deviation Of the Mean (SDOM) gives us an idea of how the
mean can change with new measurements:

```Matlab
     std(ages)/sqrt(length(ages))
```

**The SDOM** is often used as the uncertainty of a large number of
analytical measurements on the same material, but **it does not reflect
the uncertainty related to the natural variability expected in a group
of ages from the same geological formation**.

In large datasets containing extreme values, the median could also be a
good choice to represent the data: `median(ages)`. The median is less
affected by outliers than the mean, and is often the preferred measure
of central tendency when the distribution is not symmetrical. As for the
mean, we can calculate its uncertainty as:

```Matlab
     sqrt(sum((ages-median(ages)).^2)/(length(ages)-1))
```

For analytical data, the standard deviation of the median is considered
to be a ~25 higher than the SDOM.

**Average of a group of numbers and uncertainties**

When our data consist of a group of
probability distributions (e.g. ages and errors), we should take into
account the errors in the calculation of the average. If our data have
different errors, the data with bigger errors should *weight* less than
the more precise data. To take this into account, we can use the
**weighted mean**:

```Matlab
     WM=sum(ages./errors.^2)/sum(1./errors.^2)
```


The standard deviation of the weighted mean (SDOWM) average can be
calculated as:

```Matlab
     SDOWM=sqrt(1/sum(1./errors.^2))
```

However, the SDOWM only reflects the uncertainty from the individual
errors and not the scatter of the data. A more realistic uncertainty
could be calculated as:

```Matlab
     sqrt(std(ages)^2+SDOWM^2)
```


An alternative method to calculate the average and uncertainty of a
group of ages and errors is actually simulating their probability
distributions:

```Matlab
    simulations=1000;
    % create a matrix to place data
    fakedata=zeros(simulations,length(ages));
    for n=1:simulations
      % fill each line with random data
      % based on individual ages and errors
      fakedata(n,:)= normrnd(ages,errors);
    end
    MEAN=mean(fakedata(:))
    % note that (:) converts a matrix into an array
    UNCERTAINTY=std(fakedata(:))
    hist(fakedata(:),30) % plot the fake data
```

Error transmission
------------------

**Error transmission**

Simulating the dispersion of the data by generating "fake data"
according to gaussian distributions is great trick to operate with
probabilistic data, getting a density distribution of the result.
However, when the following conditions are met, it is much more
efficient to propagate errors mathematically.

-   All operators (e.g. analytical data) are well-modeled by **gaussian
    distributions**.

-   We are considering uncertainties of **independent variables** (no
    covariance).

-   The **uncertainty of the result** is small enough to be well
    represented by a normal distribution (i.e. the result is roughly
    lineal in the area of the uncertainty and therefore the resulting
    distribution is **not asymmetrical**).

 
If we can assume these conditions, the error propagation should be
performed by considering the partial derivatives of the result respect
the operators:

![image](https://latex.codecogs.com/gif.latex?\sigma_{f(a,b)}%20=%20\sqrt{\left(%20\sigma_a%20\frac{\delta%20f(a,b)}{\delta%20a}\right)%20^2+\left(%20\sigma_b%20\frac{\delta%20f(a,b)}{\delta%20b}\right)%20^2})

where a±σa and b±σb are the operators within a
standard deviation (one sigma) uncertainties. 

Here are some examples on common operations:

![image](https://user-images.githubusercontent.com/53089531/131828031-ba2270dc-a01e-4eb1-80c9-0857b4260f51.png)


Rejecting outliers
------------------

**Rejecting outliers**

In statistics, an outlier is a data point that differs significantly
from other observations.

A simple method to identify outliers is using the Tukey's fences based
on the data quartiles. This method identify outliers at deviations
outside the range from Q1-1.5*(Q3-Q1) to
Q3+1.5*(Q3-Q1). We can calculate this limits using the built-in
function `quantile`:

```Matlab
    Q1=quantile(ages,0.25);
    Q3=quantile(ages,0.75);
    outliers=ages(ages<(Q1-1.5*(Q3-Q1)) | ages>(Q3+1.5*(Q3-Q1)))
```


Other approaches commonly used to identify outliers are based on the
goodness of fit. A simple way of measuring how close are our
measurements to our mean is the Χ² value:

![image](https://latex.codecogs.com/gif.latex?\chi^{2}=\left(\frac{x-\bar{x}}{\sigma}\right)^{2})

Using ![image](https://latex.codecogs.com/gif.latex?\sigma=\sqrt{\sigma_{x}^2+\sigma_{\bar{x}}^2}) we can calculate
the individual values of Χ² considering all our uncertainties.
Values of Χ² greater than 1 indicate that the two values we are
comparing, the individual data and our average, are different within
uncertainties.  


*Exercise: Use the Χ² method to identify outliers of the ages
respect their weighted mean and standard deviation of the weighted
mean.*

*In geosciences (e.g. studying a set of ages from a landform), outliers
are often due to the natural variability of the samples and not to
experimental errors. Therefore, **when rejecting an outlier we are
expected to give an explanation of the geological process that caused
that outlier**.*

Box plots
---------

**Box plots**

A common way of representing a dataset is using box plots. The data is
usually represented along the *y* axis, a box is drawn from Q1 to
Q3. The box is cut at the median (=Q2) and error bars are drawn
outside the box between the limits defined in section "outliers".

![image](https://user-images.githubusercontent.com/53089531/131828578-1d5c246e-9208-4892-a142-b7905c476d86.png)

In a box-plot, the inter-quartile range (IQR) is defined by the
distance between the first and third quartile Q1 - Q3, so 50% of
our data are in the IQR, 25% is over Q3 and the rest 25% is under
Q1.


This code produces a box-plot of the given ages:

```Matlab
    %% my data
    ages=[27311,18071,19698,19868,25357,21515,19486,18784,19311,...
          14342,19412,18064,18554,18092,18194,19647,19390,18634,...
          19900,18069];
    %% calculate the cuartiles
    Q1=quantile(ages,0.25);
    Q2=median(ages);
    Q3=quantile(ages,0.75);
    maxbar=Q3+1.5*(Q3-Q1);
    minbar=Q1-1.5*(Q3-Q1);
    outliers=ages(ages<minbar | ages>maxbar);

    %% start a figure
    figure
    hold on
    %% plot box at position x=2 and a width of 0.3
    plot([2-0.3,2+0.3],[Q1,Q1],'-k')
    plot([2-0.3,2+0.3],[Q2,Q2],'-k')
    plot([2-0.3,2+0.3],[Q3,Q3],'-k')
    plot([2-0.3,2-0.3],[Q1,Q3],'-k')
    plot([2+0.3,2+0.3],[Q1,Q3],'-k')
    plot([2,2],[Q3,maxbar],'-k')
    plot([2,2],[Q1,minbar],'-k')
    plot([2-0.15,2+0.15],[minbar,minbar],'-k')
    plot([2-0.15,2+0.15],[maxbar,maxbar],'-k')
    plot(ones(size(outliers))*2,outliers,'.k')
    % ones(size(outliers) is used because
    % in principle we do not know the size of 
    % the outliers array
    %% beautify the axis
    xlim([0 4])
    set(gca,'xtick',[]) % remove x ticks
    ylim([0 max(ages)*1.5])
    ylabel('age')
    box on % draw upper and right lines
```
 
*Exercise: Write a function that draws the box plot at a given x
position and box width. Make the width of the caps half the width of the
box. The input should be:* `drawboxplot(data,x,width)`

*Then use the function to compare the altitudes of the eastern and
western munros from previous section.*

*Remember that you can recycle code using copy & paste!*

Histograms
----------

**Histograms**

Another way of visualizing a the distribution of a large dataset is
plotting an histogram (e.g. `hist(ages)`). We can select the number of
"bars" to plot: `hist(feet,30)`. We can also use the built-in function
`hist` to generate the counting data and plot it using `plot`:

```Matlab
    figure
    [counts,centers] = hist(feet,20);
    plot(centers,counts,'*-r')
```

*Exercise: Compare graphically the mean + standard deviation, the box
plot and the histogram of these data. Which one reflect better the
variability of our ages?*

Camel-plots
-----------

**Camel-plots**

When our data have associated errors (like our `ages` and `errors`), the
histogram does not represent the relative weight of our individual data.
The probability distribution of the age 12000±1500 can be depicted
using the function defined in previous section:

```Matlab
    % Define the x values to plot
    xref=linspace(0,50000,500);
    % calculate the probability distribution
    probs=normalprobs(xref,12000,1500);
    % plot
    figure
    hold on
    plot(xref,probs,'-b')
```

*Exercise: Write a script that sum all the probabilities of the
previously defined ages for each xref and plot it.* The plot of this sum
should look similar to the blue line in the next figure.

The generated plot show the density of our data better than the
histogram. These plots are sometimes called "probability density plots".
However, these diagrams represent the distribution of our data, that
highly depends on how we selected the samples. Therefore, they do not
necessarily represent the probability distribution of the landform age
and, according to Greg Balco, they should be called "normal kernel
density estimates."

![image](https://user-images.githubusercontent.com/53089531/131828809-99a8876d-7c4c-4d3a-895f-db1faba5b395.png)

The plot of the sum of probability distributions from our data is
often called camel plot or [camel diagram](https://cosmognosis.wordpress.com/2011/07/25/what-is-a-camel-diagram-anyway/).
