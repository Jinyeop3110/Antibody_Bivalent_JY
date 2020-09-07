
%% Log scale
Kd2_list= 1.0*10^(-4) *[0, exp(log(10)*linspace(-4.0,4.0,15))]; % From -4~4, sampling 15+1(zero) values


%% Linear scale 
maxval = 1.0^(-6) % max value
minval = 1.0^(-3) % min value
N = 15 % number of sampling
Kd2_list = [0, linspace(minval,maxval, N)];
