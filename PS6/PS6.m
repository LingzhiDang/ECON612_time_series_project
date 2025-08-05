clear all
clc

gdp=readtable("realgdpgrowth.xlsx");
sp = readtable('s&p.csv');
%1


%2
south_adjust=readtable("HOUSTS.xlsx",'Sheet', 2);
south_unadjust=readtable("HOUSTSNSA.xlsx",'Sheet', 2);
midwest_adjust=readtable("HOUSTMW.xlsx",'Sheet', 2);
midwest_unadjust=readtable("HOUSTMWNSA.xlsx",'Sheet', 2);

% figure; %HOUSTS
% autocorr(south_adjust.HOUSTS,50);
% xlabel('Lags');
% ylabel('Sample Autocorrelation');
% title('Autocorrelation of housing starts for US south region, seasonally adjusted');
% grid on;
% 
figure; %HOUSTS_NSA
autocorr(south_unadjust.HOUSTSNSA,50);
xlabel('Lags');
ylabel('Sample Autocorrelation');
title('Autocorrelation of housing starts for US south region, seasonally unadjusted');
grid on;

% figure; %HOUSTMW
% autocorr(midwest_adjust.HOUSTMW,50);
% xlabel('Lags');
% ylabel('Sample Autocorrelation');
% title('Autocorrelation of housing starts for US midwest region, seasonally adjusted');
% grid on;
% 
% figure; %HOUSTMW_NSA
% autocorr(midwest_unadjust.HOUSTMWNSA,50);
% xlabel('Lags');
% ylabel('Sample Autocorrelation');
% title('Autocorrelation of housing starts for US midwest region, seasonally unadjusted');
% grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%3
T = length(sp.date);
time = (1:T)';
%one=ones(T);
ln_vol=log(sp.volume);
mdl = fitlm(time,ln_vol);


% Convert the date column to datetime format
sp.date = datetime(sp.date, 'InputFormat', 'M/d/yyyy');
% Sort the table in case dates are not in order
sp = sortrows(sp, 'date');


residual=mdl.Residuals.Raw;
figure;
plot(sp.date, residual); % Plot x, y  
hold on;
title('time-series plot of the residuals');
xlabel('time');
ylabel('residual');
xtickformat('yyyy');
legend('residuals', 'Location', 'best');
grid on; 

figure; 
autocorr(residual,50);
xlabel('Lags');
ylabel('Sample Autocorrelation');
title('Autocorrelation of residuals');
grid on;

