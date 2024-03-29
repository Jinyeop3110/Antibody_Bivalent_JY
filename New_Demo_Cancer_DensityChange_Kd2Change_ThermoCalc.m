%%
% Written by Jinyeop Song, 2020/07/20
% This is the demo code for Antibody_ThermoCalc_JY.
% To run the code, follow the description of each sections.

%% Setting System Parameters
clc; clear;

% To change
addpath(genpath('D:\JY_matlab\Antibody_Bivalent_JY')) % Add the entire path of Antibody_ThermoCalc_JY

% To change
Kd1=10*10^-9; % antibody - target Kd

% To change
Kd2_list=1.00*10^(-5)*[0, exp(log(10)*linspace(-3.0,3.0,31))] % 20*10^-6 * [0, exp(log(10)*linspace(-1,2,31))]; % weak-binding linker Kd List. Usually recommend to set exponentially-linear spaced values.
N_avogadro=6.02*10^23;

% To change
r_eff = 5.0; % effective radius of weak-binding linker radius, in (nm)

% To change
Cr= 10; % Correction ratio, reccommemnd Cr=10^2 to 10^4

V_eff=4/3*pi*(r_eff*10^-9)^3*1000*Cr; % effective volume in (L)
Kd2_eff_list=Kd2_list*N_avogadro*V_eff; % effective Kd2 list

% To change
pA=10^-9; % antibody concentration

% To change
type="randomQuasiSphere2D"; % Choose among randomUniformFlat2D randomUniformSphere2D randomQuasiFlat2D randomQuasiSphere2D

% To change 
WperT=2; % number of Weak-binding tether per an antigen
Wlen=1.5; % length of weak teather, in relative scale

% To change 
isSC=0; % set 1 for considering self-cohesion, 0 for not considering

% To change
L=10; % total area of the surface
density_List = [0.5 1.0 2.0] %[0.5 2.0 5.0] ; % list density of antigen on the surface
Tnum_List=floor(L*density_List);
% So, the total number of antigen (Tnum) becomes L*density

% To change
MCMC_steps=10; %% Number of MCMC steps, typically set >5.

% To change
disp("Parameter setting done")

%% Setting MCMC step Parameters
TestTime=10*2^1;
Project_title = "DensityChange_demo_rung_log";
IsSave=1; % set 1 to save data, 0 fotherwise
ProbS=zeros(size(density_List,2), size(Kd2_list,2), TestTime);
cmap=0.8*hsv(10);
cmap(1,:)=[0.75 0.1 0.1];

%% MCMC

if ~isfolder("Data/"+Project_title+"_")
    mkdir("Data/"+Project_title+"_")
end

for j=1:size(density_List,2)
    density=density_List(j);
    Tnum=Tnum_List(j);
    parfor i=1:size(Kd2_list,2)
        ProbS(j, i,:)=par_Metropolis_RS(Project_title,type,L, density,Kd1,Kd2_list(i),Kd2_eff_list(i),pA,TestTime, MCMC_steps, WperT, Wlen, isSC)
    end
    

end
sys_model= Init_AT_System_RS(type,L,density, WperT, Wlen);

if IsSave
    save("Data/"+Project_title+".mat",'TestTime','Kd2_list','density_List','Kd1','V_eff','Kd2_eff_list','pA','Tnum_List','type','ProbS', 'WperT', 'Cr', 'isSC')
end

disp("MCMC done")


%% Drawing with Cohesion
% bounding %


figure();
k=1;
Legend=[];


data2=[];
for i=2:size(Kd2_list,2)
    data2=[data2 0 ]%Cohesion(Kd2_list(i),pA,WperT)];
end
yyaxis right
semilogx(Kd2_list(2:size(Kd2_list,2)),data2,'-d','Color',cmap(1,:),'MarkerEdgeColor',cmap(1,:))
axis([0.5*min(Kd2_list(2:size(Kd2_list,2))) 2*max(Kd2_list(2:size(Kd2_list,2))) 0 1])
hold on
ylabel("Self Cohesion %")
set(gca,'ycolor',cmap(1,:)) 


for j=1:size(density_List,2)
    k=k+1;
    density=density_List(j);
    Tnum=Tnum_List(j);
    yyaxis left
    dataname="Density : " +num2str(density)% Change dataname
    Legend=[Legend dataname];
    % if you wanna choose different values,
    semilogx(Kd2_list(2:size(Kd2_list,2)),mean(ProbS(j, 2:size(Kd2_list,2),:),3)/Tnum,'-o','Color',cmap(k,:),'MarkerEdgeColor',cmap(k,:));ylabel("log(Kd_eff)");
    
end
axis([min(Kd2_list(2:size(Kd2_list,2))) max(Kd2_list(2:size(Kd2_list,2))) 0 1])
set(gca,'ycolor','black')
ylabel("Antigen Binding %")




yyaxis left
data3name="Control"
semilogx([0.5*min(Kd2_list(2:size(Kd2_list,2))),2*max(Kd2_list(2:size(Kd2_list,2)))],[pA/Kd1, pA/Kd1],'Color','blue','LineStyle','--')
hold on
title("Kd_2 vs Antigen Binding %")
xlabel("log(Kd2)")

legend([ Legend "Control" "Self Cohesion" ], 'Location','northeast')

a=[sprintf('%s', datestr(now,'mm-dd-yyyy HH-MM_')) int2str(randi(500))];
if IsSave
saveas(gcf,"Figure\fig_withCohesion_"+a+".fig")
saveas(gcf,"Figure\fig_withCohesion_"+a+".png")
end


%%
figure();
k=1;
Legend=[];

data2=[];
for i=2:size(Kd2_list,2)
    data2=[data2 Cohesion(Kd2_list(i),pA,WperT)];
end
yyaxis right
semilogx(Kd2_list(2:size(Kd2_list,2)),data2,'-d','Color',cmap(k,:),'MarkerEdgeColor',cmap(k,:))
axis([0.5*min(Kd2_list(2:size(Kd2_list,2))) 2*max(Kd2_list(2:size(Kd2_list,2))) 0 1])
hold on
ylabel("Self Cohesion %")
set(gca,'ycolor',cmap(k,:)) 


for j=1:size(density_List,2)
    k=k+1;
    density=density_List(j);
    Tnum=Tnum_List(j);
    yyaxis left
    dataname="Density : " +num2str(density)% Change dataname
    Legend=[Legend dataname];
    % if you wanna choose different values,
    loglog(Kd2_list(2:size(Kd2_list,2)),pA*(1-mean(ProbS(j, 2:size(Kd2_list,2),:),3)/Tnum)./(mean(ProbS(j, 2:size(Kd2_list,2),:),3)/Tnum),'-o','Color',cmap(k,:),'MarkerEdgeColor',cmap(k,:));hold on;
    
end



yyaxis left
data3name="Control"
loglog([0.5*min(Kd2_list(2:size(Kd2_list,2))),2*max(Kd2_list(2:size(Kd2_list,2)))],[Kd1, Kd1],'Color','blue','LineStyle','--')
hold on

yyaxis left
axis([0.5*min(Kd2_list(2:size(Kd2_list,2))) 2*max(Kd2_list(2:size(Kd2_list,2))) 10^(-4.0)*Kd1 1.5*Kd1])
set(gca,'Yscale','log')
set(gca,'ycolor','black')
ylabel("log(Kd_eff)")
title("Kd_2 vs Kd_eff")
xlabel("log(Kd2)")
legend([ Legend "Control" "Self Cohesion" ], 'Location','southeast')

a=[sprintf('%s', datestr(now,'mm-dd-yyyy HH-MM_')) int2str(randi(500))];
if IsSave
saveas(gcf,"Figure\fig_withCohesion_"+a+".fig")
saveas(gcf,"Figure\fig_withCohesion_"+a+".png")
end



