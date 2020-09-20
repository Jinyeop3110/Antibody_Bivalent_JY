%%
% Written by Jinyeop Song, 2020/07/13 
% This is the demo code for Antibody_ThermoCalc_JY.
% To run the code, follow the description of each sections.

%% Setting System Parameters
clc; clear;

% To change
addpath(genpath('D:\JY_matlab\Antibody_Bivalent_JY')) % Add the entire path of Antibody_ThermoCalc_JY

% To change
Kd1=20*10^-9; % antibody - target Kd

% To change
Kd2_list=1.1040*10^(-4)*[0, exp(log(10)*linspace(-4.0,4.0,15))] % 20*10^-6 * [0, exp(log(10)*linspace(-1,2,31))]; % weak-binding linker Kd List. Usually recommend to set exponentially-linear spaced values.
N_avogadro=6.02*10^23;0

% To change
r_eff = 5.0 % effective radius of weak-binding linker radius, in (nm)

% To change
Cr= 10^2; % Correction ratio, reccommemnd Cr=10^2 to 10^4

V_eff=4/3*pi*(r_eff*10^-9)^3*1000*Cr; % effective volume in (L)
Kd2_eff_list=Kd2_list*N_avogadro*V_eff; % effective Kd2 list

% To change
pA=10^-9; % antibody concentration

% To change
type="square2D"; % Choose among "linear1D", "circle1D", "square2D", "traingularSphere2D" ,"cubicSphere2D"

% To change 
WperT=2; % number of Weak-binding tether per an antigen
Wlen=1.5; % length of weak teather, in relative scale

% To change 
isSC=0; % set 1 for considering self-cohesion, 0 for not considering


% To change
Tnum=9; % number of antigen number. If Tnum is not allowed by the chosen "type", Tnum is set to nearest allowed value. 

% To change
MCMC_steps=10; %% Number of MCMC steps, typically set >5.


disp("Parameter setting done")
%% Setting MCMC step Parameters
TestTime=1*2^4;
Project_title = "MMDD_square2D_Tnum98_demo";
IsSave=0; % set 1 to save data, 0 fotherwise
ProbS=zeros(size(Kd2_list,2),TestTime);


%% Run MCMC

if ~isfolder("Data\"+Project_title+"_")
    mkdir("Data\"+Project_title+"_")
end

parfor i=1:size(Kd2_list,2)
    ProbS(i,:)=par_Metropolis(Project_title,type,Tnum,Kd1,Kd2_list(i),Kd2_eff_list(i),pA,TestTime, MCMC_steps, WperT, Wlen, isSC)
end

sys_model=Init_AT_System(type,Tnum,WperT, Wlen);

if IsSave
    save("Data\"+Project_title+".mat",'TestTime','Kd2_list','Kd1','V_eff','Kd2_eff_list','pA','sys_model','Tnum','type','ProbS')
end
disp("MCMC done")

%% Drawing figures
cmap=hsv(10);

figure()
dataname=type+" Tnum:"+int2str(Tnum)
semilogx(Kd2_list(2:size(Kd2_list,2)),mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum,'-o','Color',cmap(2,:),'MarkerEdgeColor',cmap(2,:))
hold on
semilogx([0.5*min(Kd2_list(2:size(Kd2_list,2))),2*max(Kd2_list(2:size(Kd2_list,2)))],[pA/Kd1, pA/Kd1],'Color','blue','LineStyle','--')
title("Kd_2 vs Kd_eff")
xlabel("log(Kd2)")
ylabel("bounding #")

legend([dataname "Control"])
if IsSave
    a=sprintf('%s.', datestr(now,'mm-dd-yyyy HH-MM'));
    saveas(gcf,"Figure\fig_"+a+".fig")
    saveas(gcf,"Figure\fig_"+a+".png")
end

figure()
dataname=type+" Tnum :"+int2str(Tnum)
loglog(Kd2_list(2:size(Kd2_list,2)),pA*(1-mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum)./(mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum),'-o','Color',cmap(2,:),'MarkerEdgeColor',cmap(2,:))
hold on
semilogx([0.5*min(Kd2_list(2:size(Kd2_list,2))),2*max(Kd2_list(2:size(Kd2_list,2)))],[Kd1, Kd1],'Color','blue','LineStyle','--')
title("Kd_2 vs Kd_eff")
xlabel("log(Kd2)")
ylabel("log(Kd_eff)")

legend([dataname "Control"])
if IsSave
    a=sprintf('%s.', datestr(now,'mm-dd-yyyy HH-MM'));
    saveas(gcf,"Figure\fig_"+a+".fig")
    saveas(gcf,"Figure\fig_"+a+".png")
end

disp("drawing done")

%% This is function for paraellel computing of MCMC
function ProbS_column = par_Metropolis_withW(Project_title,type,Tnum,Kd1,Kd2,Kd2_eff,pA,TestTime, MCMC_num)

ProbS_column=zeros(1,TestTime);

%disp("start simulation for kD2="+ string(kD2))
sys = Init_AT_System(type,Tnum);
for t=1:TestTime
    if rem(t,2^10)==0
        %disp("Done simulation for kD2="+ string(Kd2_list(i))+" & t="+string(t/2^10)+" th 2^10")
    end
    sys = Reinitialize(sys);
    for j=1:MCMC_num
        sys = Metropolis_withW(sys,Kd1,Kd2,Kd2_eff,pA);
    end
    ProbS_column(1,t)=CalculateBindingNum(sys);
end
sys_model=sys;
save("Data\"+Project_title+"_\"+"Kd1_"+string(Kd1)+"___Kd2_"+string(Kd2)+".mat",'TestTime','Kd2','Kd1','Kd2_eff','pA','sys_model','Tnum','type','ProbS_column')

end
