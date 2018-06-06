clear all
close all
clc

%% Beregning af EQR-værdier for Binderup Å.
% Scriptet er videreudviklet efter Gautesen og Olesen 2016 (Originalen findes på
% http://kortlink.dk/mcwu )
tic
%% Data indlæses 

% [num,txt,raw] = xlsread('BinderupAAalle.xlsx',1); % Den målte tidsserie
% [num1,txt1,raw1] = xlsread('BinderupAAalle.xlsx',2); % Den målte tidsserie fratrukket 5% af medianmin
% [num2,txt2,raw2] = xlsread('BinderupAAalle.xlsx',3); % Den målte tidsserie fratrukket 25% af medianmin
% [num3,txt3,raw3] = xlsread('BinderupAAalle.xlsx',4); % Den målte tidsserie fratrukket 50% af medianmin
% [num4,txt4,raw4] = xlsread('BinderupAAalle.xlsx',5); % Den målte tidsserie fratrukket 75% af medianmin
% [num5,txt5,raw5] = xlsread('BinderupAAalle.xlsx',6); % Den målte tidsserie fratrukket 100% af medianmin
% save DataTilEQR.mat;
load DataTilEQR.mat; % Indeholder ovenstående data

%Datoer konverteres til MatLab datoformat

format ='dd-mm-yyyy';
date = datenum(raw(1:end,1),format);
date1 = datenum(raw1(1:end,1),format);
date2 = datenum(raw2(1:end,1),format);
date3 = datenum(raw3(1:end,1),format);
date4 = datenum(raw4(1:end,1),format);
date5 = datenum(raw5(1:end,1),format);

%Flow matricer specificeres

flow = num(:,1)./1000;  %Konvertering til m3/s
flow1 = num1(:,1)/1000;
flow2 = num2(:,1)/1000;
flow3 = num3(:,1)/1000;
flow4 = num4(:,1)/1000;
flow5 = num5(:,1)/1000;

%% Bestemmelse af Baseflow vha 5 døgns minimum vol 0

minbase_st = zeros(length(date),2); %Nulmatricen specificeres
n=5;
t=1;
while n < length(flow)-4  
    minbase_st(t,1) = min(flow(n-4:n));
    I = find(flow(n-4:n)==min(flow(n-4:n)));
    dag = I(1,1);
    minbase_st(t,2) = date(dag+n-5);
    n=n+5;
    t=t+1;
end

k= 1;
for i=2:length(minbase_st)-1
    if minbase_st(i,1)*0.9 < minbase_st(i-1,1) && minbase_st(i,1)*0.9 < minbase_st(i+1,1)
        minbase(k,1)= minbase_st(i,1);
        minbase(k,2)= minbase_st(i,2);
        k=k+1;
    end
end 
[x_dates, index] = unique(minbase(:,2)); 
x = minbase(1,2):minbase(end,2);
y = interp1(x_dates,minbase(index,1),x);

bfi=(sum(y)/length(y))/(sum(flow)/length(flow));
 
%% Bestemmelse af Baseflow vha 5 døgns minimum vol  1
minbase_st1 = zeros(length(date1),2);
n=5;
t=1;
while n < length(flow1)-4  
    minbase_st1(t,1) = min(flow1(n-4:n));
    I = find(flow1(n-4:n)==min(flow1(n-4:n)));
    dag = I(1,1);
    minbase_st1(t,2) = date1(dag+n-5);
    n=n+5;
    t=t+1;
end

k= 1;
for i=2:length(minbase_st1)-1
    if minbase_st1(i,1)*0.9 < minbase_st1(i-1,1) && minbase_st1(i,1)*...
            0.9 < minbase_st1(i+1,1)
        minbase1(k,1)= minbase_st1(i,1);
        minbase1(k,2)= minbase_st1(i,2);
        k=k+1;
    end
end 

[x1_dates, index1] = unique(minbase1(:,2)); 
x1 = minbase1(1,2):minbase1(end,2);
y1 = interp1(x1_dates,minbase1(index1,1),x1);

bfi1=(sum(y1)/length(y1))/(sum(flow1)/length(flow1));

%% Bestemmelse af Baseflow vha 5 døgns minimum vol  2

minbase_st2 = zeros(length(date2),2);
n=5;
t=1;
while n < length(flow2)-4  
    minbase_st2(t,1) = min(flow2(n-4:n));
    I = find(flow2(n-4:n)==min(flow2(n-4:n)));
    dag = I(1,1);
    minbase_st2(t,2) = date2(dag+n-5);
    n=n+5;
    t=t+1;
end

k= 1;
for i=2:length(minbase_st2)-1
    if minbase_st2(i,1)*0.9 < minbase_st2(i-1,1) && minbase_st2(i,1)*...
            0.9 < minbase_st2(i+1,1)
        minbase2(k,1)= minbase_st2(i,1);
        minbase2(k,2)= minbase_st2(i,2);
        k=k+1;
    end
end 

[x2_dates, index2] = unique(minbase2(:,2)); 
x2 = minbase2(1,2):minbase2(end,2);
y2 = interp1(x2_dates,minbase2(index2,1),x2);

bfi2=(sum(y2)/length(y2))/(sum(flow2)/length(flow2));

%% Bestemmelse af Baseflow vha 5 døgns minimum vol  3

minbase_st3 = zeros(length(date3),2);
n=5;
t=1;
while n < length(flow3)-4  
    minbase_st3(t,1) = min(flow3(n-4:n));
    I = find(flow3(n-4:n)==min(flow3(n-4:n)));
    dag = I(1,1);
    minbase_st3(t,2) = date3(dag+n-5);
    n=n+5;
    t=t+1;
end

k= 1;
for i=2:length(minbase_st3)-1
    if minbase_st3(i,1)*0.9 < minbase_st3(i-1,1) && minbase_st3(i,1)*...
            0.9 < minbase_st3(i+1,1)
        minbase3(k,1)= minbase_st3(i,1);
        minbase3(k,2)= minbase_st3(i,2);
        k=k+1;
    end
end 

[x3_dates, index3] = unique(minbase3(:,2)); 
x3 = minbase3(1,2):minbase3(end,2);
y3 = interp1(x3_dates,minbase3(index3,1),x3);

bfi3=(sum(y3)/length(y3))/(sum(flow3)/length(flow3));

%% Bestemmelse af Baseflow vha 5 døgns minimum vol  4

minbase_st4 = zeros(length(date4),2);
n=5;
t=1;
while n < length(flow4)-4  
    minbase_st4(t,1) = min(flow4(n-4:n));
    I = find(flow4(n-4:n)==min(flow4(n-4:n)));
    dag = I(1,1);
    minbase_st4(t,2) = date4(dag+n-5);
    n=n+5;
    t=t+1;
end

k= 1;
for i=2:length(minbase_st4)-1
    if minbase_st4(i,1)*0.9 < minbase_st4(i-1,1) && minbase_st4(i,1)*...
            0.9 < minbase_st4(i+1,1)
        minbase4(k,1)= minbase_st4(i,1);
        minbase4(k,2)= minbase_st4(i,2);
        k=k+1;
    end
end 

[x4_dates, index4] = unique(minbase4(:,2)); 
x4 = minbase4(1,2):minbase4(end,2);
y4 = interp1(x4_dates,minbase4(index4,1),x4);

bfi4=(sum(y4)/length(y4))/(sum(flow4)/length(flow4));

%% Bestemmelse af Baseflow vha 5 døgns minimum vol  5

minbase_st5 = zeros(length(date5),2);
n=5;
t=1;
while n < length(flow5)-4  
    minbase_st5(t,1) = min(flow5(n-4:n));
    I = find(flow5(n-4:n)==min(flow5(n-4:n)));
    dag = I(1,1);
    minbase_st5(t,2) = date5(dag+n-5);
    n=n+5;
    t=t+1;
end

k= 1;
for i=2:length(minbase_st5)-1
    if minbase_st5(i,1)*0.9 < minbase_st5(i-1,1) && minbase_st5(i,1)*...
            0.9 < minbase_st5(i+1,1)
        minbase5(k,1)= minbase_st5(i,1);
        minbase5(k,2)= minbase_st5(i,2);
        k=k+1;
    end
end 

[x5_dates, index5] = unique(minbase5(:,2)); 
x5 = minbase5(1,2):minbase5(end,2);
y5 = interp1(x5_dates,minbase5(index5,1),x5);

bfi5=(sum(y5)/length(y5))/(sum(flow5)/length(flow5));

%% Bestemmelse af baseflow vha Digital filter Technique for vol 0

beta = 0.925; %Filter parameter
qt = zeros(length(flow(:,1)),1);
for n=2:length(qt) % n specificeres til at starte ved 2, da det giver mulighed for at skrive n-1 i for løkken
    qt(n,1) = beta*qt(n-1,1) + (1+beta)/2 * (flow(n,1)-flow(n-1,1));
end
qt(qt<0) = 0; %Overfladeafstrømningen kan ikke være negativ
bt = flow(:,1)- qt; %Baseflow angives som målt flow - overfladeafstrømning.
bfibt=(sum(bt)/length(bt))/(sum(flow)/length(flow)); %BFI beregnes

%% Års Minimum og andre parametre

%% Binderup Å vol 0

value = zeros(floor((length(date))/365),1);
aarsmin = zeros(floor((length(date))/365),2);
I = zeros(floor((length(date))/365),1);
criteria = length(date);
year = 365;

% Fre25 Fre75 dur3 BFI Fre1

percentiles = prctile(flow,[25 50 75],1);
presortfre1 = flow > median(flow);
presortfre25 = flow > percentiles(3);
presortfre75 = flow < percentiles(1);
presortdur3 = flow > (percentiles(2)*3);


Fre1count = zeros(size(flow));
Fre25count = zeros(size(flow));
Fre75count = zeros(size(flow));
  
 if presortfre1(1) == 1;
 presortfre1(1) = 0;
 end
 
 if presortfre25(1) == 1;
 presortfre25(1) = 0;
 end
 
  if presortfre75(1) == 1;
 presortfre75(1) = 0;
 end
 
n=1;
i=1;
 
 while year <= (criteria)+100;
  
     if year >= criteria
        year = length(flow);
     end
     
        for u =i:year-1;
          if presortfre1(u)-presortfre1(u+1) == -1;
                 Fre1count(u)=1;
          end
        end
      
      Fre1_binderup_aa(n)=sum(Fre1count(i:year));
      
         for u =i:year-1;
           if presortfre25(u)-presortfre25(u+1) == -1;
                 Fre25count(u)=1;
           end
         end
      
      Fre25_binderup_aa(n)=sum(Fre25count(i:year));
      
      
      for u =i:year-1;
         if presortfre75(u)-presortfre75(u+1) == -1;
                 Fre75count(u)=1;
         end
      end
      
      Fre75_binderup_aa(n)=sum(Fre75count(i:year));
     
      Dur3_binderup_aa(n)=sum(presortdur3(i:year));
      
    [value(n),I(n)] = min(flow(i:year));
    
    I = I';
    aarsmin(n,1) = value(n);
    aarsmin(n,2) = date(I(n)+(year-365));
    Q90_aar(n) = prctile(flow(i:year),10);
    n=n+1;
    i=i+365;
    year = year + 365;
   
 end
 
 %% Binderip Å -5% af medianmin

value = zeros(floor((length(date1))/365),1);
aarsmin1 = zeros(floor((length(date1))/365),2);
I = zeros(floor(length(date1)/365),1);
criteria = length(date1);
year = 365;

percentiles = prctile(flow1,[25 50 75],1);
presortfre1 = flow1 > median(flow1);
Fre1count = zeros(size(flow1));
presortfre25 = flow1 > percentiles(3);
presortfre75 = flow1 < percentiles(1);
presortdur3 = flow1 > (percentiles(2)*3);
 
if presortfre1(1) == 1;
presortfre1(1) = 0;
end

if presortfre25(1) == 1;
presortfre25(1) = 0;
end
 
if presortfre75(1) == 1;
presortfre75(1) = 0;
end
 
n=1;
i=1;
 
 while year <= (criteria)+100;
  
     if year >= criteria
        year = length(flow1);
     end
     
           for u =i:year-1;
             if presortfre1(u+1)-presortfre1(u) == -1;
                Fre1count(u)=1;
             end
           end
      
      Fre1_binderup_aa_5pct(n)=sum(Fre1count(i:year));
      
      for u =i:year-1;
           if presortfre25(u)-presortfre25(u+1) == -1;
                 Fre25count(u)=1;
           end
         end
      
      Fre25_binderup_aa_5pct(n)=sum(Fre25count(i:year));
      
      
      for u =i:year-1;
         if presortfre75(u)-presortfre75(u+1) == -1;
                 Fre75count(u)=1;
         end
      end
      
      Fre75_binderup_aa_5pct(n)=sum(Fre75count(i:year));
     
      Dur3_binderup_aa_5pct(n)=sum(presortdur3(i:year));
     
    [value(n),I(n)] = min(flow1(i:year));
    I = I';
    aarsmin1(n,1) = value(n);
    aarsmin1(n,2) = date1(I(n)+(year-365));
    Q90_aar_1(n) = prctile(flow1(i:year),10);
    n=n+1;
    i=i+365;
    year = year + 365;
   
 end

%% Binderup Å -25% af medianmin
value = zeros(floor((length(date2))/365),1);
aarsmin2 = zeros(floor((length(date2))/365),2);
I = zeros(floor(length(date2)/365),1);
criteria = length(date2);
year = 365;

percentiles = prctile(flow2,[25 50 75],1);
presortfre1 = flow2 > median(flow2);
Fre1count = zeros(size(flow2));
presortfre25 = flow2 > percentiles(3);
presortfre75 = flow2 < percentiles(1);
presortdur3 = flow2 > (percentiles(2)*3);
 
if presortfre1(1) == 1;
presortfre1(1) = 0;
end

if presortfre25(1) == 1;
presortfre25(1) = 0;
end
 
if presortfre75(1) == 1;
presortfre75(1) = 0;
end
 
n=1;
i=1;
 
 while year <= (criteria)+100;
  
     if year >= criteria
        year = length(flow2);
     end
     
      for u =i:year-1;
             if presortfre1(u+1)-presortfre1(u) == -1;
                Fre1count(u)=1;
             end
      end
      
      Fre1_binderup_aa_25pct(n)=sum(Fre1count(i:year));
     
      for u =i:year-1;
           if presortfre25(u)-presortfre25(u+1) == -1;
                 Fre25count(u)=1;
           end
      end
      
      Fre25_binderup_aa_25pct(n)=sum(Fre25count(i:year));
      
      
      for u =i:year-1;
         if presortfre75(u)-presortfre75(u+1) == -1;
                 Fre75count(u)=1;
         end
      end
      
      Fre75_binderup_aa_25pct(n)=sum(Fre75count(i:year));
     
      Dur3_binderup_aa_25pct(n)=sum(presortdur3(i:year));
      
    [value(n),I(n)] = min(flow2(i:year));
    I = I';
    aarsmin2(n,1) = value(n);
    aarsmin2(n,2) = date2(I(n)+(year-365));
    Q90_aar_2(n) = prctile(flow2(i:year),10);
    n=n+1;
    i=i+365;
    year = year + 365;
   
 end
 
 %% Binderup Å -50% af medianmin
value = zeros(floor((length(date3))/365),1);
aarsmin3 = zeros(floor((length(date3))/365),2);
I = zeros(floor(length(date3)/365),1);
criteria = length(date3);
year = 365;

percentiles = prctile(flow3,[25 50 75],1);
presortfre1 = flow3 > median(flow3);
Fre1count = zeros(size(flow3));
presortfre25 = flow3 > percentiles(3);
presortfre75 = flow3 < percentiles(1);
presortdur3 = flow3 > (percentiles(2)*3);
 
if presortfre1(1) == 1;
presortfre1(1) = 0;
end

if presortfre25(1) == 1;
presortfre25(1) = 0;
end
 
if presortfre75(1) == 1;
presortfre75(1) = 0;
end
 
n=1;
i=1;
 
 while year <= (criteria)+100;
  
     if year >= criteria
        year = length(flow3);
     end
     
      for u =i:year-1;
             if presortfre1(u+1)-presortfre1(u) == -1;
                Fre1count(u)=1;
             end
      end
      
      Fre1_binderup_aa_50pct(n)=sum(Fre1count(i:year));
     
      for u =i:year-1;
           if presortfre25(u)-presortfre25(u+1) == -1;
                 Fre25count(u)=1;
           end
      end
      
      Fre25_binderup_aa_50pct(n)=sum(Fre25count(i:year));
      
      
      for u =i:year-1;
         if presortfre75(u)-presortfre75(u+1) == -1;
                 Fre75count(u)=1;
         end
      end
      
      Fre75_binderup_aa_50pct(n)=sum(Fre75count(i:year));
     
      Dur3_binderup_aa_50pct(n)=sum(presortdur3(i:year));
      
    [value(n),I(n)] = min(flow3(i:year));
    I = I';
    aarsmin3(n,1) = value(n);
    aarsmin3(n,2) = date3(I(n)+(year-365));
    Q90_aar_3(n) = prctile(flow3(i:year),10);
    n=n+1;
    i=i+365;
    year = year + 365;
   
 end
 
 %% Binderup Å -75% af medianmin
value = zeros(floor((length(date4))/365),1);
aarsmin4 = zeros(floor((length(date4))/365),2);
I = zeros(floor(length(date4)/365),1);
criteria = length(date4);
year = 365;

percentiles = prctile(flow4,[25 50 75],1);
presortfre1 = flow4 > median(flow4);
Fre1count = zeros(size(flow4));
presortfre25 = flow4 > percentiles(3);
presortfre75 = flow4 < percentiles(1);
presortdur3 = flow4 > (percentiles(2)*3);
 
if presortfre1(1) == 1;
presortfre1(1) = 0;
end

if presortfre25(1) == 1;
presortfre25(1) = 0;
end
 
if presortfre75(1) == 1;
presortfre75(1) = 0;
end
 
n=1;
i=1;
 
 while year <= (criteria)+100;
  
     if year >= criteria
        year = length(flow4);
     end
     
      for u =i:year-1;
             if presortfre1(u+1)-presortfre1(u) == -1;
                Fre1count(u)=1;
             end
      end
      
      Fre1_binderup_aa_75pct(n)=sum(Fre1count(i:year));
     
      for u =i:year-1;
           if presortfre25(u)-presortfre25(u+1) == -1;
                 Fre25count(u)=1;
           end
      end
      
      Fre25_binderup_aa_75pct(n)=sum(Fre25count(i:year));
      
      
      for u =i:year-1;
         if presortfre75(u)-presortfre75(u+1) == -1;
                 Fre75count(u)=1;
         end
      end
      
      Fre75_binderup_aa_75pct(n)=sum(Fre75count(i:year));
     
      Dur3_binderup_aa_75pct(n)=sum(presortdur3(i:year));
      
    [value(n),I(n)] = min(flow4(i:year));
    I = I';
    aarsmin4(n,1) = value(n);
    aarsmin4(n,2) = date4(I(n)+(year-365));
    Q90_aar_4(n) = prctile(flow4(i:year),10);
    n=n+1;
    i=i+365;
    year = year + 365;
   
 end
 
 %% Binderup Å -100% af medianmin
value = zeros(floor((length(date5))/365),1);
aarsmin5 = zeros(floor((length(date5))/365),2);
I = zeros(floor(length(date5)/365),1);
criteria = length(date5);
year = 365;

percentiles = prctile(flow5,[25 50 75],1);
presortfre1 = flow5 > median(flow5);
Fre1count = zeros(size(flow5));
presortfre25 = flow5 > percentiles(3);
presortfre75 = flow5 < percentiles(1);
presortdur3 = flow5 > (percentiles(2)*3);
 
if presortfre1(1) == 1;
presortfre1(1) = 0;
end

if presortfre25(1) == 1;
presortfre25(1) = 0;
end
 
if presortfre75(1) == 1;
presortfre75(1) = 0;
end
 
n=1;
i=1;
 
 while year <= (criteria)+100;
  
     if year >= criteria
        year = length(flow5);
     end
     
      for u =i:year-1;
             if presortfre1(u+1)-presortfre1(u) == -1;
                Fre1count(u)=1;
             end
      end
      
      Fre1_binderup_aa_100pct(n)=sum(Fre1count(i:year));
     
      for u =i:year-1;
           if presortfre25(u)-presortfre25(u+1) == -1;
                 Fre25count(u)=1;
           end
      end
      
      Fre25_binderup_aa_100pct(n)=sum(Fre25count(i:year));
      
      
      for u =i:year-1;
         if presortfre75(u)-presortfre75(u+1) == -1;
                 Fre75count(u)=1;
         end
      end
      
      Fre75_binderup_aa_100pct(n)=sum(Fre75count(i:year));
     
      Dur3_binderup_aa_100pct(n)=sum(presortdur3(i:year));
      
    [value(n),I(n)] = min(flow5(i:year));
    I = I';
    aarsmin5(n,1) = value(n);
    aarsmin5(n,2) = date5(I(n)+(year-365));
    Q90_aar_5(n) = prctile(flow5(i:year),10);
    n=n+1;
    i=i+365;
    year = year + 365;
   
 end
 
%% Bestemmelse af faktorer til vandplan 2-metode beregning af EQR
% Q10
q10 = prctile(flow,90);
q10_1 = prctile(flow1,90);
q10_2 = prctile(flow2,90);
q10_3 = prctile(flow3,90);
q10_4 = prctile(flow4,90);
q10_5 = prctile(flow5,90);

% Q50
q50 = median(flow);
q50_1 = median(flow1);
q50_2 = median(flow2);
q50_3 = median(flow3);
q50_4 = median(flow4);
q50_5 = median(flow5);

% Q90
q90 = prctile(flow,10);
q90_1 = prctile(flow1,10);
q90_2 = prctile(flow2,10);
q90_3 = prctile(flow3,10);
q90_4 = prctile(flow4,10);
q90_5 = prctile(flow5,10);

% Q90/Q50
q90q50 = prctile(flow,10)/q50;
q90q50_1 = prctile(flow1,10)/q50_1;
q90q50_2 = prctile(flow2,10)/q50_2;
q90q50_3 = prctile(flow3,10)/q50_3;
q90q50_4 = prctile(flow4,10)/q50_3;
q90q50_5 = prctile(flow5,10)/q50_3;

% medianmin
medianmin=median(aarsmin(:,1));
medianmin1=median(aarsmin1(:,1));
medianmin2=median(aarsmin2(:,1));
medianmin3=median(aarsmin3(:,1));
medianmin4=median(aarsmin4(:,1));
medianmin5=median(aarsmin5(:,1));

%% Korrelation mellem årsminimum og Q90 pr. år

Corr_Binderup = corrcoef(Q90_aar,aarsmin(:,1));
Corr_Binderup = Corr_Binderup(1,2)^2;

Corr_Binderup_aa_5pct = corrcoef(Q90_aar_1,aarsmin1(:,1));
Corr_Binderup_aa_5pct = Corr_Binderup_aa_5pct(1,2)^2;

Corr_Binderup_aa_25pct = corrcoef(Q90_aar_2,aarsmin2(:,1));
Corr_Binderup_aa_25pct = Corr_Binderup_aa_25pct(1,2)^2;

Corr_Binderup_aa_50pct = corrcoef(Q90_aar_3,aarsmin3(:,1));
Corr_Binderup_aa_50pct = Corr_Binderup_aa_50pct(1,2)^2;

Corr_Binderup_aa_75pct = corrcoef(Q90_aar_4,aarsmin4(:,1));
Corr_Binderup_aa_75pct = Corr_Binderup_aa_75pct(1,2)^2;

Corr_Binderup_aa_100pct = corrcoef(Q90_aar_5,aarsmin5(:,1));
Corr_Binderup_aa_100pct = Corr_Binderup_aa_100pct(1,2)^2;

%% Beregning af kvalitetsindeks
% Slyngningsgrad Binderup Å 28,91/18,06=1,60 dvs. slyngningsklasse 4,
% mæandrerende
fuld_L=28.91; % Vandløbets fulde længde
fugle_L=18.06; %fugleflugt/lineær afstand
Sin = fuld_L/fugle_L;

%Binderup Å
Kval_DVPI = 0.546 + 0.02 * mean(Fre25_binderup_aa) - 0.019 * ...
    mean(Dur3_binderup_aa) - 0.025 *mean(Fre75_binderup_aa);
Kval_DVFI = 0.217 + 0.103 * Sin + 0.020 * q90q50*mean(Fre1_binderup_aa);
Kval_DFFV = 0.811 * bfibt + 0.058 * Sin + 0.050*mean(Fre25_binderup_aa)...
    - 0.319 - 0.0413 * mean(Fre75_binderup_aa);

%Binderup Å -5%
Kval_DVPI1 = 0.546 + 0.02 * mean(Fre25_binderup_aa_5pct) - 0.019...
    * mean(Dur3_binderup_aa_5pct) - 0.025 *mean...
    (Fre75_binderup_aa_5pct);
Kval_DVFI1 = 0.217 + 0.103 * Sin + 0.020 * q90q50_1 * mean...
    (Fre1_binderup_aa_5pct);
Kval_DFFV1 = 0.811 * bfi1 + 0.058 * Sin + 0.050 * mean...
    (Fre25_binderup_aa_5pct) - 0.319 - 0.0413 * mean...
    (Fre75_binderup_aa_5pct);

%Binderup Å -25%
Kval_DVPI2 = 0.546 + 0.02 * mean(Fre25_binderup_aa_25pct) - 0.019 * mean...
    (Dur3_binderup_aa_25pct) - 0.025 *mean(Fre75_binderup_aa_25pct);
Kval_DVFI2 = 0.217 + 0.103 * Sin + 0.020 * q90q50_2 * mean...
    (Fre1_binderup_aa_25pct);
Kval_DFFV2 = 0.811 * bfi2 + 0.058 * Sin + 0.050 * mean...
    (Fre25_binderup_aa_25pct) - 0.319 - 0.0413 * mean(Fre75_binderup_aa_25pct);

%Binderup Å -50%
Kval_DVPI3 = 0.546 + 0.02 * mean(Fre25_binderup_aa_50pct) - 0.019 * mean...
    (Dur3_binderup_aa_50pct) - 0.025 *mean(Fre75_binderup_aa_50pct);
Kval_DVFI3 = 0.217 + 0.103 * Sin + 0.020 * q90q50_3 * mean...
    (Fre1_binderup_aa_50pct);
Kval_DFFV3 = 0.811 * bfi3 + 0.058 * Sin + 0.050 * mean...
    (Fre25_binderup_aa_50pct) - 0.319 - 0.0413 * mean(Fre75_binderup_aa_50pct);

%Binderup Å -75%
Kval_DVPI4 = 0.546 + 0.02 * mean(Fre25_binderup_aa_75pct) - 0.019 * mean...
    (Dur3_binderup_aa_75pct) - 0.025 *mean(Fre75_binderup_aa_75pct);
Kval_DVFI4 = 0.217 + 0.103 * Sin + 0.020 * q90q50_4 * mean...
    (Fre1_binderup_aa_75pct);
Kval_DFFV4 = 0.811 * bfi4 + 0.058 * Sin + 0.050 * mean...
    (Fre25_binderup_aa_75pct) - 0.319 - 0.0413 * mean(Fre75_binderup_aa_75pct);

%Binderup Å -100%
Kval_DVPI5 = 0.546 + 0.02 * mean(Fre25_binderup_aa_100pct) - 0.019 * mean...
    (Dur3_binderup_aa_100pct) - 0.025 *mean(Fre75_binderup_aa_100pct);
Kval_DVFI5 = 0.217 + 0.103 * Sin + 0.020 * q90q50_5 * mean...
    (Fre1_binderup_aa_100pct);
Kval_DFFV5 = 0.811 * bfi5 + 0.058 * Sin + 0.050 * mean...
    (Fre25_binderup_aa_100pct) - 0.319 - 0.0413 * mean(Fre75_binderup_aa_100pct);

%% Figurer

set(0,'DefaultAxesFontSize',13)
%% Baseflow plottes sammen med målt flow 
tic

figure('Name','Korrelation Årsmin, Q90','NumberTitle','off')
hold on
scatter(Q90_aar,aarsmin(:,1),'o')
hline = refline([0 Corr_Binderup]);
set(hline,'Visible','off')
hline.Color = 'w';
legend('Årsmin, Q90',sprintf('R^2 = %.3f',Corr_Binderup),'location','southeast')
title('Korrelation Årsmin, Q90')
% ylim([0 0.1]);
xlabel('Q90')
ylabel('Årsminimumsvandføring [m^3/s]')

figure('Name','Binderup Å','NumberTitle','off','Position',[100 100 1200 400])
hold on
plot(date(:),flow(:)) %Tidsintervallet angives således da der er nulværdier i starten og i slutningen af baseflow matricen pga midlingen.
plot(date,bt)
scatter(aarsmin(:,2),aarsmin(:,1),'o')
hline = refline([0 q90]);
hline.Color = 'k';
set(hline(1),'LineStyle','--')
hline = refline([0 median(flow)]);
hline.Color = 'k';
set(hline(1),'LineStyle','--')
hline = refline([0 q10]);
hline.Color = 'k';
set(hline(1),'LineStyle','--')
hline = refline([0 median(aarsmin(:,1))]);
hline.Color = 'g';
set(hline(1),'LineStyle','--')
hline = refline([0 bfibt]);
hline.Color = 'w';
set(hline(1),'LineStyle','--')
title('Binderup Å')
%ylim([0 0.4])
xlabel('År')
ylabel('Vandføring m^3/s')
legend('Målt Vandføring','Baseflow','Årsmin',sprintf('Q90 = %.3f',q90),sprintf('Q50 = %.3f',median(flow)),sprintf('Q10 = %.3f',q10),sprintf('Q_{mm} = %.3f',median(aarsmin(:,1))),sprintf('BFI = %.3f',bfibt))
datetick('x','yyyy','keeplimits')

maxtime = length(minbase); %Benyttes til at angive tidsinterval i plottet.

 save flowdataBinderup
 save('AarsminBinderup.mat','aarsmin');

%% Varighedskurver
varig(:,1)=sort(flow,'descend');
varig(:,2)=1:length(flow);
varig(:,2)=100/length(flow)*varig(:,2);

varig1(:,1)=sort(flow1,'descend');
varig1(:,2)=1:length(flow1);
varig1(:,2)=100/length(flow1)*varig1(:,2);

varig2(:,1)=sort(flow2,'descend');
varig2(:,2)=1:length(flow2);
varig2(:,2)=100/length(flow2)*varig2(:,2);

varig3(:,1)=sort(flow3,'descend');
varig3(:,2)=1:length(flow3);
varig3(:,2)=100/length(flow3)*varig3(:,2);

varig4(:,1)=sort(flow4,'descend');
varig4(:,2)=1:length(flow4);
varig4(:,2)=100/length(flow4)*varig4(:,2);

varig5(:,1)=sort(flow5,'descend');
varig5(:,2)=1:length(flow5);
varig5(:,2)=100/length(flow5)*varig5(:,2);

figure('Name','Varighedskurve','NumberTitle','off','Position',[100 100 600 400])
hold on
plot0=plot(varig(:,2),varig(:,1),'r','LineWidth',2)
plot1=plot(varig1(:,2),varig1(:,1),'b','LineWidth',2)
plot2=plot(varig2(:,2),varig2(:,1),'y','LineWidth',2)
plot3=plot(varig3(:,2),varig3(:,1),'m','LineWidth',2)
plot4=plot(varig4(:,2),varig4(:,1),'g','LineWidth',2)
plot5=plot(varig5(:,2),varig5(:,1),'c','LineWidth',2)
Leg=legend('Varighedskurve','Varighedskurve, -5% af Q_{mm}', 'Varighedskurve, -25% af Q_{mm}', 'Varighedskurve, -50% af Q_{mm}', 'Varighedskurve, -75% af Q_{mm}','Varighedskurve, -100% af Q_{mm}','location','NorthEast');
xlabel('%')
ylabel('Vandføring [m^3/s]')