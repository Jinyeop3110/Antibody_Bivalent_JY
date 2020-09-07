% Figure drawing v3 - 200712
%% For validation with theory
clc; clear;
cmap=hsv(10);
is_save=0;
%% 
j=0;
lgd=[];

j=j+1;
Tnum=2;
datapath = "Data\0711_linear1D_Tnum"+int2str(Tnum)+"_Nchange.mat";
dataname="Mycode Tnum="+int2str(Tnum);
lgd=[lgd dataname];
load(datapath)
semilogx(kD2_list(2:size(kD2_list,2)),mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum,'-o','Color',cmap(j,:),'MarkerEdgeColor',cmap(j,:))
hold on

j=j+5;
dataname="Theory Tnum="+int2str(Tnum);
lgd=[lgd dataname];
t=pA/kD1;
s=1./kD2_eff_list;
bp=(t+t^2+s*t^2)./(1+2*t+t^2+s*t^2);
semilogx(kD2_list(2:size(kD2_list,2)),bp(2:size(kD2_list,2)),'-','LineWidth',1.2,'Color',cmap(j,:),'MarkerEdgeColor',cmap(j,:))
hold on;

semilogx([0.5*min(kD2_list(2:size(kD2_list,2))),2*max(kD2_list(2:size(kD2_list,2)))],[pA/kD1, pA/kD1],'LineWidth',1.2,'Color','blue','LineStyle','--')
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
figure()
j=0;
lgd=[];

j=j+1;
Tnum=3;
datapath = "Data\0711_linear1D_Tnum"+int2str(Tnum)+"_Nchange.mat";
dataname="Mycode Tnum="+int2str(Tnum);
lgd=[lgd dataname];
load(datapath)
semilogx(kD2_list(2:size(kD2_list,2)),mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum,'-o','LineWidth',1.2,'Color',cmap(j,:),'MarkerEdgeColor',cmap(j,:))
hold on

j=j+5;
dataname="Theory Tnum="+int2str(Tnum);
lgd=[lgd dataname];
t=pA/kD1;
s=1./kD2_eff_list;
bp=(3*t+6*t^2+4*t^2*s+3*t^3+6*t^3*s+3*t^3*s.^2)./(1+3*t+3*t^2+2*t^2*s+t^3+2*t^3*s+t^3*s.^2)/3;
semilogx(kD2_list(2:size(kD2_list,2)),bp(2:size(kD2_list,2)),'-','Color',cmap(j,:),'LineWidth',1.2,'MarkerEdgeColor',cmap(j,:))
hold on;

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