Maps
====

Install a toolbox or package
----------------------------

**Loading the mapping tools**

Most mapping tools are not installed in the basic versions of MATLAB or
Octave. To install them, we will need to do the following:

1.  In MATLAB we can install the **Mapping Toolbox** if it is not
    installed yet. Check if it is installed in the **Home tab $>$
    Add-Ons $>$ Manage Add-Ons**. If it is not, you gen get it from
    *https://www.mathworks.com/products/mapping.html*

2.  In Octave you need the **mapping package** (check if you already
    have it with `pkg list`). If you do not, you can install it by
    typing *`pkg install -forge mapping`* in the command window or from
    *https://octave.sourceforge.io/mapping/index.html*\
    In Octave, we need to "activate" the packages in every session if we
    want to use them. To do so type or write at the top of your script
    *`pkg load mapping`*\
    It is also recommended to load the input/output package:
    *`pkg load io`*

**Mapping tools**

The mapping tools allow us to:

-   Calculate azimuths between two points (*`azimuth`*), get angular
    distances between coordinates (`distance`), converting angular
    distances to kilometres (`rad2km`) and many other calculations on
    maps.

-   Read shape files and raster files with `shaperead` and `rasterread`.

-   Plot maps using `mapshow`.

However, in geosciences we often need to perform specific calculations
on digital elevation models that are only included in the MATLAB Mapping
Toolbox (as `gradientm` or `viewshed`) and other topographic derivates
(gradient, flow accumulation, stream order, etc.) that are not included
in any official toolbox or package.

Import a toolbox not included in MATLAB
---------------------------------------

**TopoToolbox**

TopoToolbox is a is a MATLAB program for the analysis of digital
elevation models (DEMs) developed by Schwanghart & Kuhn (2010) that
provides a set of functions that support the analysis of relief and flow
pathways in digital elevation models
(https://doi.org/10.1016/j.envsoft.2009.12.002).

It can be downloaded from
https://www.mathworks.com/matlabcentral/fileexchange/50124-topotoolbox

*But since the objective of this course is to understand the
fundamentals necessary to develop our own tools, we will focus on using
the tools included in MATLAB and Octave.*

 \

![Example layout of topoapp, a graphical user interface that enables
access to the majority of TopoToolbox functions. See
https://doi.org/10.5194/esurf-2-1-2014 for
details](TopoToolbox.png){width="100%"}

Plotting maps
-------------

**Plotting maps using the mapping tools**

-   Calculate the azimuth from SUERC (\[lat,lon\]=\[55.75,-4.16\]) and
    George Square (\[lat,lon\]=\[55.86,-4.25\]).

-   Calculate the distance in km from SUERC to George Square.

-   Download the shapefile of UK from
    https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36\_GBR\_shp.zip and
    extract the coastline shape files
    `gadm36_GBR_0.shp, gadm36_GBR_0.shx, gadm36_GBR_0.prj,` etc. to your
    folder.

-   Plot the map `gadm36_GBR_0.shp` using `mapshow` or `geoshow`.

-   Extract the X and Y coast points using
    `data=shaperead(’gadm36_GBR_0.shp’)` and plot them using
    plot(data.X,data.Y,'-r')

-   Calculate what is the minimum distance from SUERC to the coast in a
    straight line. And the maximum!

Import maps without mapping tools
---------------------------------

**Import Esri grid files**

`.asc` files are widely used to export Digital Elevation Models. They
are plain text files (ASCII) containing a matrix of elevations.

At the top of the file they also contain the following information:\
- `ncols` and `nrows`: the number of columns and rows of the elevation
matrix.\
- `xllcorner` and `yllcorner`: the coordinates of the lower left corner
of the lower left cell.\
- `cellsize`: the actual distance between two cells.

*Open the file `Scotland.asc` as text.* In this file, the `xllcorner`,
`yllcorner` and `cellsize` are in geographic units (decimal degrees of
longitude and latitude) and the elevations are in metres, but sometimes
all these parameters are in metres. Make sure you know the units before
using a `.asc` file!

 \
Import the data in `Scotland.asc` using `textread` to transform the
`.asc` data into $X$, $Y$ and $Z$ coordinates:

    textdata=textread('Scotland.asc', '%s');
    rawelevations=textread('Scotland.asc', '%f','headerlines',6);

    ncols=str2double(textdata(2));
    nrows=str2double(textdata(4));
    xllcorner=str2double(textdata(6));
    yllcorner=str2double(textdata(8));
    cellsize=str2double(textdata(10));

    X=ones(nrows,ncols).*[xllcorner:cellsize:xllcorner+cellsize*(ncols-1)];
    Y=ones(nrows,ncols).*[yllcorner:cellsize:yllcorner+cellsize*(nrows-1)]';
    Z=zeros(nrows,ncols);

    n=0;
    for r=1:nrows
      for c=1:ncols
        n=n+1;
        Z(r,c)=rawelevations(n);
      end
    end

You have just created a script that reads `.asc` files without
toolboxes!

 \
Now you can plot your DEM using any of these plotting tools:

    surf(X,Y,Z)

    meshc(X,Y,Z)

    contour(X,Y,Z,[0.1,200:200:2000]) % the 0.1 m contour is the coastline

    contour(X,Y,Z,[0.1,500:500:2000],'-b','ShowText','on')

    contour3(X,Y,Z,[0.1,50:50:2000])

    plot(X(Z>915),Y(Z>915),'.r') % Munros!

-   Use `interp2` to get the altitudes of SUERC and George Square.

-   Calculate the actual distance from SUERC to George Square.

-   Plot the elevation transect from SUERC to the closest Munro.

-   Plot the elevation histogram of Scotland.

Geomorphic calculations on DEMs
-------------------------------

**Calculate slopes**

We can calculate the slope vectors using the function `gradient`:

>     % calculate the spacing in metres
>     xspacing=mean(1000*rad2km(deg2rad(distance(Y(:),X(:),Y(:),X(:)+cellsize))));
>     yspacing=mean(1000*rad2km(deg2rad(distance(Y(:),X(:),Y(:)+cellsize,X(:)))));
>
>     [dx, dy] = gradient(-Z,xspacing,yspacing);
>
>     figure; hold on
>     contour(X,Y,Z,[0.1,200:200:2000])
>     quiver(X,Y,dx,dy) % displays slope vectors as arrows

![`quiver` function displays slope vectors as
arrows.[]{label="quiver"}](quiver.pdf){#quiver width="100%"}

 \
Note that:

-   We have to provide the `xspacing` and `yspacing` in metres to get
    the partial derivatives $\delta z/\delta x$ and $\delta z/\delta y$
    (`dx` and `dy`) in m/m (unitless). We could calculate the same as
    follows:

    >                 [dxunscaled, dyunscaled] = gradient(-Z);
    >                 dx=dxunscaled/xspacing; dy=dyunscaled/yspacing;

-   The $x$ spacing could not constant in large maps when the points are
    spaced at constant geographical longitudes (see
    *`distance(Y(:),X(:),Y(:),X(:)+cellsize)`*). That is why sometimes
    the `cellsize` is in metres. Here, we are approximating the
    longitude spacing on the entire map by its average.

-   We are calculating the gradient of `-Z` because we want the slope to
    be positive downhill.

 \
Once we have the gradient, we can calculate the slopes:
$$\nabla z = \sqrt{\left( \frac{\delta z}{\delta x}\right)^{2}+\left( \frac{\delta z}{\delta y}\right)^{2}}$$

In Matlab or Octave:

>     slopes=(dx.^2+dy.^2).^0.5;

If we want the slope angles in degrees: `rad2deg(atan(slopes))`

**Calculate flow direction**

We can calculate the azimuth of the flow direction with:

>         flowdir = azimuth(0,0,dy,dx);

But for modeling purposes it is useful to simplify the flow directions
to the closest neighbouring cell, using $1$ of N, $2$ for NE, $3$ for E
and so on:

   8   1   2
  --- --- ---
   7   0   3
   6   5   4

Using 0 for cells with altitudes $\leq$ than the surroundings. These
cells are called *sinks*. *This simplified way of representing the
slopes is very useful to program how the water, or the ice, will move in
our map *cell by cell*.*

We can calculate flow direction following this simple approach:

>     %% Flow direction
>     FD=0.*Z; %% start with all cells as sinks
>     % remember that lower rows correspond to lower latitudes
>     kernelref=[6,5,4;7,0,3;8,1,2]; % direcction references
>
>     for r=2:nrows-1 % go though all the cells that are not at the borders
>       for c=2:ncols-1
>         Zkernel=Z(r-1:r+1,c-1:c+1);
>         if Z(r,c)==min(Zkernel(:)) % if sink
>           FD(r,c)=0;
>         else
>           % find the minimum Z
>           % get the first one if there are two minimums
>           position=find(Zkernel==min(Zkernel(:)),1,'first');
>           FD(r,c)=kernelref(position);
>         end
>       end
>     end

**Fill sinks**

If you plot the sinks in the map:

>             figure; hold on
>             sel=(FD==0); % selct sinks
>             plot(X(sel),Y(sel),'.r') % plot them in red
>             % overlap the controur plot
>             contour(X,Y,Z,[0.1,200:200:2000],'-k')

You will find that:

1.  The borders are considered sinks (as expected)

2.  The sea is considered a sink (as expected)

3.  There are too many sinks inland! This is a problem for our
    programming purposes: we know that, even if these sinks are real,
    the water would fill them and continue its way to the sea.

 \
To better mimic the behaviour of the water in our map, we should be able
to produce a flow-direction map where all the *rivers* go to the sea.

DEM manipulating programs usually have an option to fill sinks before
calculating flow-direction and flow-accumulation.

We can create our own sink filling algorithm by iteratively adding 1
meter of altitude to all sinks until we reach a DEM with no sinks.

Find an example of sink-filling code in the next slide.

    %% Fill sinks
    disp('Filling sinks...')
    Zfilled=Z; % start a new map (identical)
    convergence=0;
    step=0;
    baselevel=0; % sea level
    while convergence<1
      step=step+1;
      previoustotal=sum(Zfilled(:));
      for r=2:nrows-1 % ignore map borders
        for c=2:ncols-1 % ignore map borders
          % these are the elevations around Z(r,c), including (r,c)
          Zkernel=Zfilled(r-1:r+1,c-1:c+1);
          % find the minimum Z around (r,c). Ignore central value.
          minimumZkernel=min(Zkernel([1,2,3,4,6,7,8,9])); 
          if Zfilled(r,c)>baselevel % do not touch the sea
            % if it is a sink, add 1 m
            Zfilled(r,c)=max(Zfilled(r,c),minimumZkernel+1);
          end
        end
      end
      % If we reach equilibrium (no sinks)
      if sum(Zfilled(:))==previoustotal
        convergence=1;
        disp(['Sinks filled in ' num2str(step) ' steps'])
        disp([num2str(sum(Zfilled(:))-sum(Z(:))) ' total meters added'])
        disp([num2str((sum(Zfilled(:))-sum(Z(:)))/numel(Z)) ' average meters added'])
      end
    end
    Z=Zfilled; % replace our map!

**Flow accumulation**

The next "map" that is usually calculated on a DEM is the
flow-accumulation.

The flow-accumulation parameter records how many cells are upstream a
specific cell. Cells with a a high flow-accumulation correspond to
places collecting a lot of water: streams or rivers.

Imagine that there is a short and homogeneous rain on our DEM. Only one
*drop* falls on each of our cells. We can programmatically follow the
path of each of *drop* from the original cell to a **sink** using the
flow-direction map. If every time we move one cell downstream we add up
all the *drops* we will be calculating the flow-accumulation on our map.

The code in the next slide calculates the flow-accumulation by following
all the water paths.

    %% FLow-accumulation
    FA=zeros(size(Z)); % start with a dry map
    kernelref=[6,5,4;7,0,3;8,1,2]; % direcction references
    drref=[-1,-1,-1;0,0,0;1,1,1]; % row direction reference
    dcref=[-1,0,1;-1,0,1;-1,0,1]; % column direction reference
    for r=1:nrows
      for c=1:ncols
        convergence=0;
        prevr=r; prevc=c; % define previuos cell
        FA(prevr,prevc)=FA(prevr,prevc)+1; % leave a drop here
        % Start following the river downstream
        while convergence==0
          if FD(prevr,prevc)==0 % if sink
            convergence=1;
          else
            % select the next celldownhill: new row and column
            newr=prevr+drref(kernelref==FD(prevr,prevc));
            newc=prevc+dcref(kernelref==FD(prevr,prevc));
            % accumulate flow in the next cell
            FA(newr,newc)=FA(newr,newc)+1;
            prevr=newr;
            prevc=newc;
          end
        end
      end
    end

 \
Now you can plot the "rivers" as the cells with more *drops* than the
average:

>     figure; hold on
>     sel=(FA>mean(FA(:))); % select cells with many drops
>     plot(X(sel),Y(sel),'.b') % plot the rivers
>     % overlap the controur plot
>     contour(X,Y,Z,[0.1,200:200:2000],'-k')

**Catchment related calculations**

Once we have calculated the flow-direction and flow-accumulation
matrices (`FD` and `FA`), we can start calculating parameters that can
be useful in Earth sciences.

There are many geological processes (e.g. erosion) that depend on what
is happening upstream a certain point.

A useful parameter that we might want to know is the average altitude of
the upstream catchment at any point in our DEM.

To calculate the average upstream altitude, we can recycle the structure
we used for the flow-accumulation calculation and calculate the
"accumulated altitude" at every cell of the map. To calculate the
average upstream altitude we will just need to divide the accumulated
altitude by the flow accumulation.

        %% Catchment altitude
        AccumZ=Z; % start with the same DEM
        kernelref=[6,5,4;7,0,3;8,1,2]; % direcction references
        drref=[-1,-1,-1;0,0,0;1,1,1]; % row direction reference
        dcref=[-1,0,1;-1,0,1;-1,0,1]; % column direction reference
        for r=1:nrows
          for c=1:ncols
            convergence=0;
            prevr=r; prevc=c; % define original cell
            % Start following the river downstream
              while convergence==0
              if FD(prevr,prevc)==0 % if sink
                convergence=1;
              else
                % select the next celldownhill: new row and column
                newr=prevr+drref(kernelref==FD(prevr,prevc));
                newc=prevc+dcref(kernelref==FD(prevr,prevc));
                % accumulate Z in the next cell
                AccumZ(newr,newc)=AccumZ(newr,newc)+Z(r,c);
                prevr=newr;
                prevc=newc;
              end
            end
          end
        end
        AverageZ=AccumZ./FA;

Exercise: model glaciations
---------------------------

**Scottish glaciers (again)**

Using the climate and mass balances defined in the first chapter (slide
[\[climatedata\]](#climatedata){reference-type="ref"
reference="climatedata"} and onwards), and assuming average temperatures
4$^\circ$C below current ones and monthly precipitation 100 mm above
current ones, model the Scottish glaciers during Younger Dryas.

Consider that a glacier will be present in places with upstream mass
balances above 0.

Plot the results.

 \
The output map should look like this:

![image](glacialmodel.pdf){width="60%"}

 \
Does the output look similar to what we know from geology?

![MacLeod *et al.* (2011).[]{label="MacLeod"}](MacLeod.jpg){#MacLeod
width="100%"}

Why?
