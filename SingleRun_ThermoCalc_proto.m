clc; clear;
addpath(genpath('D:\JY_matlab\Antibody_ThermoCalc_JY\AntonSemechko-S2-Sampling-Toolbox-79cc337'))
%% Setting Param
kD1=20*10^-9; % antibody - target
kD2=20*10^-5; % weak-binding
N_avogadro=6.02*10^23;
V_eff=4/3*pi*(100*10^-10)^3*1000;
kD2_eff=kD2*N_avogadro*V_eff;
pA=10^-9;
WperT=2;
type="cubicSphere2D"; % "linear1D", "circle1D", "square2D", "traingularSphere2D" ,"cubicSphere2D"
Tnum=98;
%% Initiate AT system


sys = Init_AT_System(type,Tnum,WperT);
for i=1:20
    sys = Metropolis_withW(sys,kD1,kD2,kD2_eff,pA)
    sys = Metropolis_withW(sys,kD1,kD2,kD2_eff,pA)
    sys = Metropolis_withW(sys,kD1,kD2,kD2_eff,pA)
end
sys = Metropolis_withW(sys,kD1,kD2,kD2_eff,pA)

Visualize(sys)


save("haha")