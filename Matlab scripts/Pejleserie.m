clear; close all; clc;
Data=xlsread('TidsserierAlle',1,'A1:F225');
Data(:,1)=Data(:,1)+datenum('30-Dec-1899'); %excel datoer til matlab datoer
Data(:,3)=Data(:,3)+datenum('30-Dec-1899'); 
Data(:,5)=Data(:,5)+datenum('30-Dec-1899'); 

original_index1={'26.536', '26.1943', '34.492'}; %
udvalgte_pejlings_numre1=[1 2 3];

[pejlinger_til_videre_analyse, udfyldnings_figur, seasonality_figure]=Script_til_dannelse_af_maaned_pejle_serier_til_ann(Data, original_index1, udvalgte_pejlings_numre1)



function [pejlinger_til_videre_analyse, udfyldnings_figur, seasonality_figure] = Script_til_dannelse_af_maaned_pejle_serier_til_ann(time_level_merge_sort, original_index, udvalgte_pejlings_numre)
%% OBS! Dette script er oprindelige udfærdiget af Jellesen [2015] 
%i forbindelse med afgangsprojektet "Modeludvikling til sæsonmæssig prediktion 
% af sommerminimumsafstrømning". Scriptet er siden tilpasset data til dette projekt. 
% ------------ %
%%% Dette script går ind og danner en regulær grundvandsserier for pejleserie
% Preallokation. Vi vil have en matrix hvor hver pejleserie har 5
% indgange. 1) årstal, 2) månedstal, 3) reelt tidsforekommelse, 4) 
% median månedsforekommelse (15. dag i hver måned) og 5) selve 
% pejlingen. 4) gør det lidt nemmere når der senere skal plottes på
% månedsvis basis for eksempelvis nedbøren. 
start_num_date_all = time_level_merge_sort(1,1:2:end);
min_start_datevec = datevec(min(start_num_date_all));
start_aar = min_start_datevec(1,1);
slut_num_date_all = time_level_merge_sort(end,1:2:end);
max_slut_datevec = datevec(max(slut_num_date_all));
slut_aar = max_slut_datevec(1,1);
n_maaned = (slut_aar-start_aar+1)*12;
pejlinger_til_videre_analyse = NaN(n_maaned, 5*size(udvalgte_pejlings_numre,2));

% Først definerer vi de indgangsmatricer vi anvender til dataudtræk
time_level_merge_sort_udtraeks_indeks(1,1:size(time_level_merge_sort,2)/2) = 1:2:size(time_level_merge_sort,2);
time_level_merge_sort_udtraeks_indeks(2,1:size(time_level_merge_sort,2)/2) = 2:2:size(time_level_merge_sort,2);

% Dernæst definere de indgangsmatricer vi anvender til at udskrive
% resultatet til
indskrivning_til_pejlinger_til_videre_analyse(1,1:size(udvalgte_pejlings_numre,2)) = 1:5:size(pejlinger_til_videre_analyse,2);
indskrivning_til_pejlinger_til_videre_analyse(2,1:size(udvalgte_pejlings_numre,2)) = 2:5:size(pejlinger_til_videre_analyse,2);
indskrivning_til_pejlinger_til_videre_analyse(3,1:size(udvalgte_pejlings_numre,2)) = 3:5:size(pejlinger_til_videre_analyse,2);
indskrivning_til_pejlinger_til_videre_analyse(4,1:size(udvalgte_pejlings_numre,2)) = 4:5:size(pejlinger_til_videre_analyse,2);
indskrivning_til_pejlinger_til_videre_analyse(5,1:size(udvalgte_pejlings_numre,2)) = 5:5:size(pejlinger_til_videre_analyse,2);

% Dannelse af de regulære serier
for j = 1:size(udvalgte_pejlings_numre,2)
    jj = udvalgte_pejlings_numre(j);
    
    datevector_full = [];
    datevector_present = [];

    datevector_present = datevec(time_level_merge_sort(:,time_level_merge_sort_udtraeks_indeks(1,jj)));
    start_aar = min(datevector_present(:,1));
    slut_aar = max(datevector_present(:,1));
    datevector_present(:,4) = datenum(datevector_present);

    % Reducerer datoen således at det kan testes om der er flere end en
    % pejling per måned ved at alle eventuelle unikke målinger i en
    % måneden har den samme numeriske tidsværdi.
    datevector_present(:,5) = datenum(datevector_present(:,1), datevector_present(:,2),0)+15;
    datevector_present(:,6) = time_level_merge_sort(:,time_level_merge_sort_udtraeks_indeks(2,jj));
    datevector_present(any(isnan(datevector_present),2),:) = [];

    % Vi finder de værdier der ikke er unikke
    unique_present = unique(datevector_present(:,5)); % Finder månederne, for hvor der er unikke tidsværdier
    n_repeat = [hist(datevector_present(:,5),unique_present)>1]'; % hist(datevector_present(:,5),unique_present) viser visuelt hvad der foregår
    repeated_values_index = ismember(datevector_present(:,5), unique_present(n_repeat));
    non_repeat_values = datevector_present(repeated_values_index==0,1:end);
    repeated_values = datevector_present(repeated_values_index,1:end);

    % Danner en vektor til indskrivning af de gennemsnitlige pejlinger for de
    % ikke unikke målinger
    [~, row_indice]=unique(repeated_values(:,5));
    row_indice = sort(row_indice);
    non_unique_present = repeated_values(row_indice,1:end-1);

    % Udregner og indskriver de gennemsnitlige pejlinger af de ikke unikke
    % pejlinger.
    for k = 1:1:size(non_unique_present,1);
        ikke_unikke_pejlinger = [];
        ikke_unikke_pejlinger = repeated_values(non_unique_present(k,5) == repeated_values(:,5),end-2); % Querier tiden for de samme målinger
        non_unique_present(k,4) = mean(ikke_unikke_pejlinger); % Tager gennemsnitet og indsætter den i stedet for den oprindelige tid for målingen
        ikke_unikke_pejlinger = [];
        ikke_unikke_pejlinger = repeated_values(non_unique_present(k,5) == repeated_values(:,5),end); % Finder pejlinger for de samme målinger
        non_unique_present(k,6) = mean(ikke_unikke_pejlinger);
    end

    % Vi danner nu den fulde matrix, der går fra start_aar til slut_aar og har
    % 12 måneder for hvert år som vi kan query ud fra for at finde de
    % måneder hvor der mangler målinger
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

    % Nu skal vi have sat de målte observation, der er unikke observationer 
    % ind i den fulde datavektor.
    [logic_indice, row_indice] = ismember(non_repeat_values(:,5), datevector_full(:,3));
    datevector_full(row_indice,4:5) = non_repeat_values(logic_indice,[4,6]);

    % Nu skal vi have sat gennemsnitspejlingerne fra de ikke unikke
    % observationer ind i den fulde datavektor.
    [logic_indice, row_indice] = ismember(non_unique_present(:,5), datevector_full(:,3));
    datevector_full(row_indice,4:5) = non_unique_present(logic_indice,[4,6]);

    % datevector_full(any((datevector_full(:,4)==0),2),:) = [] kan anvendes til
    % at teste størrelsen af matrixen. Denne skulle gerne være lig n_repeat.
    % plot(datevector_full(:,3:4:end), datevector_full(:,4:4:end),'-.') 
    % kan anvendes til at tjekke udtrækkene visuelt.

    % Nu skal vi have interpoleret pejleserierne for de manglende
    % måneder. Algoritmen der interpolerer vil gengive NaN værdier i
    % det tilfælde der ikke forefindes nogle målinger før/efter et
    % givent datapunkt. Derfor behøves vi ikke at fjerne eventuelle
    % rækker i tilfælde af at serien starter/slutter uden værdier.

    % Først finder vi datoen for den første pejleindgang (findes i
    % datevector_present)

    % %interpoler manglende månedsværdier
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
    % de tidspunkter vi leder efter værdier for.
    pejlinger_til_videre_analyse([1:size(datevector_full,1)]',indskrivning_til_pejlinger_til_videre_analyse(1,j):indskrivning_til_pejlinger_til_videre_analyse(5,j)) = datevector_full(:,[1 2 3 4 5]);
end
% En af serierne går længere end de andre, hvorfor der i dette tilfælde
% vil blive appended zeros ind for de andre serier. Når vi plotter vil
% det derfor se forkert ud. Derfor finder vi alle række indgangene hvor
% der er zeros og sletter disse.
pejlinger_til_videre_analyse(any(pejlinger_til_videre_analyse == 0,2),:) = [];

% Tidspunkterne vil ikke matche 100% siden vi i scripted fjerne alt under
% tid i måneder fra serien. 

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
%xlabel('År');
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
xlabel('År');
%ylabel('Grundvandskote [m]');

%%% Legend
hold on
ax_leg2 = subplot(2,6,[6,12])
plot(ax_leg2, 1:10, nan(1,10), 'o', 1:10, nan(1,10), 'o', 1:10, nan(1,10), 'o','LineWidth',2);
axis off
legend('DGU 26.536', 'DGU 26.1943', 'DGU 34.492','location','west');

[ax3,h1]=suplabel('Grundvandskote [m]','y');
%[ax4,h2]=suplabel('År','x');

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
xlabel('Måned');
end
hold off

%% ::::::- Print figures ::::::- %% 
 print(udfyldnings_figur,'Pejleserie','-dpng')
 print(seasonality_figure,'SaesonvariationPejleserier','-dpng')

end