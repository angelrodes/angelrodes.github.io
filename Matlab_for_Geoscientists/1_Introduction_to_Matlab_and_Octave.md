Introduction to Matlab and Octave
=================================

Installation
------------

**Install it!**

Install MATLAB following the instructions from the IT services

https://www.gla.ac.uk/myglasgow/it/software/statistics/\#/matlab

or install GNU Octave from the Web

https://www.gnu.org/software/octave/

Matrix-oriented programming
---------------------------

**Matrix-oriented programming**

-   MATLAB and Octave are presented as "MATrix LABoratories", commonly
    used for plotting of functions and data, implementation of
    algorithms, creation of user interfaces, and interfacing with
    programs written in other languages.

-   MATLAB is a proprietary programming language developed by MathWorks,
    Inc. GNU Octave is free software under the terms of the GNU General
    Public License.

-   MATLAB and Octave use languages that are mostly compatible. In this
    course we will use syntaxes compatible with both programs, unless
    otherwise stated.

Why MATLAB/Octave?
------------------

**MATLAB and/or Octave will allow you to:**

-   Manage large datasets (raw data, synthetic results, maps, etc.).

-   Perform iterative calculations.

-   Write self-explained calculations and share them with the scientific
    community (i.e. suitable to be included in scientific publications).

-   Plot exactly what you want.

-   Learn a computing language that is easy.

-   Learning how to program in MATLAB/Octave makes other languages much
    easier to learn: Matlab/Octave are similar to R, Python, C++, etc.

-   Solve your own problems using your own programs, adapting exactly to
    your needs!

The interface
-------------

**The interface**

Matlab and Octave come with very similar interfaces containing, at
least, the following elements:

-   Address bar

-   Browser

-   Command window

-   Workspace

-   Editor

![image](https://user-images.githubusercontent.com/53089531/131697223-d3c2c5a2-9d82-4615-aa81-8b651960de51.png)
MATLAB interface.

![image](https://user-images.githubusercontent.com/53089531/131697391-891bde25-1e05-429f-9ff7-d25f78631ba8.png)
Octave GUI.

**The command window** This is the **brain** of the program. You can use
this as a simple calculator or to call functions or scripts. Ultimately,
this is the only element you need to use Matlab or Octave!

Try writing the following commands and hit enter:

-   `97+6`

-   `23-36`

-   `23-6*6`

-   `(23-6)*6`

-   `12742*pi`

-   `3^2`

-   `sqrt(2)`

-   `log(100)`

-   `log10(100)`

*To clean the command window, use the command `clc`.\
As most of the console interfaces, the command window has memory: try
using the up arrow key ($\uparrow$).*

**Current directory and browser**

When you want to interact with files (e.g. calling your own scripts or
creating files with your results or graphs), you need to know **where**
you are working. Therefore, make sure that the address you see at the
top of the screen is the folder you want to work in. You can see,
create, delete or open your files using your system browser (explorer,
finder, nautilus, etc.) or the browser integrated in Matlab or Octave.

*Create a new file called **my-first-file.m**.

Avoid using spaces, most symbols, or start with numbers when naming your
files. **Instead of spaces, use the underscore symbol (\_).**

Also, note that Matlab files always end with `.m`*

**The editor**

This is just a basic text editor. The files that you can edit do not
contain any information about formatting. You can open these files using
any text editor (e.g. notepad). However, the integrated editor format
the text to highlight the meaning of the text in the Matlab language.

Open `my_first_file.m` and write:

```Matlab
% This is my first Matlab script.
disp(’Hello world’)
```

then run it using the command `my_first_file` (no `.m`) in the command
window, or selecting **run** in the menu.

**Workspace**

This is the *memory* of Matlab/Octave. The last answer given in the
command window is usually stored as `ans`.

*Write `x=3+2` in the command window.\
The parameter `x` will appear in the Workspace.*

Use the command `who` or `whos` to display a summary of the workspace in
the command window, and the command `clear` to remove all the parameters
in the workspace.

What can we put in the Workspace?
---------------------------------

**Parameters with one number**

-   `mass=12`

-   `C14halflife=5730;`

-   `avogadro=6.022*10^23`

*As for file names, avoid using spaces, most symbols, or start
parameter's names with numbers.
Ending with semicolon (;) prevents the output to be shown in the command
window, although the parameter is stored in memory. You can check that
the value of C14halflife is in memory by typing `C14halflife` in the
command window.*

Other "special\" accepted values:

-   `maxtime=Inf`

-   `mintime=-Inf`

-   `unknownvalue=NaN`

*`Inf` means "Infinite" and `NaN` means "Not a Number". You can also
generate them by computing `1/0` or `0/0` in the command window.*

**Array of numbers**

-   `data=[254,782,65,5]`

-   `moredata=[23;36;47]`

-   `a=1:20`

-   `a=1:0.25:10`

-   `odds=1:2:100`

-   `pairs=2:2:100`

-   `emptyarray=[]`

Use `length(data)` to check the size of your array.

*Try also `linspace(0,3,20)` and `logspace(0,2,5)`
to get equally distributed numbers in the linear or logarithmic space.
Use `odds13` if you want it as a column.
Access a single (`data(3)` or `data(end)`) or several values of an array
(`a(7:10)`)*

**Matrices**

-   `A=[1,2,3 ; 4,5,6 ; 7,8,9]`

-   `B=[99,88,77 ; 66,55,44 ; 33,22,11]`

-   `C=ones(4,3) % number of rows,columns`

-   `D=zeros(4,3)`

*Note that anything you write after the `%` symbol is ignored. **`%` is
used for comments.***

You can also create a matrix by repeating an array using `repmat`:

`repmat(data,3,1)`

Use `help repmat` to know more about this.

These matrices are 2-D (rows and columns). However, MATLAB and Octave
are also able to handle matrices in multiple dimensions. E.g.
`ones(3,2,5)` is a 3-D matrix.

Use `size(B)` to check the size of your matrix (rows and columns), or
n`numel(B)` to get the number of elements in `B`.

**Strings**

Strings are parameters containing text:

-   `name=13John13`

-   `students=[{13Gerry13},{13Trish13},{13Pablo13}]`

Strings are useful when working with sample or location names. MATLAB
and Octave can handle strings and provide powerful tools to manipulate
and operating with text, such as regular expressions. However, these
programming languages were not primarily designed to work with text, and
string manipulation can be very frustrating at the beginning. Therefore,
we will restrict the use of text to sample names or simple labels.

*Sometimes it will be useful to find a sample in a list. For example,
use `strcmp` to find the position of the student named *Trish*:
`strcmp(’Trish’,students)`*

**Small functions**

Simple formulas can be defined by using defining the parameters with
@(Parameters):

-   `temp_fahrenheit = @(temp_celsius)1.8 * temp_celsius + 32`

-   `meters=@(ft)ft/3.2808`

-   `decay=@(halflife,time)exp(-log(2)/halflife*time)`

*Try `temp_fahrenheit(15)` and `decay(C14halflife,20000)`*

**Boolean data**

Boolean data is a type of data that has one of two possible values: true
(1) or false (0). In MATLAB, logical is usually generated used
equalities or inequalities:

-   `avogadro>1E23`

-   `mass==12`

-   `odds<10`

-   `odds(odds<10)`

-   `A>5`

-   `isinf(maxtime)`

-   `isnan(B)`

-   `isprime(7537)`

*Note that `==` and `\sim=` are used in MATLAB to determine equality or
inequality, and `=` to define a parameter.*

We can combine boolean data using boolean operators: `&` (and) and `|`
(or).

E.g. `( A<5 | B<30 )`.

Boolean data can also be use as indexes if the boolean array or matrix
has the same size as the objective array or matrix.

E.g. `A(A>5)` or `B(A<3)` but not `data(A<10)`.

This property is useful to easily create filters for our data:

`data(data>50 & data<500)`

*clc to clean the Command window*

**Basic calculations**

With numbers: `mass*avogadro`

With arrays and matrices: `odds+pairs` but `odds.*pairs`

*Note the difference between `B/A` and `B./A`:

"`.*`", "`./`" and "`.^`" are operators used to perform calculations
element by element (array operations). Avoid using "`*`", "`/`" and
"`^`" on matrices unless you really want to do matrix operations
following the rules of linear algebra.*

Call parts of another variable: You can access the number in the second
row and third column with `A(2,3)`, the second row with `B(2,:)` or the
first column with `A(:,1)`. MATLAB and Octave always follow the order
(**row,column**) in 2D matrices.

**Random numbers**

-   `rand` % any number between 0 and 1

-   `rand(1,10)` % a row of 10 random numbers

-   `rand(10,1)` % a column of 10 random numbers

-   `rand(3,3)` % a 3x3 matrix with random numbers between 0 and 1

-   `A.*rand(3,3)` % a matrix with random numbers between 0 and numbers
    in matrix A

-   `normrnd(11000,2000)` % a random number from a gaussian distribution
    of 11000$\pm$2000

-   `normrnd(11000,2000,1,5000)` % a row of 5000 random numbers from a
    gaussian distribution of 11000$\pm$2000

*Try `hist(normrnd(11000,2000,1,5000))` and `hist(rand(1,5000))` to plot
the histograms corresponding to these random distributions.*

Plots
-----

**Air pressure**

Let's define a function that calculates the pressure at a certain
altitude:

```Matlab
    pressure = @(altitude)1013.25*...
     exp(-0.03417/0.0065*(log(288.15)-...
     (log(288.15-0.0065*altitude))))
     % standard atmosphere pressure (Lide, 1999)
```

*Note that we can use three dots (`...`) to avoid long lines.*

Then define `x` values between 0 (sea level) and 8848 m (Everest) every
100 m:

`x=0:100:8848`

And alculate their corresponding pressures:

`y=pressure(x)`

**Simple plots**

Try the following plots:

-   `plot(x,y)`

-   `plot(x,y,13.r13)`

-   `plot(x,y,13ob13)`

-   `plot(x,y,13–k13)`

-   `plot(x,y,13-g13,13LineWidth13,2)`

-   `bar(x,y)`

-   `stairs(x,y)`

**Figure**

Create a figure and plot several things in it:

```Matlab
    figure % open a new figure
    hold on % do not clear when plotting different things
    plot(x,y,'-b')
    plot(200,pressure(200),'hr')
    text(200,pressure(200),'East Kilbride')
    xlabel('Altitude')
    ylabel('Pressure')
    title('My first plot with labels')
```

Make y axis logarithmic: `set(gca, ’YScale’, ’log’)` (`gca` means "Get
current axes\") *You can export your plots using the menu **File $>$
Save As** in the figure window. Exporting your plots as .eps or .pdf
will allow you to edit them with vector graphic editors like Adobe
Illustrator or Inkscape.*

Scripts
-------

**Scripts**

A script is a text file with a list of orders. In your current
directory, create `radiocarbondating.m`. Open it with the editor and
write the following orders:

```Matlab
    %% This is a script that calculates radiocarbon ages and errors
    %% By Me, 2019

    %% Start with some cleaning
    clear % this removes any previous parameter in the workspace
    clc % this clears the command window

    %% Define the formula that calculates the age from concentrations
    C14age=@(modernconcentration,measuredconcentration)-...
    8033*log(measuredconcentration./modernconcentration);

    %% This is the data we have
    modernc=1232;
    errormodernc=13;
    oldc=[567 1100 20 1252];
    erroroldc=[6 20 5 50];

    %% Select the data we want to work with
    n=1

    %% Create 1000 random data based on the normal dristributions
    randommodern=normrnd(modernc,errormodernc,1,1000);
    randomold=normrnd(oldc(n),erroroldc(n),1,1000);

    %% Calculate the ages of the distributions
    ages=C14age(randommodern,randomold);

    %% Plot the age distribution
    figure
    hold on
    hist(ages)
    title(['Sample ' num2str(n)])
    xlabel('Age')
    ylabel('Probability')

    %% Calculate the mean and the average
    age=mean(ages)
    errorage=std(ages)
```

Now you can change the value of `n` to get the results of other data.

*Note that we can make composed strings using brackets `[]` and the
function `num2str(n)` to convert numbers into strings.\
Also note that we can use `...` to avoid very long lines.*

Loops
-----

**Loops**

We often need to run a block of code several times. For example, in our
program `radiocarbondating.m` we could copy and paste the script 4 times
changing `n=1` by `n=2`, `n=3` and `n=4` to get all our ages calculated.
However, we avoid repeating code by writing a loop statement that
executes the code multiple times.

In `radiocarbondating.m`, we can substitute "`n=1`\" by
"`for n=[1,2,3,4]`\" and write "`end`\" at the end of the script to
perform the calculations and plotting for the four samples.

*The basic form of a loop in Matlab is*:

```Matlab
for Parameter=List
% My repeating code
end
```

**Error bars**

Create a new script called **plot-with-error-bars.m** that use a loop to
plot error bars of the individual concentrations:

```Matlab
    %% This is a script that plots data with error bars
    %% By Me, 2019

    %% Start with some cleaning
    clear % this removes any previous parameter in the workspace
    clc % this clears the command window
    close all hidden % close any pre vious figure

    %% This is the data we have
    data=[567 1100 20 1252 326 625];
    errors=[6 20 5 50 32 100];

    %% Figure
    figure
    hold on
    for n=1:length(data) % start a loop
      plot(n,data(n),'.b')  % Plot data
      x=[n,n]; % x positions of the limits of the error bar line
      y=[data(n)-errors(n),data(n)+errors(n)]; % y positions
      plot(x,y,'-b') % plot the error bar
    end % end of the loop
    xlabel('Sample')
    ylabel('Concentration')
```

Another way of creating a loop is using the statement* `while`:

```Matlab
n=0;
while n<10
n=n+1 % add 1 to the value of n
end
```

Conditional statements
----------------------

**if - end**

Conditional statements allow us to select at run time which block of
code to execute. The simplest conditional statement is `if`, closed with
`end`:

    n=round(rand*100); % random number between 0 and 100
                       % rounded to the nearest integer
    if n/2==round(n/2)
      string=[num2str(n) ' is pair']
    end

**if - elseif - else - end**

We can define alternatives using `if`, `elseif`, `else` and `end`:

    n=round(rand*100);
    if n/2==round(n/2)
      string=[num2str(n) ' is pair'];
    elseif isprime(n)
      string=[num2str(n) ' is odd and prime'];
    else
      string=[num2str(n) ' is odd, but not prime'];
    end
    disp(string) % disp shows the string in the command window

*You can also define conditional statements using `switch` (`switch`,
`case`, `otherwise` and `end`). Find yourself how to use the `switch`
statement by typing `help switch` in the command window!*

Functions
---------

**Functions**

A function is a script that works like a "black box\". You only see the
final output in the workspace, not all the parameters defined in the
function. When writing a function, or converting a script into a
function, we have to start the file with

`function OUTPUTS = function_name(INPUTS)`

and write

`end`

at the end of the file.

**14C age function**

Create a file called **C14agefunction.m** and copy:

    function [age,errorage]=C14agefunction(oldc,erroroldc,modernc,errormodernc)
      C14age=@(modernconcentration,measuredconcentration)-...
        8033.*log(measuredconcentration./modernconcentration);
      randomold=normrnd(oldc,erroroldc,1,10000);
      randommodern=normrnd(modernc,errormodernc,1,10000);
      ages=C14age(randommodern,randomold);
      age=mean(ages);
      errorage=std(ages);
    end

*Note that the function name has to be the same as the file name.
Otherwise you will get an error when running it.*

Save the file, and then execute the following in the command window:

`C14agefunction(50,10,1254,20)`

`[age,error]=C14agefunction(50,10,1254,20)`

Built-in functions
------------------

**Built-in functions**

MATLAB and Octave come with a large number of built-in functions (e.g.
`factorial`, `sin`, `sum`, `diff`, `max`, `magic`, `pi`, `median`,
`chi2pdf`, `interp1`, `contour`, and many more).

You can learn how to use these functions using `help` (e.g.
`help interp1`), selecting the name of the function and pressing in
MATLAB.

Also, you can discover more functions in the Internet. Just search for
the operation you want to do, including "Matlab\" or "Octave\" in your
search.

*We can even see how some of these built-in functions are made with
`edit`. Try `edit magic` to see the code of the function that generates
magic squares!*

**Toolboxes and packages**

There are some advances functions, like the ones used to work with maps,
that are not included in the basic package of MATLAB and Octave. These
"special packages\" are called "toolboxes\" in MATLAB and just
"packages\" in Octave.

Toolboxes are installed using the MATLAB installer and they are
automatically loaded when you start MATLAB.

Octave packages can be installed using `pkg install` and the name of the
file where the package is. Before we start using an Octave package, we
have to load it with `pkg load package_name`.

As one of the objectives of this course is learning to write code we can
share, most of the built-in functions that we are using in this course
are included in the basic versions of MATLAB and Octave. If a toolbox or
package is required, it will be clearly stated.

Exercises
---------

**Snow and glacier modelling**

A glacier is a persistent body of dense ice that is constantly moving
under its own weight. *(Wikipedia: Glacier)*

![image](https://user-images.githubusercontent.com/53089531/131700109-e77c5c4e-f22e-4880-ab5d-193f2acc4fd2.png)

[antarcticglaciers.org](http://www.antarcticglaciers.org)

 
Consider the following climate simplifications:

-   Average monthly temperature (ºC) at sea level in Scotland:
 
```
      ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
       Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
        4     5     7     8    12    14    16    16    13    10     7     5
      ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
      ```

-   Temperature lapse rate: 8 ºC/Km

-   Monthly precipitation (mm) in Scotland:

```
      ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
       Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
       175   125   150   100   75    100   100   125   125   175   175   175
      ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
```

 
Consider the following snow/ice behaviour (huge simplifications):

-   All precipitation is **snow when temperature is below 5ºC**.
-   All precipitation is rain above 5ºC.

-   Daily temperature range is 5ºC, so **day temperature is 2.5ºC above the average**.

-   Considering thermal conductivity of the snow mantle ~5
    W/K/m2, a snow latent heat of fusion of  350 kJ/kg and a snow
    average density of ~0.3 Kg/l, an average of vertical **5 cm of
    snow per month will be melted for each degree of day temperature
    over 0ºC**.

-   If the snow survives for more than a year (annual mass balance >
    0), the snow will flow downhill at an **horizontal speed of 10
    inches/day**.

-   The average **glacier slope is 15º**.

Mass balance:

1.  Write a function that calculate the monthly snow mass balance (snow
    accumulation-snow melting). *Remember that the melting function
    should not create snow!*

2.  Write a function that calculate the snow accumulated monthly.
    *Remember that (1) we can have snow inherited from the previous
    month, and (2) the thickness of the snow mantle cannot be negative!*

3.  Write a piece of code that calculates the annual mass balance.
    Introduce the possibility of emulate past and future climate
    conditions by changing the temperature and precipitation uniformly
    (ΔT and ΔP).

*The output of the monthly functions should be an array of 12 numbers
when the input is one altitude, or a matrix when the input is a "column"
of altitude values.*

 
Snow accumulation:

1.  Placing a ski resort: what is the lowest altitude with 3 or more
    months of snow?

2.  According to these data, where could we find a glacier in Scotland
    today? *Note: the highest peak in Scotland is Ben Nevis, 1345 m
    above sea level.*

 
The Glenshee ski area is located between 650 and 1050 m of altitude.
What impact would these scenarios have on the business by 2100?

![image](https://user-images.githubusercontent.com/53089531/131722504-35d9efe1-d93d-4188-a911-96baa2ba7bb7.png)

earthobservatory.nasa.gov

 
Glacier modeling exercises:

1.  Write a piece of code that emulate the annual snow/ice mass flow.
    *Tip: calculate how much the snow/ice moves vertically in a year and
    discretize the altitude reference accordingly, so the snow packed
    during the previous year will move one position per year.*

2.  Write a script that runs the previous code until the thickness of
    the snow/ice is stable.

3.  According to this model, where should the glacial fronts have been
    during the Younger Dryas (ΔT=-4ºC)? and during last
    glaciation (ΔT=-6ºC)?

 
Produce graphical outputs like these:

![image](https://user-images.githubusercontent.com/53089531/131700264-5be0f18b-b250-4839-9b70-72c4f8cb038d.png)
