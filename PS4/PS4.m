clear all
clc
%question2
y=[300,350,630,780,1020];
x=[1,2,3,4,5];
mdl2=fitlm(x,y,"Intercept",false); 

data=readtable('IMPGSC1.xlsx', 'Sheet', 2);
%df1 = subset(data, observation_date < as.Date("2006-01-01"));
%a=linspace(1,10,10);

startYear = 1947;
endYear = 2024;
% Create quarterly dates
timeindex = datetime(startYear, 1, 1):calquarters(1):datetime(endYear, 12, 31);


%different subset of data (before and after)
tau=datetime(2005, 12, 31);
tau_num=236; %I think the tau should be a natural number in regression but how to find it?
T=312;
after_num=T-tau_num;
time_after=linspace(tau_num+1,T,after_num)';

%subtime=timeindex(timeindex < tau);
subdata1 = data(data.observation_date < tau,:); %data before tau
subdata2=data(data.observation_date >= tau,:); %data after tau
%a
bimports=subdata1.IMPGSC1; 
bln_imports=log(bimports);
beforetimeline=subdata1.observation_date;
timeline=data.observation_date;
aftertimeline=subdata2.observation_date;


% figure;
% plot(beforetimeline, bimports); % Plot x, y  
% hold on;
% title('quarterly imports from 1947 to 2005');
% xlabel('time');
% ylabel('imports');
% xtickformat('yyyy');
% legend('imports', 'Location', 'best');
% grid on; 
% 
% %fitted import under ln(value) 
% figure;
% plot(beforetimeline, bln_imports); % Plot x, y  
% title('natural log of quarterly imports from 1947 to 2005');
% xlabel('time');
% ylabel('ln(imports)');
% xtickformat('yyyy');
% legend('ln(imports)','Location', 'best');
% grid on; 


%b
%c
model_subimports=fitlm(linspace(1,tau_num,tau_num)',log(subdata1.IMPGSC1)); %fitlm(t,ln(T))
%The beta_1 in this model is the same as direct approach, which is
%0.0154. The beta_0 in this linear model is actually ln(intercept) in
%direct expotential model. Here the intercept is 3.9631 so the intercept in
%direct apporach is exp(beta_0)=52.6228
b0 = model_subimports.Coefficients.Estimate(1);
expb0=exp(b0);

% ft=fittype('b0*exp(b1*x)', 'independent', 'x', 'coefficients', {'b0', 'b1'});
% emodel = fit(linspace(1,tau_num,tau_num)',subdata1.IMPGSC1, ft); wrong
% f = fit(linspace(1,tau_num,tau_num)',subdata1.IMPGSC1, 'exp1'); 
% disp(f);
% a=log(-1.014e-18);
% b=exp();

fitted_imports_before=predict(model_subimports,linspace(1,tau_num,tau_num)');

% %fitted import under normal value 
% figure;
% plot(beforetimeline, bimports); % Plot x, y  
% hold on;
% plot(beforetimeline, exp(fitted_imports_before));
% hold off;
% title('quarterly imports from 1947 to 2005 and its estimation');
% xlabel('time');
% ylabel('imports');
% xtickformat('yyyy');
% legend('imports','fitted value of imports', 'Location', 'best');
% grid on; 
% 
% %fitted import under ln(value) 
% figure;
% plot(beforetimeline, bln_imports); % Plot x, y  
% hold on;
% plot(beforetimeline, fitted_imports_before);%fitted_imports_before is estimated in ln(y)
% hold off;
% title('natural log of quarterly imports from 1947 to 2005 and its estimation');
% xlabel('time');
% ylabel('ln(imports)');
% xtickformat('yyyy');
% legend('ln(imports)','fitted value of ln(imports)','Location', 'best');
% grid on; 

%d
Z = norminv(0.95);
fitted_imports_after=predict(model_subimports,time_after);
%calculate std of residual to approx error term
residual=log(subdata1.IMPGSC1)-fitted_imports_before;
std_residual=std(residual);

upper_after = fitted_imports_after+Z*std_residual; 
lower_after = fitted_imports_after-Z*std_residual;

% figure;
% plot(beforetimeline, bln_imports); % Plot x, y  
% hold on;
% plot(aftertimeline, fitted_imports_after);
% plot(aftertimeline, upper_after);
% plot(aftertimeline, lower_after);
% hold off;
% title('natural log of quarterly imports from 1947 to 2005 and forecating of future');
% xlabel('time');
% ylabel('ln(imports)');
% xtickformat('yyyy');
% legend('ln(imports)','predicted ln(imports) of "future"','upperbound of 90% interval', ...
%     'lowerbound of 90% interval','Location', 'best');
% grid on; 
%Comment: based on the forecast, the amount of ln(imports) expect to
%increase as time increase with rate equal to  0.015399.

%e
% figure;
% plot(aftertimeline,log(subdata2.IMPGSC1));
% hold on;
% plot(aftertimeline, fitted_imports_after);
% plot(aftertimeline, upper_after);
% plot(aftertimeline, lower_after);
% hold off;
% title('forecating of "future" ln(imports) and the real ln(imports)');
% xlabel('time');
% ylabel('ln(imports)');
% xtickformat('yyyy');
% legend('real ln(imports)','predicted ln(imports)','upperbound of 90% interval', ...
%     'lowerbound of 90% interval','Location', 'best');

%f
fitted_imports_after_level=exp(fitted_imports_after); %calculated in d

%90 FI

upper_after_level = exp(fitted_imports_after+Z*std_residual); 
lower_after_level = exp(fitted_imports_after-Z*std_residual);

% figure;
% plot(beforetimeline, bimports); % Plot x, y  
% hold on;
% plot(aftertimeline, fitted_imports_after_level);
% plot(aftertimeline, upper_after_level);
% plot(aftertimeline, lower_after_level);
% hold off;
% title('quarterly imports level from 1947 to 2005 and forecating of future');
% xlabel('time');
% ylabel('imports');
% xtickformat('yyyy');
% legend('imports','predicted imports of "future"','upperbound of 90% interval', ...
%     'lowerbound of 90% interval','Location', 'best');
% grid on; 
%Comment: based on the forecast, the amount of imports expect to
%increase as time increase with rate equal to .


%g
% figure; 
% plot(aftertimeline,subdata2.IMPGSC1);
% hold on;
% plot(aftertimeline, fitted_imports_after_level);
% plot(aftertimeline, upper_after_level);
% plot(aftertimeline, lower_after_level);
% hold off;
% title('forecating of "future" imports and the real imports');
% xlabel('time');
% ylabel('imports');
% xtickformat('yyyy');
% legend('real imports','predicted imports','upperbound of 90% interval', ...
%     'lowerbound of 90% interval','Location', 'best');
% grid on; 

%h
%also use expotential model to forecast 
imports_overall_model=fitlm(linspace(1,T,T),log(data.IMPGSC1)); %ln(y)
fitted_imports_overall=predict(imports_overall_model,linspace(1,T,T)');
residual_overall=log(data.IMPGSC1)-fitted_imports_overall;
std_residual_overall=std(residual_overall);
last_date=timeline(length(timeline));
future_timeline=last_date+calquarters(1:16);
future_fitted_imports=predict(imports_overall_model,linspace(T+1,T+16,16)');%ln(y)
future_fitted_imports_level=exp(future_fitted_imports);

upper_future = exp(future_fitted_imports+Z*std_residual_overall); 
lower_future = exp(future_fitted_imports-Z*std_residual_overall);

figure; 
plot(timeindex,data.IMPGSC1);
hold on;
plot(future_timeline, future_fitted_imports_level);
plot(future_timeline, upper_future);
plot(future_timeline, lower_future);
hold off;
title('forecating of next 4 years and the history of imports');
xlabel('time');
ylabel('imports');
xtickformat('yyyy');
legend('all past imports','forecast of imports in next 12Q','upperbound of 90% interval', ...
    'lowerbound of 90% interval','Location', 'best');
grid on; 

