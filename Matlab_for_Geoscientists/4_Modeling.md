Modeling
========

**Numerical models**

Numerical models are widely used to solve physical or chemical problems
by describing processes using equations and numbers.

We can generally describe a numerical model as $y=F(x)$, where $x$ are
the causes of the process, $F$ are the algorithms that describe the
process, and $y$ are the consequences of the process.

In Earth Sciences, we typically *know* the consequences ($y$) of the
process we are studying (e.g. a concentration of something as a result
of time, that will be the main *cause* in a geochronology problem), and
we want to know the causes $x$. Therefore, finding or approximating the
inverse model $x=F'(y)$ would be very useful for our purposes.

The way we solve a problem involving numerical models will depend on
whether or not we can find or approximate the inverse model.

Forward problem
---------------

**Forward problem**

Forward models as $y=F(x)$ are used to make informed predictions.
However, when we can find the inverse of our model $x=F'(y)$, we can
solve our problem directly.

In geochronology, this $x=F'(y)$ typically means expressing the *true
age* of a sample as a function of concentrations and other known
parameters.

Mathematically, a forward problem is a *well-posed problem*, where a
unique solution exists and the solutions change continuously with the
known parameters.

**Radiocarbon calibration**

A good example of a forward problem is the calculation of a calibrated
$^{14}$C age from an apparent $^{14}$C age, as the $^{14}$C ages
calculated in the slide
[\[radiocarbon\_function\]](#radiocarbon_function){reference-type="ref"
reference="radiocarbon_function"}.

Apparent radiocarbon ages are calibrated using calibration lines. You
can download the data corresponding to a calibration line from here:\
https://journals.uair.arizona.edu/index.php/radiocarbon/article/downloadSuppFile/16947/275\
You should get a file called `16947-25973-2-SP.14c`. Save it in your
working folder and open it as text: you will find out that is a comma
separated file (csv).

 \
If we have a radiocarbon age (e.g. $2000\pm20$), we should be able to
create a script to calibrate the entire probability distribution of the
age (see slide [\[gauss\_slide\]](#gauss_slide){reference-type="ref"
reference="gauss_slide"}) along the calibration curve using `interp1`
and produce an output like this:\
![image](C14calibration.pdf){width="100%"} (code in the next slides)

    %% import calibration curve
    fid = fopen('16947-25973-2-SP.14c');
    imported = textscan(fid, '%f %f %f %f %f',...
    'HeaderLines', 12,'Delimiter',',');
    fclose(fid);

    % select the data from the calibnration curve
    calBP=imported{1};
    C14=imported{2};

    %% interpolate calibration curve to arrays of 1 position per calibrated year
    refcalBP=min(calBP):1:max(calBP);
    refC14=interp1(calBP,C14,refcalBP);

    %% input our data
    C14age=2000;
    C14ageerr=20; % one sigma error

    % calculate probabilities of my data
    C14probs=normalprobs(refC14,C14age,C14ageerr);

        %% Plot the calibration curve and our data
        % select only the "most" probable data to plot
        sel=(C14probs>max(C14probs)/1000);
        
        figure % start figure
        % plot the part of the calibration curve that is relevent for us
        subplot(3,3,[2 6])
        plot(refcalBP(sel),refC14(sel))
        title('Calibration curve')
        
        % plot our data
        subplot(3,3,[1 4])
        plot(C14probs(sel),refC14(sel))
        ylabel('C14 age')
        xlabel('P')
        
        % plot the data calibrated
        subplot(3,3,[8 9])
        plot(refcalBP(sel),C14probs(sel)) 
        xlabel('calibrated C14 age')
        ylabel('P')

 \
Note that:

-   We are ignoring the uncertainty of the calibration curve
    (`imported{3}`). To know how to incorporate all the errors, check
    the script "MatCal" by Lougheed & Obrochta (2016):\
    http://dx.doi.org/10.5334/jors.130

-   To represent several subplots in the same window we are using
    `subplot(r,c,[a b])`, where `r` and `c` are the number of rows and
    columns, and `a` and `b` are corners of the area where we want to
    plot. E.g. `subplot(3,4,[7 12])` would start plotting in the blue
    area:\
    ![image](subplots.png){width="20%"}

Inverse problem
---------------

**Inverse problem**

Sometimes it is not possible to express our problem as $x=F'(y)$,
because sometimes it is impossible to get the inverse of $F(x)$.

Most geochemical models used in geochronology allow the calculation of a
theoretical concentration or measurable signal $C$ as a function of time
$t$ and other parameters: $C=f(t,C_0,...)$. However, some of these
problem cannot be solved for $t=f(C,C_0,...)$. In this cases, we will
need to *guess* the age $t$ corresponding to our known concentrations
$C,C_0$, etc.

**Ill-posed problem**

Mathematically, this kind of problems are often *ill-posed problems*.
Therefore, we cannot assume that they have a unique solution and we
should check the sensitivity of our results to a change in our known
parameters.

In geochronology, this means that apart of answering the main question:

> Which ages are compatible with my data?

but we should also answer the question:

> Which ages are **not** compatible with my data?

Cosmogenic depth-profile dating
-------------------------------

**Cosmogenic depth-profile dating**

The accumulation of $^{10}$Be under a sedimentary surface depends on the
inherited $^{10}$Be concentration ($C_0$), the different $^{10}$Be
production rates ($P_{sp.}$, $P_{f\mu}$ and $P_{\mu^-}$) and attenuation
lengths ($\Lambda_{sp.}$, $\Lambda_{f\mu}$ and $\Lambda_{\mu^-}$), the
$^{10}$Be decay constant ($\lambda$), the density of the sediment
($\rho$), the depth ($z$), the erosion rate of the surface ($\epsilon$)
and the age of the landform ($t$):

$$\label{Lal-equation}
\begin{array}{c}
{C} = {C_{0}} + \frac{{{P_{sp.}}}}{{\frac{\varepsilon }{{{\Lambda _{sp.}}}} + \lambda }}{{\rm{e}}^{ - \frac{z\cdot\rho}{{{\Lambda _{sp.}}}}}}\left( {1 - {{\rm{e}}^{ - t\left( {\lambda  + \frac{\varepsilon }{{{\Lambda _{sp.}}}}} \right)}}} \right) +  \\ 
\frac{{{P_{\mu^-}}}}{{\frac{\varepsilon }{{{\Lambda _{\mu^-}}}} + \lambda }}{{\rm{e}}^{ - \frac{z\cdot\rho}{{{\Lambda _{\mu^-}}}}}}\left( {1 - {{\rm{e}}^{ - t\left( {\lambda  + \frac{\varepsilon }{{{\Lambda _{\mu^-}}}}} \right)}}} \right) + \frac{{{P_{f\mu}}}}{{\frac{\varepsilon }{{{\Lambda _{f\mu}}}} + \lambda }}{{\rm{e}}^{ - \frac{z\cdot\rho}{{{\Lambda _{f\mu}}}}}}\left( {1 - {{\rm{e}}^{ - t\left( {\lambda  + \frac{\varepsilon }{{{\Lambda _{f\mu}}}}} \right)}}} \right)
\end{array}$$

This equation cannot be solved for $t$. Also, when we have a dataset of
$^{10}$Be concentrations under a surface (a $^{10}$Be depth-profile), we
want to solve the problem for $C_0$, $\epsilon$ and $t$. *How can we do
this?*

**$^{10}$Be accumulation model**

The following function calculates theoretical $^{10}$Be concentrations:

    function [ C ] = exposure_model(P,L,l,density,z,C0,erosion,t)
      C=C0+...
        P(1)./(l+erosion.*density./L(1)).*exp(-z.*density./L(1)).*...
        (1-exp(-(l+erosion.*density./L(1)).*t))+...
        P(2)./(l+erosion.*density./L(2)).*exp(-z.*density./L(2)).*...
        (1-exp(-(l+erosion.*density./L(2)).*t))+...
        P(3)./(l+erosion.*density./L(3)).*exp(-z.*density./L(3)).*...
        (1-exp(-(l+erosion.*density./L(3)).*t));
    end

**$^{10}$Be data**

The following code defines all the known parameters and the $^{10}$Be
concentrations from the sampled depth-profile for an alluvial fan in
Almería (Spain):

    %% Production rates
    P=[4.35,0.0985,0.0855]; % production rates in at/g/a
    L=[160,1137,1842]; % attenauation lengths in g/cm^2
    l=4.9975E-7; % decay contant in a^(-1)

    %% Field data
    density=1.8; % g/cm^3
    z=[267,195,141,95,46,3]; % depth of the sameples in cm
    Be10=[91000,184000,265000,430000,732000,1070000]; % 10Be concentrations in atoms/g
    Be10error=[9100,16000,18000,29000,61000,81000]; % 10Be uncertainties in atoms/g

 \
Try `exposure_model(P,L,l,density,10,0,0.0001,10000)` to calculate the
$^{10}$Be concentration accumulated in a sample 10 cm below a 10 ka old
surface being eroded at a rate of 1 mm/ka (0.0001 cm/a).

We can reproduce the theoretical depth profile for these conditions
along the first 3 m under the surface:

    zref=0:300; % depth reference in cm
    concentrations=exposure_model(P,L,l,density,zref,0,0.0001,10000);
    plot(concentrations,-zref,'-b')

Now we just need to find which theoretical values of inheritance, age
and erosion rates (the last 3 parameters in the `exposure_model`
function) match our `Be10` concentrations within `Be10error`
uncertainties!

Monte Carlo methods
-------------------

**Monte Carlo methods**

The simplest way of guessing the values for `C0,erosion,t` that fit our
data `Be10` at our depths `z` could be just trying *a lot* of random
values of `C0,erosion,t` and check which theoretical concentrations are
closer to our data. This is called a **Monte Carlo experiment**.

 \
To perform this Monte Carlo experiment, we should define a way of
measuring how close is our model to our data. A $\chi^2$ function
(similar to the one at the slide
[\[chisq\]](#chisq){reference-type="ref" reference="chisq"}) would do
the job:

$\chi^{2}=\sum\limits_{sample=1}^n \left( \frac{C_{model}(z_{sample})-C_{sample}}{\sigma_{C_{sample}}} \right) ^{2}$

 \
The following code runs a Monte-Carlo experiment of 100 000 models
assuming that $\epsilon$ is between 0 and 50 m/Ma (0.005 cm/a), the
landfom age is between less than 3 Ma (`3E6` a), and $C_0$ is smaller
than the lowest concentration.

    %% Monte carlo experiment
    nummodels=100000; % define how many models
    C0i=rand(1,nummodels)*min(Be10); % random inheritences
    ti=rand(1,nummodels)*3e6; % random ages
    erosioni=rand(1,nummodels)*0.005; % random erosion rates
    chisquarevalues=rand(1,nummodels)*NaN; % allocate memory for the chi square array

    % calculate the chi squared vales for each model
    for n=1:nummodels
        % calculate the model concetratios for the depths z
        Cmodel=exposure_model(P,L,l,density,z,C0i(n),erosioni(n),ti(n));
        % calculate the chi squared for this model
        chisquarevalues(n)=sum(((Cmodel-Be10)./Be10error).^2);
    end

 \
**Which models should we consider to represent the uncertainty of the
results?**

When fitting a model to data, we have to report how many parameters are
we trying to fit and how many data we have. The number of parameters
should be lower that the data points and the difference between them are
the **Degrees of Freedom** of our model. In our model we have\
DOF = 6 - 3 = 3 degrees of freedom.

When performing this kind of inverse modeling, the models that fit the
data with a $\chi^2$ value below the minimum $\chi^2$ value plus the
degrees of freedom are often considered to fit the data within one sigma
confidence level.

 \
Therefore, we can calculate which of the models fit our data within
one-sigma, assuming that this is defined by the models with $\chi^2$
values between the minimum $\chi^2$ and $\chi^2+$DOF:

        DOF=3; % degrees of freedom (# of samples - # of parameters)
        minchi=min(chisquarevalues); % minimum chi-square value (best model)
        best=find(chisquarevalues==minchi); % location of the best model
        % location of the models fitting the data within one-sigma
        onesigma=find(chisquarevalues<minchi+DOF); 
        
        % display previous infrormation
        disp(['Min chi-squared value = ' num2str(minchi)])
        disp([num2str(length(onesigma)) ' modles fitting one sigma'])
        disp(['Age: ' num2str(min(ti(onesigma))/1e3) ' - '...
            num2str(max(ti(onesigma))/1e3) ' ka'])
        disp(['Erosion: ' num2str(min(erosioni(onesigma))*1e4) ' - '...
            num2str(max(erosioni(onesigma))*1e4) ' m/Ma'])
        disp(['Inheritance: ' num2str(min(C0i(onesigma))) ' - '...
            num2str(max(C0i(onesigma))) ' atoms/g'])

 \

-   What is the best result?

-   Does it fit the data well? ($\chi^2\simeq0$)

-   Plot randomized values against their corresponding $\chi^2$ values
    to get a idea of the distribution of the results. *Tip: plot only
    the $\chi^2$ values below the best value+10*.

-   Plot the sample $^{10}$Be concentrations and the theoretical
    $^{10}$Be of the best fit.

-   Select the models fitting the data within one-sigma confidence level
    and plot these models in grey (`’Color’,[0.7 0.7 0.7]`).

 \
We should get a high number of fitting models to get an idea of which
the distribution of the parameters values that fit our data. *Try
increasing the number of random models to get at least 300 fitting
models.*

![Mote Carlo
simulations.[]{label="montecarlomodels"}](montecarlomodels.pdf){#montecarlomodels
width="100%"}

Convergence methods
-------------------

**Convergence**

Another way of getting more models fitting our data is changing the
limits of the randomized parameters while generating more models. For
example, until now we have been considering ages that are between 0 and
3 Ma, but after running about $10^5$ models, it is pretty clear that the
ages fitting the data are lower than 1 Ma, and that the erosion rates
should be lower than 5 m/Ma (0.0005 cm/a). *Re-run your solver applying
better limits*.

We can even program our solver to start converging after a *learning
process* of a certain number of models, automatizing what we have just
done manually. However, we should be cautious making our random models
to converge very fast because we can miss solutions that fit our data.
To avoid that, we could make them converge to $\chi^2$ values
$<\chi^2_{min.}+10\cdot DOF$. Actually, we should also allow our random
models to diverge out of the initial limits when we find good solutions
close to our limits.

Goal-seeking algorithms
-----------------------

**Goal-seeking algorithms**

Until now, we have been solving the question *"Which ages are compatible
with my data?"*, but are not explicitly answering the question *"Which
ages are **not** compatible with my data?"*.

The cosmogenic depth-profile models often show that the fitting models
are scattered towards old ages. This is because the fitting area in the
$\epsilon-t$ space is a narrow valley that we can easily miss when
randomizing the $\epsilon$ and $t$ values.

![Erosion rate-age plot.[]{label="etplot"}](etplot.pdf){#etplot
width="100%"}

 \
To avoid this, we can randomize only the $C_0$ and $t$ parameters and
make our program to seek actively which is the best $\epsilon$ that fit
the data for each of the models. This operation is sometimes called
*"$\chi^2$ minimization"*. $\chi^2$ minimization slows down our program
but will guarantee that **the models outside the fitting age range do
not fit our data**.

To minimize the value of $\chi^2$ we can use some built-in functions as
`fminunc` or `fminsearch` (type `help fminsearch` for more information).
However, the way these algorithms work change in the different versions
of MATLAB and Octave, so we will never be sure that our program is going
to work the same way in someone else computer. Therefore, it is highly
recommended to build our own minimization algorithm.

 \
An easy solution could be to use `interp1` as a goal seeker of the
deviations. The piece of code in the next slide includes this goal
seeker in the modeling loop to force getting always the best erosion
rate.

*How many models do you need to run now to get 300 fitting resutls?*

 \

    % start testing models
    for n=1:nummodels
        erosionref=[0,logspace(-5,2,100),10^10]'; % define an array with erosion rates
        % calculate the deviations corresponding to each erosion rate
        % deviations are defined as the sum of (Cmodel-Csample)/Uncertainty
        %     for all the samples
        deviations=...
          sum(...
            (exposure_model(P,L,l,density,z,C0i(n),erosionref,ti(n))-Be10)./...
             Be10error...
          ,2);
          
        % Interpolate the erosion rate values to find the one the model that
        % fit the data better (for the age and Co corresponding to this random
        % model). THen store the result at erosioni(n), ooverwriting the
        % previously defined value.
        erosioni(n)=interp1(deviations,erosionref,0);
        
        % calculate the model concetratios for the new erosion rate at the depths z
        Cmodel=exposure_model(P,L,l,density,z,C0i(n),erosioni(n),ti(n));
        
        % calculate the chi squared for this model
        chisquarevalues(n)=sum(((Cmodel-Be10)./Be10error).^2);
    end

Summary
-------

**Summary**

-   Using convergence (and divergence) algorithms help our inverse
    modeling program to run faster and allow us to set wide starting
    limits.

-   Using goal-seeking algorithms slows down the calculation of each
    individual simulation. However, it usually allows us to run less
    models, and also guarantee the reproducibility and accuracy of our
    results. Compare the two plots representing the solutions in the
    $\epsilon-t$ space with and without using $\chi^2$ minimization:\
    ![image](etplot.pdf){width="45%"} vs.
    ![image](etplotminimize.pdf){width="45%"}

**Exercise**

Use previous models to solve the age of a landform with the following
$^{10}$Be depth profile:

  -------------- ------------------
   Sample depth    \[$^{10}$Be\]
       *cm*       *$10^3$ atoms/g*
       250            25$\pm$2
       163            45$\pm$3
       113            60$\pm$5
        73           100$\pm$7
        43           140$\pm$10
        11           200$\pm$15
  -------------- ------------------

Start testing ages between 0 and 10 Ma and try introducing some
convergence code. This will allow you to create a code that will work on
any $^{10}$Be database.

![Expected result.](exercise_model.pdf){width="100%"}

[\[exercise\_model\]]{#exercise_model label="exercise_model"}

========

**Numerical models**

Numerical models are widely used to solve physical or chemical problems
by describing processes using equations and numbers.

We can generally describe a numerical model as $y=F(x)$, where $x$ are
the causes of the process, $F$ are the algorithms that describe the
process, and $y$ are the consequences of the process.

In Earth Sciences, we typically *know* the consequences ($y$) of the
process we are studying (e.g. a concentration of something as a result
of time, that will be the main *cause* in a geochronology problem), and
we want to know the causes $x$. Therefore, finding or approximating the
inverse model $x=F'(y)$ would be very useful for our purposes.

The way we solve a problem involving numerical models will depend on
whether or not we can find or approximate the inverse model.

Forward problem
---------------

**Forward problem**

Forward models as $y=F(x)$ are used to make informed predictions.
However, when we can find the inverse of our model $x=F'(y)$, we can
solve our problem directly.

In geochronology, this $x=F'(y)$ typically means expressing the *true
age* of a sample as a function of concentrations and other known
parameters.

Mathematically, a forward problem is a *well-posed problem*, where a
unique solution exists and the solutions change continuously with the
known parameters.

**Radiocarbon calibration**

A good example of a forward problem is the calculation of a calibrated
$^{14}$C age from an apparent $^{14}$C age, as the $^{14}$C ages
calculated in the slide
[\[radiocarbon\_function\]](#radiocarbon_function){reference-type="ref"
reference="radiocarbon_function"}.

Apparent radiocarbon ages are calibrated using calibration lines. You
can download the data corresponding to a calibration line from here:\
https://journals.uair.arizona.edu/index.php/radiocarbon/article/downloadSuppFile/16947/275\
You should get a file called `16947-25973-2-SP.14c`. Save it in your
working folder and open it as text: you will find out that is a comma
separated file (csv).

 \
If we have a radiocarbon age (e.g. $2000\pm20$), we should be able to
create a script to calibrate the entire probability distribution of the
age (see slide [\[gauss\_slide\]](#gauss_slide){reference-type="ref"
reference="gauss_slide"}) along the calibration curve using `interp1`
and produce an output like this:\
![image](C14calibration.pdf){width="100%"} (code in the next slides)

    %% import calibration curve
    fid = fopen('16947-25973-2-SP.14c');
    imported = textscan(fid, '%f %f %f %f %f',...
    'HeaderLines', 12,'Delimiter',',');
    fclose(fid);

    % select the data from the calibnration curve
    calBP=imported{1};
    C14=imported{2};

    %% interpolate calibration curve to arrays of 1 position per calibrated year
    refcalBP=min(calBP):1:max(calBP);
    refC14=interp1(calBP,C14,refcalBP);

    %% input our data
    C14age=2000;
    C14ageerr=20; % one sigma error

    % calculate probabilities of my data
    C14probs=normalprobs(refC14,C14age,C14ageerr);

        %% Plot the calibration curve and our data
        % select only the "most" probable data to plot
        sel=(C14probs>max(C14probs)/1000);
        
        figure % start figure
        % plot the part of the calibration curve that is relevent for us
        subplot(3,3,[2 6])
        plot(refcalBP(sel),refC14(sel))
        title('Calibration curve')
        
        % plot our data
        subplot(3,3,[1 4])
        plot(C14probs(sel),refC14(sel))
        ylabel('C14 age')
        xlabel('P')
        
        % plot the data calibrated
        subplot(3,3,[8 9])
        plot(refcalBP(sel),C14probs(sel)) 
        xlabel('calibrated C14 age')
        ylabel('P')

 \
Note that:

-   We are ignoring the uncertainty of the calibration curve
    (`imported{3}`). To know how to incorporate all the errors, check
    the script "MatCal" by Lougheed & Obrochta (2016):\
    http://dx.doi.org/10.5334/jors.130

-   To represent several subplots in the same window we are using
    `subplot(r,c,[a b])`, where `r` and `c` are the number of rows and
    columns, and `a` and `b` are corners of the area where we want to
    plot. E.g. `subplot(3,4,[7 12])` would start plotting in the blue
    area:\
    ![image](subplots.png){width="20%"}

Inverse problem
---------------

**Inverse problem**

Sometimes it is not possible to express our problem as $x=F'(y)$,
because sometimes it is impossible to get the inverse of $F(x)$.

Most geochemical models used in geochronology allow the calculation of a
theoretical concentration or measurable signal $C$ as a function of time
$t$ and other parameters: $C=f(t,C_0,...)$. However, some of these
problem cannot be solved for $t=f(C,C_0,...)$. In this cases, we will
need to *guess* the age $t$ corresponding to our known concentrations
$C,C_0$, etc.

**Ill-posed problem**

Mathematically, this kind of problems are often *ill-posed problems*.
Therefore, we cannot assume that they have a unique solution and we
should check the sensitivity of our results to a change in our known
parameters.

In geochronology, this means that apart of answering the main question:

> Which ages are compatible with my data?

but we should also answer the question:

> Which ages are **not** compatible with my data?

Cosmogenic depth-profile dating
-------------------------------

**Cosmogenic depth-profile dating**

The accumulation of $^{10}$Be under a sedimentary surface depends on the
inherited $^{10}$Be concentration ($C_0$), the different $^{10}$Be
production rates ($P_{sp.}$, $P_{f\mu}$ and $P_{\mu^-}$) and attenuation
lengths ($\Lambda_{sp.}$, $\Lambda_{f\mu}$ and $\Lambda_{\mu^-}$), the
$^{10}$Be decay constant ($\lambda$), the density of the sediment
($\rho$), the depth ($z$), the erosion rate of the surface ($\epsilon$)
and the age of the landform ($t$):

$$\label{Lal-equation}
\begin{array}{c}
{C} = {C_{0}} + \frac{{{P_{sp.}}}}{{\frac{\varepsilon }{{{\Lambda _{sp.}}}} + \lambda }}{{\rm{e}}^{ - \frac{z\cdot\rho}{{{\Lambda _{sp.}}}}}}\left( {1 - {{\rm{e}}^{ - t\left( {\lambda  + \frac{\varepsilon }{{{\Lambda _{sp.}}}}} \right)}}} \right) +  \\ 
\frac{{{P_{\mu^-}}}}{{\frac{\varepsilon }{{{\Lambda _{\mu^-}}}} + \lambda }}{{\rm{e}}^{ - \frac{z\cdot\rho}{{{\Lambda _{\mu^-}}}}}}\left( {1 - {{\rm{e}}^{ - t\left( {\lambda  + \frac{\varepsilon }{{{\Lambda _{\mu^-}}}}} \right)}}} \right) + \frac{{{P_{f\mu}}}}{{\frac{\varepsilon }{{{\Lambda _{f\mu}}}} + \lambda }}{{\rm{e}}^{ - \frac{z\cdot\rho}{{{\Lambda _{f\mu}}}}}}\left( {1 - {{\rm{e}}^{ - t\left( {\lambda  + \frac{\varepsilon }{{{\Lambda _{f\mu}}}}} \right)}}} \right)
\end{array}$$

This equation cannot be solved for $t$. Also, when we have a dataset of
$^{10}$Be concentrations under a surface (a $^{10}$Be depth-profile), we
want to solve the problem for $C_0$, $\epsilon$ and $t$. *How can we do
this?*

**$^{10}$Be accumulation model**

The following function calculates theoretical $^{10}$Be concentrations:

    function [ C ] = exposure_model(P,L,l,density,z,C0,erosion,t)
      C=C0+...
        P(1)./(l+erosion.*density./L(1)).*exp(-z.*density./L(1)).*...
        (1-exp(-(l+erosion.*density./L(1)).*t))+...
        P(2)./(l+erosion.*density./L(2)).*exp(-z.*density./L(2)).*...
        (1-exp(-(l+erosion.*density./L(2)).*t))+...
        P(3)./(l+erosion.*density./L(3)).*exp(-z.*density./L(3)).*...
        (1-exp(-(l+erosion.*density./L(3)).*t));
    end

**$^{10}$Be data**

The following code defines all the known parameters and the $^{10}$Be
concentrations from the sampled depth-profile for an alluvial fan in
Almería (Spain):

    %% Production rates
    P=[4.35,0.0985,0.0855]; % production rates in at/g/a
    L=[160,1137,1842]; % attenauation lengths in g/cm^2
    l=4.9975E-7; % decay contant in a^(-1)

    %% Field data
    density=1.8; % g/cm^3
    z=[267,195,141,95,46,3]; % depth of the sameples in cm
    Be10=[91000,184000,265000,430000,732000,1070000]; % 10Be concentrations in atoms/g
    Be10error=[9100,16000,18000,29000,61000,81000]; % 10Be uncertainties in atoms/g

 \
Try `exposure_model(P,L,l,density,10,0,0.0001,10000)` to calculate the
$^{10}$Be concentration accumulated in a sample 10 cm below a 10 ka old
surface being eroded at a rate of 1 mm/ka (0.0001 cm/a).

We can reproduce the theoretical depth profile for these conditions
along the first 3 m under the surface:

    zref=0:300; % depth reference in cm
    concentrations=exposure_model(P,L,l,density,zref,0,0.0001,10000);
    plot(concentrations,-zref,'-b')

Now we just need to find which theoretical values of inheritance, age
and erosion rates (the last 3 parameters in the `exposure_model`
function) match our `Be10` concentrations within `Be10error`
uncertainties!

Monte Carlo methods
-------------------

**Monte Carlo methods**

The simplest way of guessing the values for `C0,erosion,t` that fit our
data `Be10` at our depths `z` could be just trying *a lot* of random
values of `C0,erosion,t` and check which theoretical concentrations are
closer to our data. This is called a **Monte Carlo experiment**.

 \
To perform this Monte Carlo experiment, we should define a way of
measuring how close is our model to our data. A $\chi^2$ function
(similar to the one at the slide
[\[chisq\]](#chisq){reference-type="ref" reference="chisq"}) would do
the job:

$\chi^{2}=\sum\limits_{sample=1}^n \left( \frac{C_{model}(z_{sample})-C_{sample}}{\sigma_{C_{sample}}} \right) ^{2}$

 \
The following code runs a Monte-Carlo experiment of 100 000 models
assuming that $\epsilon$ is between 0 and 50 m/Ma (0.005 cm/a), the
landfom age is between less than 3 Ma (`3E6` a), and $C_0$ is smaller
than the lowest concentration.

    %% Monte carlo experiment
    nummodels=100000; % define how many models
    C0i=rand(1,nummodels)*min(Be10); % random inheritences
    ti=rand(1,nummodels)*3e6; % random ages
    erosioni=rand(1,nummodels)*0.005; % random erosion rates
    chisquarevalues=rand(1,nummodels)*NaN; % allocate memory for the chi square array

    % calculate the chi squared vales for each model
    for n=1:nummodels
        % calculate the model concetratios for the depths z
        Cmodel=exposure_model(P,L,l,density,z,C0i(n),erosioni(n),ti(n));
        % calculate the chi squared for this model
        chisquarevalues(n)=sum(((Cmodel-Be10)./Be10error).^2);
    end

 \
**Which models should we consider to represent the uncertainty of the
results?**

When fitting a model to data, we have to report how many parameters are
we trying to fit and how many data we have. The number of parameters
should be lower that the data points and the difference between them are
the **Degrees of Freedom** of our model. In our model we have\
DOF = 6 - 3 = 3 degrees of freedom.

When performing this kind of inverse modeling, the models that fit the
data with a $\chi^2$ value below the minimum $\chi^2$ value plus the
degrees of freedom are often considered to fit the data within one sigma
confidence level.

 \
Therefore, we can calculate which of the models fit our data within
one-sigma, assuming that this is defined by the models with $\chi^2$
values between the minimum $\chi^2$ and $\chi^2+$DOF:

        DOF=3; % degrees of freedom (# of samples - # of parameters)
        minchi=min(chisquarevalues); % minimum chi-square value (best model)
        best=find(chisquarevalues==minchi); % location of the best model
        % location of the models fitting the data within one-sigma
        onesigma=find(chisquarevalues<minchi+DOF); 
        
        % display previous infrormation
        disp(['Min chi-squared value = ' num2str(minchi)])
        disp([num2str(length(onesigma)) ' modles fitting one sigma'])
        disp(['Age: ' num2str(min(ti(onesigma))/1e3) ' - '...
            num2str(max(ti(onesigma))/1e3) ' ka'])
        disp(['Erosion: ' num2str(min(erosioni(onesigma))*1e4) ' - '...
            num2str(max(erosioni(onesigma))*1e4) ' m/Ma'])
        disp(['Inheritance: ' num2str(min(C0i(onesigma))) ' - '...
            num2str(max(C0i(onesigma))) ' atoms/g'])

 \

-   What is the best result?

-   Does it fit the data well? ($\chi^2\simeq0$)

-   Plot randomized values against their corresponding $\chi^2$ values
    to get a idea of the distribution of the results. *Tip: plot only
    the $\chi^2$ values below the best value+10*.

-   Plot the sample $^{10}$Be concentrations and the theoretical
    $^{10}$Be of the best fit.

-   Select the models fitting the data within one-sigma confidence level
    and plot these models in grey (`’Color’,[0.7 0.7 0.7]`).

 \
We should get a high number of fitting models to get an idea of which
the distribution of the parameters values that fit our data. *Try
increasing the number of random models to get at least 300 fitting
models.*

![Mote Carlo
simulations.[]{label="montecarlomodels"}](montecarlomodels.pdf){#montecarlomodels
width="100%"}

Convergence methods
-------------------

**Convergence**

Another way of getting more models fitting our data is changing the
limits of the randomized parameters while generating more models. For
example, until now we have been considering ages that are between 0 and
3 Ma, but after running about $10^5$ models, it is pretty clear that the
ages fitting the data are lower than 1 Ma, and that the erosion rates
should be lower than 5 m/Ma (0.0005 cm/a). *Re-run your solver applying
better limits*.

We can even program our solver to start converging after a *learning
process* of a certain number of models, automatizing what we have just
done manually. However, we should be cautious making our random models
to converge very fast because we can miss solutions that fit our data.
To avoid that, we could make them converge to $\chi^2$ values
$<\chi^2_{min.}+10\cdot DOF$. Actually, we should also allow our random
models to diverge out of the initial limits when we find good solutions
close to our limits.

Goal-seeking algorithms
-----------------------

**Goal-seeking algorithms**

Until now, we have been solving the question *"Which ages are compatible
with my data?"*, but are not explicitly answering the question *"Which
ages are **not** compatible with my data?"*.

The cosmogenic depth-profile models often show that the fitting models
are scattered towards old ages. This is because the fitting area in the
$\epsilon-t$ space is a narrow valley that we can easily miss when
randomizing the $\epsilon$ and $t$ values.

![Erosion rate-age plot.[]{label="etplot"}](etplot.pdf){#etplot
width="100%"}

 \
To avoid this, we can randomize only the $C_0$ and $t$ parameters and
make our program to seek actively which is the best $\epsilon$ that fit
the data for each of the models. This operation is sometimes called
*"$\chi^2$ minimization"*. $\chi^2$ minimization slows down our program
but will guarantee that **the models outside the fitting age range do
not fit our data**.

To minimize the value of $\chi^2$ we can use some built-in functions as
`fminunc` or `fminsearch` (type `help fminsearch` for more information).
However, the way these algorithms work change in the different versions
of MATLAB and Octave, so we will never be sure that our program is going
to work the same way in someone else computer. Therefore, it is highly
recommended to build our own minimization algorithm.

 \
An easy solution could be to use `interp1` as a goal seeker of the
deviations. The piece of code in the next slide includes this goal
seeker in the modeling loop to force getting always the best erosion
rate.

*How many models do you need to run now to get 300 fitting resutls?*

 \

    % start testing models
    for n=1:nummodels
        erosionref=[0,logspace(-5,2,100),10^10]'; % define an array with erosion rates
        % calculate the deviations corresponding to each erosion rate
        % deviations are defined as the sum of (Cmodel-Csample)/Uncertainty
        %     for all the samples
        deviations=...
          sum(...
            (exposure_model(P,L,l,density,z,C0i(n),erosionref,ti(n))-Be10)./...
             Be10error...
          ,2);
          
        % Interpolate the erosion rate values to find the one the model that
        % fit the data better (for the age and Co corresponding to this random
        % model). THen store the result at erosioni(n), ooverwriting the
        % previously defined value.
        erosioni(n)=interp1(deviations,erosionref,0);
        
        % calculate the model concetratios for the new erosion rate at the depths z
        Cmodel=exposure_model(P,L,l,density,z,C0i(n),erosioni(n),ti(n));
        
        % calculate the chi squared for this model
        chisquarevalues(n)=sum(((Cmodel-Be10)./Be10error).^2);
    end

Summary
-------

**Summary**

-   Using convergence (and divergence) algorithms help our inverse
    modeling program to run faster and allow us to set wide starting
    limits.

-   Using goal-seeking algorithms slows down the calculation of each
    individual simulation. However, it usually allows us to run less
    models, and also guarantee the reproducibility and accuracy of our
    results. Compare the two plots representing the solutions in the
    $\epsilon-t$ space with and without using $\chi^2$ minimization:\
    ![image](etplot.pdf){width="45%"} vs.
    ![image](etplotminimize.pdf){width="45%"}

**Exercise**

Use previous models to solve the age of a landform with the following
$^{10}$Be depth profile:

  -------------- ------------------
   Sample depth    \[$^{10}$Be\]
       *cm*       *$10^3$ atoms/g*
       250            25$\pm$2
       163            45$\pm$3
       113            60$\pm$5
        73           100$\pm$7
        43           140$\pm$10
        11           200$\pm$15
  -------------- ------------------

Start testing ages between 0 and 10 Ma and try introducing some
convergence code. This will allow you to create a code that will work on
any $^{10}$Be database.

![Expected result.](exercise_model.pdf){width="100%"}

[\[exercise\_model\]]{#exercise_model label="exercise_model"}