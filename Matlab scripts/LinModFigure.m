function [fig_LinMod,gof,curve] = LinModFigure( LvlMeas, Qmeas, overskrift, filnavn)
set(0,'DefaultAxesFontSize',13)
fig_LinMod=figure('position',[100 100 700 500]);
ax=axes;
[curve,gof] = fit(LvlMeas,Qmeas,'poly1'); %,'Lower',[-inf,0],'Upper',[inf,0]);
hold on;
plot1=scatter(LvlMeas,Qmeas,'filled','b');
fitplot=plot(curve,'--r');
scatter_fun_for_legend=scatter(LvlMeas(1,1),Qmeas(1,1),'MarkerEdgeColor','none');
grid on;

%% Her laves NSE
Q_pred=curve.p1*LvlMeas+curve.p2;

Top=(Qmeas-Q_pred).^2;
Bund=(Qmeas-mean(Qmeas)).^2;
NSE=1-(sum(Top)/sum(Bund));

%% Her laved konfidensbånd
Error_model=Q_pred-Qmeas;
std_dev=std(Error_model);
    b01 = curve.p2-2*std_dev;
    b02 = curve.p2+2*std_dev;
    b1 = curve.p1;
    f1 = @(x) b1*x+b01;
    f2 = @(x) b1*x+b02;
hold on;

hold on;
plot2=fplot(f1,':k');
plot3=fplot(f2,':k');


% HERTIL
%% Hertil
axis([min(LvlMeas)-0.1 max(LvlMeas)+0.1 min(Qmeas)-10 max(Qmeas)+10])
title_ax = title(ax , strcat({'Lineær fremskrivningsmodel baseret på', overskrift})); 
labX=xlabel(ax, 'Grundvandskote [m]');
labY=ylabel(ax, 'Årsminimumvandføring [l/s]');

legend('Data','Lineær regressionsmodel',strcat('R^2=',num2str(gof.rsquare,2),', NSE=',num2str(NSE,2)),strcat('2\sigma=',num2str(2*std_dev,3)),'Location','northwest');
%legend('Data',strcat('årsmin=',num2str(curve.p1),'*grundvandskote+',num2str(curve.p2)), strcat('R^2=',num2str(gof.rsquare,2)),'Location','southeast');
print(fig_LinMod,strcat('Figures/LinMods/',filnavn),'-dpng')

%strcat('y=',num2str(curve.p1),'*x+',num2str(curve.p2))
end

