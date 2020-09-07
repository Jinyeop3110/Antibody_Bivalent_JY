cmap=hsv(10);
% To change
datapath="Data\0720_squareSphere2D_Tnum98_Cr100_AfterCorrection.mat"
load(datapath);

% To change
IsSave=0;


%% Binding % figure with Cohesion

% bounding %

figure();
yyaxis left

data1name="randomUniformSphere2D" % Change dataname

% if you wanna choose different values,
plot(Kd2_list(2:size(Kd2_list,2)),mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum,'-o','Color',cmap(1,:),'MarkerEdgeColor',cmap(1,:));ylabel("log(Kd_eff)");

axis([min(Kd2_list(2:size(Kd2_list,2))) max(Kd2_list(2:size(Kd2_list,2))) 0 1])
ylabel("Antigen Binding %")

set(gca,'ycolor',cmap(1,:)) 





data2name="SelfCohesion";
data2=[];
for i=2:size(Kd2_list,2)
    data2=[data2 Cohesion(Kd2_list(i),pA,WperT)];
end
yyaxis right
plot(Kd2_list(2:size(Kd2_list,2)),data2,'-o','Color',cmap(2,:),'MarkerEdgeColor',cmap(2,:))

hold on

ylabel("Self Cohesion %")
set(gca,'ycolor',cmap(2,:)) 

yyaxis left
data3name="Control"
plot([0.5*min(Kd2_list(2:size(Kd2_list,2))),2*max(Kd2_list(2:size(Kd2_list,2)))],[pA/Kd1, pA/Kd1],'Color','blue','LineStyle','--')

hold on

title("Kd_2 vs Antigen Binding %")
xlabel("log(Kd2)")

legend([data1name data3name data2name])

a=[sprintf('%s', datestr(now,'mm-dd-yyyy HH-MM_')) int2str(randi(500))];
if IsSave
    saveas(gcf,"Figure\fig_withCohesion_"+a+".fig")
    saveas(gcf,"Figure\fig_withCohesion_"+a+".png")
end



%% Kd2 Figure with Cohesion
figure();

yyaxis left

data1name="randomUniformSphere2D" % Change dataname

semilogy(Kd2_list(2:size(Kd2_list,2)),pA*(1-mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum)./(mean(ProbS(2:size(Kd2_list,2),:),2)/sys_model.Tnum),'-o','Color',cmap(1,:),'MarkerEdgeColor',cmap(1,:));hold on;
ylabel("log(Kd_eff)");
set(gca,'ycolor',cmap(1,:)) 

data2name="SelfCohesion";
data2=[];

for i=2:size(Kd2_list,2)
    data2=[data2 Cohesion(Kd2_list(i),pA,WperT)];
end

yyaxis right
plot(Kd2_list(2:size(Kd2_list,2)),data2,'-o','Color',cmap(2,:),'MarkerEdgeColor',cmap(2,:))
ylabel("SelfCohesion %")

set(gca,'ycolor',cmap(2,:)) 









yyaxis left

data3name="Control"
plot([0.5*min(Kd2_list(2:size(Kd2_list,2))),2*max(Kd2_list(2:size(Kd2_list,2)))],[Kd1, Kd1],'Color','blue','LineStyle','--')
title("Kd_2 vs Kd_eff")
xlabel("log(Kd2)")

legend([data1name data3name data2name])
axis([min(Kd2_list(2:size(Kd2_list,2))) max(Kd2_list(2:size(Kd2_list,2))) 10^(-2)*Kd1 2*Kd1])

a=[sprintf('%s', datestr(now,'mm-dd-yyyy HH-MM_')) int2str(randi(500))];

if IsSave
    saveas(gcf,"Figure\fig_withCohesion_"+a+".fig")
    saveas(gcf,"Figure\fig_withCohesion_"+a+".png")
end
