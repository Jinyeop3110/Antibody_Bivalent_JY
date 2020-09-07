% Figure drawing v0.0 - 200706
%%
clc; clear;
cmap=hsv(10);
issave=1;
%% 
figure()
k=1/10
data1name="cubicSphere2D"
%datapath="Data\0706_cubicSphere2D_Tnum98_compactKd2.mat" 
datapath="Data\0719_squareSphere2D_Tnum98_AfterCorrection.mat"
load(datapath)
semilogx(Kd2_list(2:size(Kd2_list,2))/k,mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum,'-o','Color',cmap(1,:),'MarkerEdgeColor',cmap(1,:))
hold on

d=[]
for i=2:size(Kd2_list,2)
    d=[d temp(Kd2_list(i)/k,pA)];
end

semilogx(Kd2_list(2:size(Kd2_list,2))/k,d,'-o','Color',cmap(1,:),'MarkerEdgeColor',cmap(2,:))


%semilogx(Kd2_list(2:size(Kd2_list,2)), )

 data2name="self-cohesion"
% datapath="Data\0706_triangularSphere2D_Tnum98_compactKd2.mat" % datapath="Data\0705_triangularSphere2D_Tnum98.mat"
% load(datapath)
% semilogx(Kd2_list(2:size(Kd2_list,2)),mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum,'-o','Color',cmap(2,:),'MarkerEdgeColor',cmap(2,:))
% hold on

semilogx([0.5*min(Kd2_list(2:size(Kd2_list,2))),2*max(Kd2_list(2:size(Kd2_list,2)))]/k,[pA/Kd1, pA/Kd1],'Color','blue','LineStyle','--')
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
loglog(Kd2_list(2:size(Kd2_list,2)),pA*(1-mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum)./(mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum),'-o','Color',cmap(1,:),'MarkerEdgeColor',cmap(1,:))
hold on

data2name="triangularSphere2D"
datapath="Data\0706_triangularSphere2D_Tnum98_compactKd2.mat" % datapath="Data\0705_triangularSphere2D_Tnum98.mat"
load(datapath)
loglog(Kd2_list(2:size(Kd2_list,2)),pA*(1-mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum)./(mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum),'-o','Color',cmap(2,:),'MarkerEdgeColor',cmap(2,:))
hold on

semilogx([0.5*min(Kd2_list(2:size(Kd2_list,2))),2*max(Kd2_list(2:size(Kd2_list,2)))],[Kd1, Kd1],'Color','blue','LineStyle','--')
title("Kd_2 vs Kd_eff")
xlabel("log(Kd2)")
ylabel("log(Kd_eff)")

legend([data1name data2name "Control"])
a=[sprintf('%s', datestr(now,'mm-dd-yyyy HH-MM_')) int2str(randi(500))];
if issave
saveas(gcf,"Figure\fig_"+a+".fig")
saveas(gcf,"Figure\fig_"+a+".png")
end
%%
function d=temp(Kd2, pA)
    d=1-roots([1 -2-Kd2/pA/8 1]);
    d=d(2);
end
