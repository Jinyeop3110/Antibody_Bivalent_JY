% Figure drawing v2 - 200711
%% Nchange
clc; clear;
cmap=hsv(10);
Tnum_list=[4 9 16 25 49 64 100 256 ]%900];
issave=1;
%% 
figure()
lgd=[];
j=0;

for j=1:size(Tnum_list,2)
Tnum=Tnum_list(j);
datapath = "Data\0711_square2D_Tnum"+int2str(Tnum)+"_Nchange.mat";
dataname="Tnum="+int2str(Tnum);
lgd=[lgd dataname];
load(datapath)
semilogx(kD2_list(2:size(kD2_list,2)),mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum,'-o','Color',cmap(j,:),'MarkerEdgeColor',cmap(j,:))
hold on
end



semilogx([0.5*min(kD2_list(2:size(kD2_list,2))),2*max(kD2_list(2:size(kD2_list,2)))],[pA/kD1, pA/kD1],'Color','blue','LineStyle','--')
title("Kd_2 vs bounding #")
xlabel("log(Kd2)")
ylabel("bounding #")
lgd=[lgd "Control"];

legend(lgd)
a=[sprintf('%s', datestr(now,'mm-dd-yyyy HH-MM_')) int2str(randi(500))];
if issave
saveas(gcf,"Figure\fig_"+a+".fig")
saveas(gcf,"Figure\fig_"+a+".png")
end

%%
%%
%% 
figure()
lgd=[];
j=0;

for j=1:size(Tnum_list,2)
Tnum=Tnum_list(j);
datapath = "Data\0711_square2D_Tnum"+int2str(Tnum)+"_Nchange.mat";
dataname="Tnum="+int2str(Tnum);
lgd=[lgd dataname];
load(datapath)
loglog(kD2_list(2:size(kD2_list,2)),pA*(1-mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum)./(mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum),'-o','Color',cmap(j,:),'MarkerEdgeColor',cmap(2,:))
hold on
end



semilogx([0.5*min(kD2_list(2:size(kD2_list,2))),2*max(kD2_list(2:size(kD2_list,2)))],[kD1, kD1],'Color','blue','LineStyle','--')
title("Kd_2 vs Kd_eff")
xlabel("log(Kd2)")
ylabel("log(Kd_eff)")
lgd=[lgd "Control"]
legend(lgd)

legend(lgd)
a=[sprintf('%s', datestr(now,'mm-dd-yyyy HH-MM_')) int2str(randi(500))];
if issave
saveas(gcf,"Figure\fig_"+a+".fig")
saveas(gcf,"Figure\fig_"+a+".png")
end
