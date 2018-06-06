clear; close all; clc;
Data=xlsread('TidsserierAlle',1,'A1:F225');
Data(:,1)=Data(:,1)+datenum('30-Dec-1899'); %excel datoer til matlab datoer
Data(:,3)=Data(:,3)+datenum('30-Dec-1899'); 
Data(:,5)=Data(:,5)+datenum('30-Dec-1899'); 

original_index1={'26.536', '26.1943', '34.492'}; %
udvalgte_pejlings_numre1=[1 2 3];

[pejlinger_til_videre_analyse, udfyldnings_figur, seasonality_figure]=Script_til_dannelse_af_maaned_pejle_serier_til_ann(Data, original_index1, udvalgte_pejlings_numre1)



function [pejlinger_til_videre_analyse, udfyldnings_figur, seasonality_figure] = Script_til_dannelse_af_maaned_pejle_serier_til_ann(time_level_merge_sort, original_index, udvalgte_pejlings_numre)
%% OBS! Dette script er oprindelige udf�rdiget af Jellesen [2015] 
%i forbindelse med afgangsprojektet "Modeludvikling til s�sonm�ssig prediktion 
% af sommerminimumsafstr�mning". Scriptet er siden tilpasset data til dette projekt. 
% ------------ %
%%% Dette script g�r ind og danner en regul�r grundvandsserier for pejleserie
% Preallokation. Vi vil have en matrix hvor hver pejleserie har 5
% indgange. 1) �rstal, 2) m�nedstal, 3) reelt tidsforekommelse, 4) 
% median m�nedsforekommelse (15. dag i hver m�ned) og 5) selve 
% pejlingen. 4) g�r det lidt nemmere n�r der senere skal plottes p�
% m�nedsvis basis for eksempelvis nedb�ren. 
start_num_date_all = time_level_merge_sort(1,1:2:end);
min_start_datevec = datevec(min(start_num_date_all));
start_aar = min_start_datevec(1,1);
slut_num_date_all = time_level_merge_sort(end,1:2:end);
max_slut_datevec = datevec(max(slut_num_date_all));
slut_aar = max_slut_datevec(1,1);
n_maaned = (slut_aar-start_aar+1)*12;
pejlinger_til_videre_analyse = NaN(n_maaned, 5*size(udvalgte_pejlings_numre,2));

% F�rst definerer vi de indgangsmatricer vi anvender til dataudtr�k
time_level_merge_sort_udtraeks_indeks(1,1:size(time_level_merge_sort,2)/2) = 1:2:size(time_level_merge_sort,2);
time_level_merge_sort_udtraeks_indeks(2,1:size(time_level_merge_sort,2)/2) = 2:2:size(time_level_merge_sort,2);

% Dern�st definere de indgangsmatricer vi anvender til at udskrive
% resultatet til
indskrivning_til_pejlinger_til_videre_analyse(1,1:size(udvalgte_pejlings_numre,2)) = 1:5:size(pejlinger_til_videre_analyse,2);
indskrivning_til_pejlinger_til_videre_analyse(2,1:size(udvalgte_pejlings_numre,2)) = 2:5:size(pejlinger_til_videre_analyse,2);
indskrivning_til_pejlinger_til_videre_analyse(3,1:size(udvalgte_pejlings_numre,2)) = 3:5:size(pejlinger_til_videre_analyse,2);
indskrivning_til_pejlinger_til_videre_analyse(4,1:size(udvalgte_pejlings_numre,2)) = 4:5:size(pejlinger_til_videre_analyse,2);
indskrivning_til_pejlinger_til_videre_analyse(5,1:size(udvalgte_pejlings_numre,2)) = 5:5:size(pejlinger_til_videre_analyse,2);

% Dannelse af de regul�re serier
for j = 1:size(udvalgte_pejlings_numre,2)
    jj = udvalgte_pejlings_numre(j);
    
    datevector_full = [];
    datevector_present = [];

    datevector_present = datevec(time_level_merge_sort(:,time_level_merge_sort_udtraeks_indeks(1,jj)));
    start_aar = min(datevector_present(:,1));
    slut_aar = max(datevector_present(:,1));
    datevector_present(:,4) = datenum(datevector_present);

    % Reducerer datoen s�ledes at det kan testes om der er flere end en
    % pejling per m�ned ved at alle eventuelle unikke m�linger i en
    % m�neden har den samme numeriske tidsv�rdi.
    datevector_present(:,5) = datenum(datevector_present(:,1), datevector_present(:,2),0)+15;
    datevector_present(:,6) = time_level_merge_sort(:,time_level_merge_sort_udtraeks_indeks(2,jj));
    datevector_present(any(isnan(datevector_present),2),:) = [];

    % Vi finder de v�rdier der ikke er unikke
    unique_present = unique(datevector_present(:,5)); % Finder m�nederne, for hvor der er unikke tidsv�rdier
    n_repeat = [hist(datevector_present(:,5),unique_present)>1]'; % hist(datevector_present(:,5),unique_present) viser visuelt hvad der foreg�r
    repeated_values_index = ismember(datevector_present(:,5), unique_present(n_repeat));
    non_repeat_values = datevector_present(repeated_values_index==0,1:end);
    repeated_values = datevector_present(repeated_values_index,1:end);

    % Danner en vektor til indskrivning af de gennemsnitlige pejlinger for de
    % ikke unikke m�linger
    [~, row_indice]=unique(repeated_values(:,5));
    row_indice = sort(row_indice);
    non_unique_present = repeated_values(row_indice,1:end-1);

    % Udregner og indskriver de gennemsnitlige pejlinger af de ikke unikke
    % pejlinger.
    for k = 1:1:size(non_unique_present,1);
        ikke_unikke_pejlinger = [];
        ikke_unikke_pejlinger = repeated_values(non_unique_present(k,5) == repeated_values(:,5),end-2); % Querier tiden for de samme m�linger
        non_unique_present(k,4) = mean(ikke_unikke_pejlinger); % Tager gennemsnitet og inds�tter den i stedet for den oprindelige tid for m�lingen
        ikke_unikke_pejlinger = [];
        ikke_unikke_pejlinger = repeated_values(non_unique_present(k,5) == repeated_values(:,5),end); % Finder pejlinger for de samme m�linger
        non_unique_present(k,6) = mean(ikke_unikke_pejlinger);
    end

    % Vi danner nu den fulde matrix, der g�r fra start_aar til slut_aar og har
    % 12 m�neder for hvert �r som vi kan query ud fra for at finde de
    % m�neder hvor der mangler m�linger
    start_aar = min(datevector_present(:,1));
    slut_aar = max(datevector_present(:,1));
    n_maaned=[1:12]';
    n_aar = (slut_aar-start_aar)+1;
    B=n_maaned(:,ones(n_aar,1));
    datevector_full(:,2)=B(:);
    n_aar = [start_aar:slut_aar]';
    B=n_aar(:,ones(size(n_maaned,1),1));
    datevector_full(:,1) = sortrows(B(:));
    datevector_full(:,4:6) = 0;
    datevector_full(:,3) = datenum(datevector_full)+15;
    datevector_full(:,4:end) = [];
    datevector_full(:,4) = 0;

    % Nu skal vi have sat de m�lte observation, der er unikke observationer 
    % ind i den fulde datavektor.
    [logic_indice, row_indice] = ismember(non_repeat_values(:,5), datevector_full(:,3));
    datevector_full(row_indice,4:5) = non_repeat_values(logic_indice,[4,6]);

    % Nu skal vi have sat gennemsnitspejlingerne fra de ikke unikke
    % observationer ind i den fulde datavektor.
    [logic_indice, row_indice] = ismember(non_unique_present(:,5), datevector_full(:,3));
    datevector_full(row_indice,4:5) = non_unique_present(logic_indice,[4,6]);

    % datevector_full(any((datevector_full(:,4)==0),2),:) = [] kan anvendes til
    % at teste st�rrelsen af matrixen. Denne skulle gerne v�re lig n_repeat.
    % plot(datevector_full(:,3:4:end), datevector_full(:,4:4:end),'-.') 
    % kan anvendes til at tjekke udtr�kkene visuelt.

    % Nu skal vi have interpoleret pejleserierne for de manglende
    % m�neder. Algoritmen der interpolerer vil gengive NaN v�rdier i
    % det tilf�lde der ikke forefindes nogle m�linger f�r/efter et
    % givent datapunkt. Derfor beh�ves vi ikke at fjerne eventuelle
    % r�kker i tilf�lde af at serien starter/slutter uden v�rdier.

    % F�rst finder vi datoen for den f�rste pejleindgang (findes i
    % datevector_present)

    % %interpoler manglende m�nedsv�rdier
    months_missing_index=find(any(datevector_full==0,2));
    interp_query_serie_logic_search =not(datevector_full(:,end)==0);
    interp_query_serie = [datevector_full(interp_query_serie_logic_search,3), datevector_full(interp_query_serie_logic_search,5)];
    months_missing = datevector_full(months_missing_index,3);


    datevector_full(months_missing_index,5) = interp1(interp_query_serie(:,1),interp_query_serie(:,2), months_missing);
    %datevector_full(any(isnan(datevector_full),2),:) = []

    datevector_full(any((datevector_full(:,4) == 0),2),4) = NaN;

    date_round = datevec(datevector_full(:,4));
    date_round(:,4:end) = 0;
    datevector_full(:,4) = datenum(date_round);

    %plot(datevector_full(:,3), datevector_full(:,5),'-.');

    % Vi finder nu de indgange i den interpolerede tidsserie, der matcher
    % de tidspunkter vi leder efter v�rdier for.
    pejlinger_til_videre_analyse([1:size(datevector_full,1)]',indskrivning_til_pejlinger_til_videre_analyse(1,j):indskrivning_til_pejlinger_til_videre_analyse(5,j)) = datevector_full(:,[1 2 3 4 5]);
end
% En af serierne g�r l�ngere end de andre, hvorfor der i dette tilf�lde
% vil blive appended zeros ind for de andre serier. N�r vi plotter vil
% det derfor se forkert ud. Derfor finder vi alle r�kke indgangene hvor
% der er zeros og sletter disse.
pejlinger_til_videre_analyse(any(pejlinger_til_videre_analyse == 0,2),:) = [];

% Tidspunkterne vil ikke matche 100% siden vi i scripted fjerne alt under
% tid i m�neder fra serien. 

set(0,'DefaultAxesFontSize',12)
%% Figurer
udfyldnings_figur = figure('Position',[0 0 1100 450]); 
ax1=subplot(2,6,[1,2,3,4,5]);
hold on
plot(pejlinger_til_videre_analyse(:,3:5:end), pejlinger_til_videre_analyse(:,5:5:end),'.-k');
%plot(time_level_merge_sort(:,1:2:end), time_level_merge_sort(:,2:2:end),'o');
plot(time_level_merge_sort(:,time_level_merge_sort_udtraeks_indeks(1,udvalgte_pejlings_numre)), ...
    time_level_merge_sort(:,time_level_merge_sort_udtraeks_indeks(2,udvalgte_pejlings_numre)), ...
    'o')
ax=gca;
x_min=min(min(pejlinger_til_videre_analyse(:,3:5:end))); %Den her slags index betyder start ved kolonne 3, hver 5. indtil end.
x_max=max(max(pejlinger_til_videre_analyse(:,3:5:end)));
n_aar = datevec(max(max(pejlinger_til_videre_analyse(:,3:5:end)))-min(min(pejlinger_til_videre_analyse(:,3:5:end))));
y_min=min(min(pejlinger_til_videre_analyse(:,5:5:end)));
y_max=max(max(pejlinger_til_videre_analyse(:,5:5:end)));        
%axis(ax,[x_min x_max y_min y_max]);
axis(ax, [x_min x_max 20 24]);
set(ax, 'XTick', x_min:(x_max-x_min)/n_aar(1,1)+1:x_max)
datetick('x','YY');
%xlabel('�r');
%ylabel('Grundvandskote [m]');


ax2=subplot(2,6,[7,8,9,10,11]);
hold on
plot(pejlinger_til_videre_analyse(:,3:5:end), pejlinger_til_videre_analyse(:,5:5:end),'.-k');
%plot(time_level_merge_sort(:,1:2:end), time_level_merge_sort(:,2:2:end),'o');
plot(time_level_merge_sort(:,time_level_merge_sort_udtraeks_indeks(1,udvalgte_pejlings_numre)), ...
    time_level_merge_sort(:,time_level_merge_sort_udtraeks_indeks(2,udvalgte_pejlings_numre)), ...
    'o')
ax=gca;
x_min=min(min(pejlinger_til_videre_analyse(:,3:5:end))); %Den her slags index betyder start ved kolonne 3, hver 5. indtil end.
x_max=max(max(pejlinger_til_videre_analyse(:,3:5:end)));
n_aar = datevec(max(max(pejlinger_til_videre_analyse(:,3:5:end)))-min(min(pejlinger_til_videre_analyse(:,3:5:end))));
y_min=min(min(pejlinger_til_videre_analyse(:,5:5:end)));
y_max=max(max(pejlinger_til_videre_analyse(:,5:5:end)));        
%axis(ax,[x_min x_max y_min y_max]);
axis(ax,[x_min x_max 0 3]);
set(ax, 'XTick', x_min:(x_max-x_min)/n_aar(1,1)+1:x_max)
datetick('x','YY');
xlabel('�r');
%ylabel('Grundvandskote [m]');

%%% Legend
hold on
ax_leg2 = subplot(2,6,[6,12])
plot(ax_leg2, 1:10, nan(1,10), 'o', 1:10, nan(1,10), 'o', 1:10, nan(1,10), 'o','LineWidth',2);
axis off
legend('DGU 26.536', 'DGU 26.1943', 'DGU 34.492','location','west');

[ax3,h1]=suplabel('Grundvandskote [m]','y');
%[ax4,h2]=suplabel('�r','x');

hold off



%% ----------------

seasonality_figure = figure('Position',[0 0 1200 300]); hold on
for i = 1:size(udvalgte_pejlings_numre,2);
name_index = udvalgte_pejlings_numre(i);
subplot(1,3,i);
boxplot(pejlinger_til_videre_analyse(:,indskrivning_til_pejlinger_til_videre_analyse(5,i)),pejlinger_til_videre_analyse(:,indskrivning_til_pejlinger_til_videre_analyse(2,i)));
header=strcat('DGU', {' '}, original_index(1,name_index));
title(header)
ylabel('Grundvandskote [m]');
xlabel('M�ned');
end
hold off

%% ::::::- Print figures ::::::- %% 
 print(udfyldnings_figur,'Pejleserie','-dpng')
 print(seasonality_figure,'SaesonvariationPejleserier','-dpng')

end