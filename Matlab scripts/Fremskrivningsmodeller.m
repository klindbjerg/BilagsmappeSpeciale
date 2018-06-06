clear; close all; clc; 

% Lav modeller med myNNtrainer [net,tr,gof]=myNNtrainer(X1,X2,Y)
% load DataFremskrivning.mat; % Indeholder alle årsmin og pejlinger i de tre udvalgte boringer.

%% Load al data
load data_til_fremskrivningsmodeller.mat
tic

%% NN februar
% predictors_1=[Feb34_492 Feb26_1943 Feb26_536(1:15,:)];
% 
% [net_1,tr_1,gof_1,FremskrevetY_1]=myNNtrainer(predictors_1,MinShort);
% 
% save('FremskrevneYpejlingerFebruar1','net_1','FremskrevetY_1'); 
% 
%% NN januar, februar
% 
% predictors_2=[Feb34_492 Feb26_1943 Feb26_536(1:15,:) Jan34_492 Jan26_1943 Jan26_536(1:15,:)];
% 
% [net_vol2,tr_vol2,gof_vol2,FremskrevetY_2]=myNNtrainer(predictors_2,MinShort);
% 
%% NN december, januar, februar
predictors_3=[Feb34_492(2:15,:) Feb26_1943(2:15,:) Feb26_536(2:15,:) Jan34_492(2:15,:) Jan26_1943(2:15,:) Jan26_1943(2:15,:) Dec34_492 Dec26_1943 Dec26_536(1:14,:)];

[net_vol3,tr_vol3,gof_vol3,FremskrevetY_3]=myNNtrainer(predictors_3,MinShort(2:15,:));

save('FremskrivningsmodelDecFeb.mat','net_vol3','FremskrevetY_3')

%% NN november, december, januar, februar
% predictors_4=[Feb34_492(2:15,:) Feb26_1943(2:15,:) Feb26_536(2:15,:) Jan34_492(2:15,:) Jan26_1943(2:15,:) Jan26_1943(2:15,:) Dec34_492 Dec26_1943 Dec26_536(1:14,:) Nov34_492 Nov26_1943 Nov26_536(1:14,:)];
% 
% [net_vol4,~,~,FremskrevetY_4]=myNNtrainer(predictors_4,MinShort(2:15,:));
% 
% save('FremskrivningsmodelNovFeb.mat','net_vol4','FremskrevetY_4')
%
%% NN oktober, november, december, januar, februar
% predictors_5=[Feb34_492(2:15,:) Feb26_1943(2:15,:) Feb26_536(2:15,:) Jan34_492(2:15,:) Jan26_1943(2:15,:) Jan26_1943(2:15,:) Dec34_492 Dec26_1943 Dec26_536(1:14,:) Nov34_492 Nov26_1943 Nov26_536(1:14,:) Okt34_492 Okt26_1943 Okt26_536(1:14,:)];
% 
% [net_vol5,tr_vol5,gof_vol5,FremskrevetY_5]=myNNtrainer(predictors_5,MinShort(2:15,:));
% 
%% NN september, oktober, november, december, januar, februar
% predictors_6=[Feb34_492(2:15,:) Feb26_1943(2:15,:) Feb26_536(2:15,:) Jan34_492(2:15,:) Jan26_1943(2:15,:) Jan26_1943(2:15,:) Dec34_492 Dec26_1943 Dec26_536(1:14,:) Nov34_492 Nov26_1943 Nov26_536(1:14,:) Okt34_492 Okt26_1943 Okt26_536(1:14,:) Sep34_492(1:14,:) Sep26_1943(1:14,:) Sep26_536(1:14,:)];
% 
% [net_vol6,tr_vol6,gof_vol6,FremskrevetY_6]=myNNtrainer(predictors_6,MinShort(2:15,:));
% 
% [fig_QQ_6,gof_6,curve_6] = QQfigurePrctile( MinShort(2:15,:), FremskrevetY_6, 'Test_6', 'Test_6')

toc

%% Gem data
%save('FremskrevneYpejlinger','FremskrevetY_1', 'FremskrevetY_2','FremskrevetY_3','FremskrevetY_4','FremskrevetY_5','FremskrevetY_6');

