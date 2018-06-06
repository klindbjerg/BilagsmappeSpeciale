close all; clear; clc;
load DataFremskrivning.mat % Indeholder pejledata og årsminimumvandføringer

%% Lineær fremskrivningsmodel 34.492 jan-jun

[QJan34_492,crvJan34_492,gofJan34_492,NSEJan34_492] = linpredQ(MinShort,Jan34_492); % De lineære fremskrivningsmodeller produceres med linpredQ-funktionen
[QFeb34_492,crvFeb34_492,gofFeb34_492,NSEFeb34_492] = linpredQ(MinShort,Feb34_492);
[QMar34_492,crvMar34_492,gofMar34_492,NSEMar34_492] = linpredQ(MinShort,Mar34_492);
[QApr34_492,crvApr34_492,gofApr34_492,NSEApr34_492] = linpredQ(MinShort,Apr34_492);
[QMaj34_492,crvMaj34_492,gofMaj34_492,NSEMaj34_492] = linpredQ(MinShort,Maj34_492);
[QJun34_492,crvJun34_492,gofJun34_492,NSEJun34_492] = linpredQ(MinShort,Jun34_492);
[QJul34_492,crvJul34_492,gofJul34_492,NSEJul34_492] = linpredQ(MinShort,Jul34_492);
[QAug34_492,crvAug34_492,gofAug34_492,NSEAug34_492] = linpredQ(MinShort,Aug34_492);
[QSep34_492,crvSep34_492,gofSep34_492,NSESep34_492] = linpredQ(MinShort(2:15,:),Sep34_492);
[QOkt34_492,crvOkt34_492,gofOkt34_492,NSEOkt34_492] = linpredQ(MinShort(2:15,:),Okt34_492);
[QNov34_492,crvNov34_492,gofNov34_492,NSENov34_492] = linpredQ(MinShort(2:15,:),Nov34_492);
[QDec34_492,crvDec34_492,gofDec34_492,NSEDec34_492] = linpredQ(MinShort(2:15,:),Dec34_492);

%% Lineær fremskrivningsmodel 26.536 jan-jun

[QJan26_536,crvJan26_536,gofJan26_536,NSEJan26_536] = linpredQ(MinLong,Jan26_536);
[QFeb26_536,crvFeb26_536,gofFeb26_536,NSEFeb26_536] = linpredQ(MinLong,Feb26_536);
[QMar26_536,crvMar26_536,gofMar26_536,NSEMar26_536] = linpredQ(MinLong,Mar26_536);
[QApr26_536,crvApr26_536,gofApr26_536,NSEApr26_536] = linpredQ(MinLong,Apr26_536);
[QMaj26_536,crvMaj26_536,gofMaj26_536,NSEMaj26_536] = linpredQ(MinLong,Maj26_536);
[QJun26_536,crvJun26_536,gofJun26_536,NSEJun26_536] = linpredQ(MinLong,Jun26_536);
[QJul26_536,crvJul26_536,gofJul26_536,NSEJul26_536] = linpredQ(MinLong,Jul26_536);
[QAug26_536,crvAug26_536,gofAug26_536,NSEAug26_536] = linpredQ(MinLong,Aug26_536);
[QSep26_536,crvSep26_536,gofSep26_536,NSESep26_536] = linpredQ(MinLong(2:19,:),Sep26_536);
[QOkt26_536,crvOkt26_536,gofOkt26_536,NSEOkt26_536] = linpredQ(MinLong(2:19,:),Okt26_536);
[QNov26_536,crvNov26_536,gofNov26_536,NSENov26_536] = linpredQ(MinLong(2:19,:),Nov26_536);
[QDec26_536,crvDec26_536,gofDec26_536,NSEDec26_536] = linpredQ(MinLong(2:19,:),Dec26_536);

%% Lineær fremskrivningsmodel 26.1943 jan-jun

[QJan26_1943,crvJan26_1943,gofJan26_1943,NSEJan26_1943] = linpredQ(MinShort,Jan26_1943);
[QFeb26_1943,crvFeb26_1943,gofFeb26_1943,NSEFeb26_1943] = linpredQ(MinShort,Feb26_1943);
[QMar26_1943,crvMar26_1943,gofMar26_1943,NSEMar26_1943] = linpredQ(MinShort,Mar26_1943);
[QApr26_1943,crvApr26_1943,gofApr26_1943,NSEApr26_1943] = linpredQ(MinShort,Apr26_1943);
[QMaj26_1943,crvMaj26_1943,gofMaj26_1943,NSEMaj26_1943] = linpredQ(MinShort,Maj26_1943);
[QJun26_1943,crvJun26_1943,gofJun26_1943,NSEJun26_1943] = linpredQ(MinShort,Jun26_1943);
[QJul26_1943,crvJul26_1943,gofJul26_1943,NSEJul26_1943] = linpredQ(MinShort,Jul26_1943);
[QAug26_1943,crvAug26_1943,gofAug26_1943,NSEAug26_1943] = linpredQ(MinShort,Aug26_1943);
[QSep26_1943,crvSep26_1943,gofSep26_1943,NSESep26_1943] = linpredQ(MinShort(2:15,:),Sep26_1943);
[QOkt26_1943,crvOkt26_1943,gofOkt26_1943,NSEOkt26_1943] = linpredQ(MinShort(2:15,:),Okt26_1943);
[QNov26_1943,crvNov26_1943,gofNov26_1943,NSENov26_1943] = linpredQ(MinShort(2:15,:),Nov26_1943);
[QDec26_1943,crvDec26_1943,gofDec26_1943,NSEDec26_1943] = linpredQ(MinShort(2:15,:),Dec26_1943);

% save LinearModels.mat;

%%
% load LinearModels.mat;
%% Figurer af lineære modeller
% % LinModFigure-funktionen laver figurer af de lineære modeller.

% [fig_LinModSep26_1943,gof2Sep26_1943,curveSep26_1943] = LinModFigure( Sep26_1943, MinShort(2:15,:), 'pejling af grundvandstand i september, DGU-nr. 26.1943', 'LinModSep26_1943')
% [fig_LinModOkt26_1943,gof2Okt26_1943,curveOkt26_1943] = LinModFigure( Okt26_1943, MinShort(2:15,:), 'pejling af grundvandstand i oktober, DGU-nr. 26.1943', 'LinModOkt26_1943')
% [fig_LinModNov26_1943,gof2Nov26_1943,curveNov26_1943] = LinModFigure( Nov26_1943, MinShort(2:15,:), 'pejling af grundvandstand i november, DGU-nr. 26.1943', 'LinModNov26_1943')
% [fig_LinModDec26_1943,gof2Dec26_1943,curveDec26_1943] = LinModFigure( Dec26_1943, MinShort(2:15,:), 'pejling af grundvandstand i december, DGU-nr. 26.1943', 'LinModDec26_1943')
% [fig_LinModJan26_1943,gof2Jan26_1943,curveJan26_1943] = LinModFigure( Jan26_1943, MinShort, 'pejling af grundvandstand i januar, DGU-nr. 26.1943', 'LinModJan26_1943')
% [fig_LinModFeb26_1943,gof2Feb26_1943,curveFeb26_1943] = LinModFigure( Feb26_1943, MinShort, 'pejling af grundvandstand i februar, DGU-nr. 26.1943', 'LinModFeb26_1943')
% [fig_LinModMar26_1943,gof2Mar26_1943,curveMar26_1943] = LinModFigure( Mar26_1943, MinShort, 'pejling af grundvandstand i marts, DGU-nr. 26.1943', 'LinModMar26_1943')
% [fig_LinModApr26_1943,gof2Apr26_1943,curveApr26_1943] = LinModFigure( Apr26_1943, MinShort, 'pejling af grundvandstand i april, DGU-nr. 26.1943', 'LinModApr26_1943')
% [fig_LinModMaj26_1943,gof2Maj26_1943,curveMaj26_1943] = LinModFigure( Maj26_1943, MinShort, 'pejling af grundvandstand i maj, DGU-nr. 26.1943', 'LinModMaj26_1943')
% [fig_LinModJun26_1943,gof2Jun26_1943,curveJun26_1943] = LinModFigure( Jun26_1943, MinShort, 'pejling af grundvandstand i juni, DGU-nr. 26.1943', 'LinModJun26_1943')
% [fig_LinModJul26_1943,gof2Jul26_1943,curveJul26_1943] = LinModFigure( Jul26_1943, MinShort, 'pejling af grundvandstand i juli, DGU-nr. 26.1943', 'LinModJul26_1943')
% [fig_LinModAug26_1943,gof2Aug26_1943,curveAug26_1943] = LinModFigure( Aug26_1943, MinShort, 'pejling af grundvandstand i august, DGU-nr. 26.1943', 'LinModAug26_1943')

% [fig_LinModSep26_536,gof2Sep26_536,curveSep26_536] = LinModFigure( Sep26_536, MinLong(2:19,:), 'pejling af grundvandstand i september, DGU-nr. 26.536', 'LinModSep26_536')
% [fig_LinModOkt26_536,gof2Okt26_536,curveOkt26_536] = LinModFigure( Okt26_536, MinLong(2:19,:), 'pejling af grundvandstand i oktober, DGU-nr. 26.536', 'LinModOkt26_536')
% [fig_LinModNov26_536,gof2Nov26_536,curveNov26_536] = LinModFigure( Nov26_536, MinLong(2:19,:), 'pejling af grundvandstand i november, DGU-nr. 26.536', 'LinModNov26_536')
% [fig_LinModDec26_536,gof2Dec26_536,curveDec26_536] = LinModFigure( Dec26_536, MinLong(2:19,:), 'pejling af grundvandstand i december, DGU-nr. 26.536', 'LinModDec26_536')
% [fig_LinModJan26_536,gof2Jan26_536,curveJan26_536] = LinModFigure( Jan26_536, MinLong, 'pejling af grundvandstand i januar, DGU-nr. 26.536', 'LinModJan26_536')
% [fig_LinModFeb26_536,gof2Feb26_536,curveFeb26_536] = LinModFigure( Feb26_536, MinLong, 'pejling af grundvandstand i februar, DGU-nr. 26.536', 'LinModFeb26_536')
% [fig_LinModMar26_536,gof2Mar26_536,curveMar26_536] = LinModFigure( Mar26_536, MinLong, 'pejling af grundvandstand i marts, DGU-nr. 26.536', 'LinModMar26_536')
% [fig_LinModApr26_536,gof2Apr26_536,curveApr26_536] = LinModFigure( Apr26_536, MinLong, 'pejling af grundvandstand i april, DGU-nr. 26.536', 'LinModApr26_536')
% [fig_LinModMaj26_536,gof2Maj26_536,curveMaj26_536] = LinModFigure( Maj26_536, MinLong, 'pejling af grundvandstand i maj, DGU-nr. 26.536', 'LinModMaj26_536')
% [fig_LinModJun26_536,gof2Jun26_536,curveJun26_536] = LinModFigure( Jun26_536, MinLong, 'pejling af grundvandstand i juni, DGU-nr. 26.536', 'LinModJun26_536')
% [fig_LinModJul26_536,gof2Jul26_536,curveJul26_536] = LinModFigure( Jul26_536, MinLong, 'pejling af grundvandstand i juli, DGU-nr. 26.536', 'LinModJul26_536')
% [fig_LinModAug26_536,gof2Aug26_536,curveAug26_536] = LinModFigure( Aug26_536, MinLong, 'pejling af grundvandstand i august, DGU-nr. 26.536', 'LinModAug26_536')
% 
% [fig_LinModSep34_492,gof2Sep34_492,curveSep34_492] = LinModFigure( Sep34_492, MinShort(2:15,:), 'pejling af grundvandstand i september, DGU-nr. 34.492', 'LinModSep34_492')
% [fig_LinModOkt34_492,gof2Okt34_492,curveOkt34_492] = LinModFigure( Okt34_492, MinShort(2:15,:), 'pejling af grundvandstand i oktober, DGU-nr. 34.492', 'LinModOkt34_492')
% [fig_LinModNov34_492,gof2Nov34_492,curveNov34_492] = LinModFigure( Nov34_492, MinShort(2:15,:), 'pejling af grundvandstand i november, DGU-nr. 34.492', 'LinModNov34_492')
% [fig_LinModDec34_492,gof2Dec34_492,curveDec34_492] = LinModFigure( Dec34_492, MinShort(2:15,:), 'pejling af grundvandstand i december, DGU-nr. 34.492', 'LinModDec34_492')
% [fig_LinModJan34_492,gof2Jan34_492,curveJan34_492] = LinModFigure( Jan34_492, MinShort, 'pejling af grundvandstand i januar, DGU-nr. 34.492', 'LinModJan34_492')
% [fig_LinModFeb34_492,gof2Feb34_492,curveFeb34_492] = LinModFigure( Feb34_492, MinShort, 'pejling af grundvandstand i februar, DGU-nr. 34.492', 'LinModFeb34_492')
% [fig_LinModMar34_492,gof2Mar34_492,curveMar34_492] = LinModFigure( Mar34_492, MinShort, 'pejling af grundvandstand i marts, DGU-nr. 34.492', 'LinModMar34_492')
% [fig_LinModApr34_492,gof2Apr34_492,curveApr34_492] = LinModFigure( Apr34_492, MinShort, 'pejling af grundvandstand i april, DGU-nr. 34.492', 'LinModApr34_492')
% [fig_LinModMaj34_492,gof2Maj34_492,curveMaj34_492] = LinModFigure( Maj34_492, MinShort, 'pejling af grundvandstand i maj, DGU-nr. 34.492', 'LinModMaj34_492')
% [fig_LinModJun34_492,gof2Jun34_492,curveJun34_492] = LinModFigure( Jun34_492, MinShort, 'pejling af grundvandstand i juni, DGU-nr. 34.492', 'LinModJun34_492')
% [fig_LinModJul34_492,gof2Jul34_492,curveJul34_492] = LinModFigure( Jul34_492, MinShort, 'pejling af grundvandstand i juli, DGU-nr. 34.492', 'LinModJul34_492')
% [fig_LinModAug34_492,gof2Aug34_492,curveAug34_492] = LinModFigure( Aug34_492, MinShort, 'pejling af grundvandstand i august, DGU-nr. 34.492', 'LinModAug34_492')

close all;
%% R2 for de lineære prædiktionsmodeller
r2lvl26_1943=[1 2 3 4 5 6 7 8 9 10 11 12;
    gofSep26_1943.rsquare gofOkt26_1943.rsquare gofNov26_1943.rsquare gofDec26_1943.rsquare gofJan26_1943.rsquare gofFeb26_1943.rsquare gofMar26_1943.rsquare gofApr26_1943.rsquare gofMaj26_1943.rsquare gofJun26_1943.rsquare gofJul26_1943.rsquare gofAug26_1943.rsquare];

r2lvl26_536=[1 2 3 4 5 6 7 8 9 10 11 12;
    gofSep26_536.rsquare gofOkt26_536.rsquare gofNov26_536.rsquare gofDec26_536.rsquare gofJan26_536.rsquare gofFeb26_536.rsquare gofMar26_536.rsquare gofApr26_536.rsquare gofMaj26_536.rsquare gofJun26_536.rsquare gofJul26_536.rsquare gofAug26_536.rsquare];

r2lvl34_492=[1 2 3 4 5 6 7 8 9 10 11 12;
    gofSep34_492.rsquare gofOkt34_492.rsquare gofNov34_492.rsquare gofDec34_492.rsquare gofJan34_492.rsquare gofFeb34_492.rsquare gofMar34_492.rsquare gofApr34_492.rsquare gofMaj34_492.rsquare gofJun34_492.rsquare gofJul34_492.rsquare gofAug34_492.rsquare];

%% NSE for de lineære prædiktionsmodeller
NSE26_1943=[1 2 3 4 5 6 7 8 9 10 11 12;
    NSESep26_1943 NSEOkt26_1943 NSENov26_1943 NSEDec26_1943 NSEJan26_1943 NSEFeb26_1943 NSEMar26_1943 NSEApr26_1943 NSEMaj26_1943 NSEJun26_1943 NSEJul26_1943 NSEAug26_1943];

NSE26_536=[1 2 3 4 5 6 7 8 9 10 11 12;
    NSESep26_536 NSEOkt26_536 NSENov26_536 NSEDec26_536 NSEJan26_536 NSEFeb26_536 NSEMar26_536 NSEApr26_536 NSEMaj26_536 NSEJun26_536 NSEJul26_536 NSEAug26_536];

NSE34_492=[1 2 3 4 5 6 7 8 9 10 11 12;
    NSESep34_492 NSEOkt34_492 NSENov34_492 NSEDec34_492 NSEJan34_492 NSEFeb34_492 NSEMar34_492 NSEApr34_492 NSEMaj34_492 NSEJun34_492 NSEJul34_492 NSEAug34_492];

%% Figur af korrelation mellem månedsvandstand og årsmin. Bemærk at korrelationen er lav i fx december måned, fordi det er efter årsminvandføringen er forekommet.

set(0,'DefaultAxesFontSize',13)
fig1=figure('Position',[100 100 1300 400]);
ax1=subplot(1,2,1);
hold on;
plot1=scatter(ax1,r2lvl26_1943(1,:),r2lvl26_1943(2,:),'filled','b');
plot2=scatter(ax1,r2lvl26_536(1,:),r2lvl26_536(2,:),'filled','r');
plot3=scatter(ax1,r2lvl34_492(1,:),r2lvl34_492(2,:),'filled','y');
axis([1 12 0 1])
grid on;
xticks([1 2 3 4 5 6 7 8 9 10 11 12])
xticklabels({'Sep', 'Okt', 'Nov', 'Dec', 'Jan','Feb','Mar','Apr','Maj','Jun','Jul', 'Aug'})
labX=xlabel(ax1, 'Måned');
labY=ylabel(ax1, 'R^2');
legend('DGU 26.1943','DGU 26.536','DGU 34.492','Location','south');
%print(fig1,'Figures/CorrelationLinearModels','-dpng')

%% Figur af NSE mellem fremskrevet og modelårsmin. 
%set(0,'DefaultAxesFontSize',13)
%fig2=figure;
ax2=subplot(1,2,2);
hold on;
plot1=scatter(ax2,NSE26_1943(1,:),NSE26_1943(2,:),'filled','b');
plot2=scatter(ax2,NSE26_536(1,:),NSE26_536(2,:),'filled','r');
plot3=scatter(ax2,NSE34_492(1,:),NSE34_492(2,:),'filled','y');
axis([1 12 0 1])
grid on;
xticks([1 2 3 4 5 6 7 8 9 10 11 12])
xticklabels({'Sep', 'Okt', 'Nov', 'Dec', 'Jan','Feb','Mar','Apr','Maj','Jun','Jul', 'Aug'})
labX=xlabel(ax2, 'Måned');
labY=ylabel(ax2, 'NSE');
legend('DGU 26.1943','DGU 26.536','DGU 34.492','Location','south');
print(fig2,'Figures/NSELinearModels','-dpng')
%print(fig1,'Figures/NSE_R2_LinearModels','-dpng')

