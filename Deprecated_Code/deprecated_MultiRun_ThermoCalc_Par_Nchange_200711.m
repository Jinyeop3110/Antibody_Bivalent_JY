%%
clc; clear;
%% Setting System Param
kD1=20*10^-9; % antibody - target
kD2_list= 160*10^-6 * [0, exp(log(10)*linspace(-1,2,63))]; % weak-binding
N_avogadro=6.02*10^23;
R_eff=5; % Aongstrom
V_eff=4/3*pi*(R_eff*10^-9)^3*1000;
kD2_eff_list=kD2_list*N_avogadro*V_eff;
pA=10^-9;
type="square2D"; % "linear1D", "circle1D", "square2D", "traingularSphere2D" ,"cubicSphere2D"
Tnum_list=[900];
%% Setting Exp param

for j=1:size(Tnum_list,2)
    TestTime=50*2^10;
    Tnum=Tnum_list(j);
    Project_title = "0711_square2D_Tnum"+int2str(Tnum)+"_Nchange";
    ProbS=zeros(size(kD2_list,2),TestTime);
    
    %% Initiate AT system
    
    if ~isfolder("Data\"+Project_title+"_")
        mkdir("Data\"+Project_title+"_")
    end
    
    parfor i=1:size(kD2_list,2)
        ProbS(i,:)=par_Metropolis_withW(Project_title,type,Tnum,kD1,kD2_list(i),kD2_eff_list(i),pA,TestTime, 200)
    end
    
    sys_model=Init_AT_System(type,Tnum);
    save("Data\"+Project_title+".mat",'TestTime','kD2_list','kD1','R_eff','V_eff','kD2_eff_list','pA','sys_model','Tnum','type','ProbS')
    disp("MCMC done : Tnum / "+int2str(Tnum))
end
%%
%%
function ProbS_column = par_Metropolis_withW(Project_title,type,Tnum,kD1,kD2,kD2_eff,pA,TestTime, MCMC_num)

ProbS_column=zeros(1,TestTime);

%disp("start simulation for kD2="+ string(kD2))
sys = Init_AT_System(type,Tnum);
for t=1:TestTime
    if rem(t,2^10)==0
        %disp("Done simulation for kD2="+ string(kD2_list(i))+" & t="+string(t/2^10)+" th 2^10")
    end
    sys = Reinitialize(sys);
    for j=1:MCMC_num
        sys = Metropolis_withW(sys,kD1,kD2,kD2_eff,pA);
    end
    ProbS_column(1,t)=CalculateBindingNum(sys);
end
sys_model=sys;
save("Data\"+Project_title+"_\"+"Kd1_"+string(kD1)+"___Kd2_"+string(kD2)+".mat",'TestTime','kD2','kD1','kD2_eff','pA','sys_model','Tnum','type','ProbS_column')

end
