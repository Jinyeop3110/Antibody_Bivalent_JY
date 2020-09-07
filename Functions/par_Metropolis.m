%%
function ProbS_column = par_Metropolis(Project_title,type,Tnum,kD1,kD2,kD2_eff,pA,TestTime, MCMC_num, WperT, isSC)

ProbS_column=zeros(1,TestTime);

RemainRatio_pA=1;
if isSC
    RemainRatio_pA= 1 - Cohesion(Kd2, pA, WperT);
    pA=RemainRatio_pA*pA;
end

%disp("start simulation for kD2="+ string(kD2))
sys = Init_AT_System(type,Tnum, WperT);
for t=1:TestTime
    if rem(t,2^10)==0
        %disp("Done simulation for kD2="+ string(kD2_list(i))+" & t="+string(t/2^10)+" th 2^10")
    end
    sys = Init_AT_System(type,Tnum, WperT);
    for j=1:MCMC_num
        sys = Metropolis_withW(sys,kD1,kD2,kD2_eff,pA);
    end
    ProbS_column(1,t)=CalculateBindingNum(sys);
end
sys_model=sys;
save("Data\"+Project_title+"_\"+"Kd1_"+string(kD1)+"___Kd2_"+string(kD2)+".mat",'TestTime','kD2','kD1','kD2_eff','pA','sys_model','Tnum','type','ProbS_column', 'RemainRatio_pA')

end
