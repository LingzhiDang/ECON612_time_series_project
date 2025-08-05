clear all
clc

gdp=readtable("realgdpgrowth.xlsx"); 


%time=gdp.time;
%pce=gdp.pce_nondurables;
%3a
mean_pce=mean(gdp.pce_nondurables);
std_pce = std(gdp.pce_nondurables);
%Or I can use fitted value
one = ones(length(gdp.date),1); %create a matrix with all 1  %matrix = repmat(value, rows, cols);
mdl = fitlm(one,gdp.pce_nondurables,"Intercept",false); %reg y x in matlab is fitlm(x,y)
X = ones(length(gdp.date),1);
y_fitted = predict(mdl,X); %predict all Y by model and X, since all same X, report 1 but not 310 diff

%plotting
mean_pce_overT = repmat(mean_pce,length(gdp.date),1);
figure;
plot(gdp.date, gdp.pce_nondurables); % Plot x, y  
hold on;
plot(gdp.date, mean_pce_overT); % Add the mean as a horizontal line
hold off;

title('PCE of nondurables over quaters and fitted value');
xlabel('time');
ylabel('change rate (%)');
xtickformat('yyyy');
legend('PCE of nondurables change rate', 'Fitted value', 'Location', 'best');
grid on;

%b
%point forecast
h=gdp.date(end,1)+calquarters(1:4);
p_forecasts = repmat(mean_pce, size(h));

%interval forecas
%Z = 1.645;
Z = norminv(0.95);
T = length(gdp.date);
upper = mean_pce+Z*std_pce*sqrt((1+1/T)); %mean_pce is \hat{\beta}
lower = mean_pce-Z*std_pce*sqrt((1+1/T));
upper_overh = repmat(upper,length(h));
lower_overh = repmat(lower,length(h));

%plot together
figure;
hold on;
plot(h, p_forecasts, "k--o",'DisplayName', 'point forecast');%point forecast
plot(h, upper_overh, 'r--');
plot(h, lower_overh, 'r--');

title('Forecasts for non-durables for the next 4 quarter');
xlabel('time');
ylabel('change rate (%)');
legend('point forecast','95% quantile (upperbound of 90% CI)','5% quantile (lowerbound of 90% CI)',"Location",'best');
%legend('Location', 'NW');
xtickformat('yyyy-MM')
grid on;
hold off;

