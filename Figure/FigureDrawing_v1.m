% Figure drawing v0.0 - 200706
%%
clc; clear;
cmap=hsv(10);
issave=1;
%% 
figure()

data1name="cubicSphere2D"
datapath="Data\0706_cubicSphere2D_Tnum98_compactKd2.mat" %datapath="Data\0705_cubicSphere2D_Tnum98.mat"
load(datapath)
semilogx(kD2_list(2:size(kD2_list,2)),mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum,'-o','Color',cmap(1,:),'MarkerEdgeColor',cmap(1,:))
hold on

data2name="triangularSphere2D"
datapath="Data\0706_triangularSphere2D_Tnum98_compactKd2.mat" % datapath="Data\0705_triangularSphere2D_Tnum98.mat"
load(datapath)
semilogx(kD2_list(2:size(kD2_list,2)),mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum,'-o','Color',cmap(2,:),'MarkerEdgeColor',cmap(2,:))
hold on

semilogx([0.5*min(kD2_list(2:size(kD2_list,2))),2*max(kD2_list(2:size(kD2_list,2)))],[pA/kD1, pA/kD1],'Color','blue','LineStyle','--')
title("Kd_2 vs bounding %")
xlabel("log(Kd2)")
ylabel("bounding %")

legend([data1name data2name "Control"])
a=[sprintf('%s', datestr(now,'mm-dd-yyyy HH-MM_')) int2str(randi(500))];
if issave
saveas(gcf,"Figure\fig_"+a+".fig")
saveas(gcf,"Figure\fig_"+a+".png")
end
%%
%%
figure()
data1name="cubicSphere2D"
datapath="Data\0706_cubicSphere2D_Tnum98_compactKd2.mat" %datapath="Data\0705_cubicSphere2D_Tnum98.mat"
load(datapath)
loglog(kD2_list(2:size(kD2_list,2))/k,pA*(1-mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum)./(mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum),'-o','Color',cmap(1,:),'MarkerEdgeColor',cmap(1,:))
hold on

% data2name="triangularSphere2D"
% datapath="Data\0706_triangularSphere2D_Tnum98_compactKd2.mat" % datapath="Data\0705_triangularSphere2D_Tnum98.mat"
% load(datapath)
% loglog(kD2_list(2:size(kD2_list,2)),pA*(1-mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum)./(mean(ProbS(2:size(kD2_list,2),:),2)/sys_model.Tnum),'-o','Color',cmap(2,:),'MarkerEdgeColor',cmap(2,:))
% hold on

semilogx([0.5*min(kD2_list(2:size(kD2_list,2)))/k,2*max(kD2_list(2:size(kD2_list,2)))],[kD1, kD1],'Color','blue','LineStyle','--')
title("Kd_2 vs Kd_eff")
xlabel("log(Kd2)")
ylabel("log(Kd_eff)")

legend([data1name data2name "Control"])
a=[sprintf('%s', datestr(now,'mm-dd-yyyy HH-MM_')) int2str(randi(500))];
if issave
saveas(gcf,"Figure\fig_"+a+".fig")
saveas(gcf,"Figure\fig_"+a+".png")
end
