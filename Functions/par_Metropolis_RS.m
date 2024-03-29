function ProbS_column = par_Metropolis_RS(Project_title,type,L,density,Kd1,Kd2,Kd2_eff,pA,TestTime, MCMC_num, WperT, Wlen, isSC)

destroy_ratio=0.5;
destroy_repnum=3;
destroy_limit=floor(MCMC_num/3*2);

ProbS_column=zeros(1,TestTime);

RemainRatio_pA=1;
if isSC
    RemainRatio_pA=1-Cohesion(Kd2,pA, WperT);
    pA=RemainRatio_pA*pA;
end

%disp("start simulation for kD2="+ string(kD2))

for t=1:TestTime
    
    if rem(t,2^10)==0   
        %disp("Done simulation for kD2="+ string(Kd2_list(i))+" & t="+string(t/2^10)+" th 2^10")
    end
    
    sys = Init_AT_System_RS(type,L,density, WperT, Wlen);
    
    for j=1:MCMC_num
        
        sys = Metropolis_withW(sys,Kd1,Kd2,Kd2_eff,pA);
        
        
        if j<destroy_limit
            a=1;
        end
    end
    
    ProbS_column(1,t)=CalculateBindingNum(sys);
    
end

sys_model=sys;
save("Data\"+Project_title+"_\"+"Kd1_"+string(Kd1)+"___Kd2_"+string(Kd2)+".mat",'TestTime','Kd2','Kd1','Kd2_eff','pA','sys_model','density','L','type','ProbS_column','RemainRatio_pA')



end
