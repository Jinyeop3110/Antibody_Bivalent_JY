%%
clc; clear;
%% Setting System Param
kD1=20*10^-9; % antibody - target
kD2_list=20*10^-6 * [0, exp(log(10)*linspace(-1,2,5))]; % weak-binding
N_avogadro=6.02*10^23;
V_eff=4/3*pi*(100*10^-10)^3*1000;
kD2_eff_list=kD2_list*N_avogadro*V_eff;
pA=10^-9;
type="cubicSphere2D"; % "linear1D", "circle1D", "square2D", "traingularSphere2D" ,"cubicSphere2D"
Tnum=98;
%% Setting Exp param
TestTime=2*2^10;
Project_title = "0704_cubicSphere2D_Tnum98_TEST1";
ProbS=zeros(size(kD2_list,2),TestTime);

%% Initiate AT system

for i=1:size(kD2_list,2)
    disp("start simulation for kD2="+ string(kD2_list(i)))
    sys = Init_AT_System(type,Tnum);
    for t=1:TestTime
        if rem(t,2^10)==0
            disp("Done simulation for kD2="+ string(kD2_list(i))+" & t="+string(t/2^10)+" th 2^10")
        end
        sys = Reinitialize(sys);
        for j=1:30
            sys = Metropolis_withW(sys,kD1,kD2_list(i),kD2_eff_list(i),pA);
        end
        ProbS(i,t)=CalculateBindingNum(sys);
    end
end


save("Data\"+Project_title+".mat",'TestTime','kD2_list','kD1','V_eff','kD2_eff_list','pA','sys','Tnum','type','ProbS')
disp("MCMC done")
%% 
Tnum=sys.Tnum;
figure()
semilogx(kD2_list(2:size(kD2_list,2)),mean(ProbS(2:size(kD2_list,2),:),2)/Tnum)
hold on
scatter(kD2_list(2:size(kD2_list,2)),mean(ProbS(2:size(kD2_list,2),:),2)/Tnum,'o','blue')
title(type+" / Kd_2 vs bounding %")
xlabel("log(Kd2)")
ylabel("bounding %")
axis([0.01 1000 0 1])
saveas(gcf,"Figure\"+Project_title+"___kd2vsbounding.png")

figure()
loglog(kD2_list(2:size(kD2_list,2)),(mean(ProbS(2:size(kD2_list,2),:),2)/Tnum)/pA./(1-mean(ProbS(2:size(kD2_list,2),:),2)/Tnum))
hold on
loglog([0.01,1000],[kD1, kD1],'Color','red','LineStyle','--')
hold on
A=max((mean(ProbS(2:size(kD2_list,2),:),2)/Tnum)/pA./(1-mean(ProbS(2:size(kD2_list,2),:),2)/Tnum))
scatter(kD2_list(2:size(kD2_list,2)),(mean(ProbS(2:size(kD2_list,2),:),2)/Tnum)/pA./(1-mean(ProbS(2:size(kD2_list,2),:),2)/Tnum),'o','blue')
hold on
title(type+" / Kd_2 vs Kd_eff")
xlabel("log Kd2")
ylabel("log Kd_eff")
axis([0.01 1000 0 10000+0.1])
saveas(gcf,"Figure\"+Project_title+"___kd2vskdeff.png")

disp("save done")


