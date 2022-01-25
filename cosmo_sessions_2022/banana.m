%% BANANA
% Self-contained script to plot the concentrations of 2 cosmonuclides in a banana-plot
% It also calculates the erosion rates and burial ages corresponding to the sample concentrations
% Angel Rodes, SUERC, 2022

%% Clear everything
clear % remove variables stored in memory
clc % clear the command window
close all hidden % remove previous plots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Input data
% We need the folllgoing inputs: concentrations, decay constants, attenuation lengths, and basin production rates (for spallation and muons)

% As an example, we will use the sample from Shanshu Cave (SSC) from Liu et al. (2022) [https://doi.org/10.1016/j.quageo.2021.101237]
% The CRONUS input corresponding to this sample is:

% SSC	27.0845	105.1631	1800	std	0	2.6	1	0	2019;
% SSC	Be-10	quartz	111756	3409	NIST_27900;
% SSC	Al-26	quartz	416017	31939	Z92-0222;
% As described in the old-CRONUS v.3 page [https://hess.ess.washington.edu/math/docs/v3/v3_input_explained.html]

% We will need the concentrations and uncertainties:
C10=111756; % atoms/g
dC10=3409; % atoms/g
C26=416017; % atoms/g
dC26=31939; % atoms/g
% the sample name:
sample_name='SSC';
% and the density of the rock at the source area:
density=2.6; % g/cm^3 (or kg per litre)

% We can input the CRONUS-input lines in the old-CRONUS v.3 erosion rate calculator [https://hess.ess.washington.edu/math/v3/v3_erosion_in.html]
% Remember to remove theinitial comment symbol (%) first!
% These are the apparent erosion rates that we get for the LSDn scaling:

% Sample name	Nuclide	Erosion rate (m/Myr)	External uncert (m/Myr)
% SSC 	Be-10 (qtz)	65 	4.34
% SSC 	Al-26 (qtz)	116 	13.5

% We cal use these data to approximate the long-term average-prodution-rates using the "Average cosmogenic production rate calculator":
% https://github.com/angelrodes/average_cosmogenic_production_rate_calculator/blob/main/Average_cosmo_prodution.xlsx?raw=true

% And we get:
% * Attenuation lengths for Spallation, Fast muons 1, Fast muons 2, and Negative muons
L=[160 850 5000 500]'; % g/cm^2
% * Be-10 prodution rates for Spallation, Fast muons 1, Fast muons 2, and Negative muons
P10=[11.55428 0.02308 0.00769 0.06518]'; % atoms/g/year at the source area
% * Al-26 prodution rates for Spallation, Fast muons 1, Fast muons 2, and Negative muons
P26=[75.9237 0.1543 0.0514 0.7175]'; % atoms/g/year at the source area
% note that we add an apostrophe after the array to convert it into a column
% * Be-10 decay constant (lambda)
l10=4.9975E-07; % years^-1
% * Al-26 decay constant (lambda)
l26=9.8319E-07; % years^-1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Now we need to define our model
% The erosion-burial model was described by Lal (1991): figure 6
% [https://doi.org/10.1016/0012-821X(91)90220-C]
% Here, we will express the equations as shown in Rodes et al. (2014): equations 4 and 5
% [https://doi.org/10.1016/j.quageo.2013.10.002]
Model = @(Prodution_rates,Attenuation_lengths,decay_constant,erosion,time)...
   sum( (Prodution_rates./(erosion.*density./Attenuation_lengths+decay_constant)).*exp(-time*decay_constant) ,1);
% note that we use .* and ./  instead of * and / to allow using lost of erosion and times as horizontal arrays.
% also note that we sum in the direction "1" to sum the nuclides produced by all the production mechanism (columns; vertical arrays) that are listed in 4 rows

% Simplify for Be-10 and Al-26
Model10 = @(erosion,time) Model(P10,L,l10,erosion,time);
Model26 = @(erosion,time) Model(P26,L,l26,erosion,time);
% also simplify for ratio
Model_ratio = @(erosion,time) Model(P26,L,l26,erosion,time)./Model(P10,L,l10,erosion,time);

% Play with this:
% Model10(0,0)
% Model10(0,1500000)
% Model_ratio(100/1E4,0)
% Model_ratio(0,0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plot our banana
% define what values we want to plot:
erosion_array=[0 1 10 100 1000 10000]/1E4; % cm/year (m/Ma divided by 1E4)
time_array=[0 0.1 0.5 1 1.5 2 3 4 6 8 10 15 20]*1E6; % years (Ma multiplied by 1E6)

% define the points for each line:
points_per_line=1000; % banana lines will be defined by this number of points
many_erosions=[0,logspace(-2,6,points_per_line-1)]/1E4; % cm/year (m/Ma divided by 1E4)
many_times=[0, logspace(0,8,points_per_line-1)]; % years

% Start figure
figure % open a new figure
hold on % do not clear it

% Write labels and title
xlabel('Be-10')
ylabel('Al-26/Be-10')
title('My first banana plot')

% plot erosion rates
for er=erosion_array
  x=Model10(er,many_times);
  y=Model_ratio(er,many_times);
  plot(x,y,'-b') % plot blue line
  text(x(1),y(1),[num2str(er*1e4) ' m/Ma'],'Color','b') % plot blue text
end

% plot times
for t=time_array
  x=Model10(many_erosions,t);
  y=Model_ratio(many_erosions,t);
  plot(x,y,'-r') % plot red line
  text(x(1),y(1),[num2str(t/1e6) ' Ma'],'Color','r') % plot red text
end


% Set logarithmic X axis
set(gca, 'XScale', 'log')
% You might do the dame with YScale

% Set nice limits
xlim([ 100 Model10(0,0)*1.2]) % between 100 atoms/g and 20% more than saturation
% you can comment the line to see what happens when you do not set limits

% There are other options to beautify the figure:
% box on
% grid on
% You can also play with colors in the plot and text functions.
% You can play with 'LineWidth' in the plot function too.

%% Plot the sample
% This is the traditional (ugly) way:
plot(C10,C26/C10,'.k') % center of the sample (k is for black)
plot([C10-dC10 , C10+dC10] , [C26/C10 , C26/C10],'-k') % horizontal uncertainty
plot([C10 , C10] , [(C26-dC26)/C10 , (C26+dC26)/C10],'-k') % vertical uncertainty

% I prefer this code, that represents the one-sigma-uncertainty-space with an ellipse
theta=linspace(0,2*pi,100); % use 100 points for the ellipse
x =  C10+dC10*sin(theta);
y = (C26+dC26*cos(theta)) ./ (C10+dC10*sin(theta));
plot(x,y,'-g') % green ellipse
text(x(1),y(1),sample_name,'Color','g') % green text
% maths behind this:
% all the points in the elliplse has chisq=1 because
% chisq = ((Model10-C10)/dC10)^2 + ((Model26-C26)/dC26)^2 = sin(theta)^2 + cos(theta)^2 = 1
% for any theta

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Solving the erosion rate and burial time of the sample
% we want to solve er and t in the following equations:
% C10 = Model10(er,t)
% C26 = Model26(er,t)
% unfortunately, these equations have no symbolic solution.
% However, there are muliple ways of solving the problem. Here we will use an iterative method for the central porint (C10, C26/C10):

% our objective is guetting the er and t values that yield models that correposnd to our concentrations
% therefore, our objectives are the sample conventrations:
Obj_10=C10;
Obj_26=C26;
% and their uncertainties
dObj_10=dC10;
dObj_26=dC26;

% start with a guess
guess_t=0; % start with no burial
guess_er=interp1(Model10(many_erosions,guess_t),many_erosions,Obj_10); % find the corresponding eosion
chisq= ((Obj_10-Model10(guess_er,guess_t))/dObj_10)^2 + ((Obj_26-Model26(guess_er,guess_t))/dObj_26)^2; % calculate how close we are to  C10 and C26

% start iterating
iteration_number=0;
while chisq<2e-4 % try to achieve a solution very close to C10 and C26 (chisq<2e-4 correponds to the 1% central area of the ellipse)
  iteration_number=iteration_number+1; % this is just a counter
  guess_t=interp1(Model_ratio(guess_er,many_times),many_times,Obj_26/Obj_10); % find the corresponding burial age using the ratio
  guess_er=interp1(Model10(many_erosions,guess_t),many_erosions,Obj_10); % find the corresponding eosion
  chisq= ((Obj_10-Model10(guess_er,guess_t))/dObj_10)^2 + ((C26-Model26(guess_er,guess_t))/dObj_26)^2; % calculate how close we are to  C10 and C26
  disp([ 'Iteration ' num2str(iteration_number) ': Chi-sq = ' num2str(chisq)]) % show some information
end

% display our guesses:
disp('Final guesses:')
disp([ 'Burial age = ' num2str(guess_t/1e6) ' Ma'])
disp([ 'erosion rate = ' num2str(guess_er*1e4) ' m/Ma'])

% plot guess results
plot(Model10(guess_er,guess_t),Model_ratio(guess_er,guess_t),'*m') % magenta star

% We also want to get the results correponding to all the points in the ellipse, 
% or at least the results corresponding to the limits of  C10 +/- dC10 and C26 +/- dC26.
% To get those results, you will need to put the "solver" above in a loop for all the objectives we want to fit.

% If we have samples that plot in the forbidden area you might want to:
% - Include negative ages in the variable many_timnes.
% - Modify INTERP1 function to allow extrapolations.
% - Include a BREAK in the iteration loop if iteration_number gets very big or if results make no sense.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Further exercises you might want to try are:
%    - Change the isotopes. E.g. change Be-10 and Al-26 by Ne-21 and Be-10. To recycle this code with "stable" isotopes, you can assign them a ridiculously slow decay constant (eg. 1E-36, see https://angelrodes.wordpress.com/2022/01/25/are-he-3-and-ne-21-stable-isotopes/).
%    - Represent everything scaled to the production rate ratios sum(P10) and sum(P26). This is useful if you want to represent several samples (with different basin production rates) in the same banana.
%    - Modify the model to plot "pot-bellied bananas" that include the effect of muon-produced cosmuniclides while the sample is buried. (e.g., Hidy et al., 2013; figure 4; https://doi.org/10.1016/j.quascirev.2012.11.009
