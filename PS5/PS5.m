clear all
clc


men=readtable('LNU04000025.xlsx', 'Sheet', 2);
women=readtable('LNU04000026.xlsx', 'Sheet', 2);
w_men=readtable('LNU04000028.xlsx', 'Sheet', 2);
w_women=readtable('LNU04000029.xlsx', 'Sheet', 2);
b_men=readtable('LNU04000031.xlsx', 'Sheet', 2);
b_women=readtable('LNU04000032.xlsx', 'Sheet', 2);


%a
M=month(men.observation_date);
mo=dummyvar(M);
men_model=fitlm(mo,men.LNU04000025,'Intercept',false);
women_model=fitlm(mo,women.LNU04000026,'Intercept',false);
bm = men_model.Coefficients.Estimate;
bw = women_model.Coefficients.Estimate;


% hard curve
% Define months
months = 1:12;
month_labels = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', ...
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};

unemployment_men = [bm(1), bm(2), bm(3), bm(4), bm(5), bm(6), bm(7), bm(8), bm(9), bm(10), bm(11), bm(12)];
unemployment_women = [bw(1), bw(2), bw(3), bw(4), bw(5), bw(6), bw(7), bw(8), bw(9), bw(10), bw(11), bw(12)];


figure;
hold on;
plot(months, unemployment_men, '-ob', 'LineWidth', 2, 'MarkerFaceColor', 'b'); % Blue line for men
plot(months, unemployment_women, '-sr', 'LineWidth', 2, 'MarkerFaceColor', 'r'); % Red line for women

% Customize the plot
xticks(months);
xticklabels(month_labels);
xlabel('Month');
ylabel('Estimated unemployment rate');
title('Unemployment of men and women among seasons');
legend({'Fitted Men', 'Fitted Women'}, 'Location', 'Best');
grid on;
hold off;


%b
Mw=month(w_men.observation_date);
mow=dummyvar(Mw);
Mb=month(b_men.observation_date);
mob=dummyvar(Mb);

w_men_model=fitlm(mow,w_men.LNU04000028,'Intercept',false);
w_women_model=fitlm(mow,w_women.LNU04000029,'Intercept',false);
b_men_model=fitlm(mob,b_men.LNU04000031,'Intercept',false);
b_women_model=fitlm(mob,b_women.LNU04000032,'Intercept',false);

bwm = w_men_model.Coefficients.Estimate;
bww = w_women_model.Coefficients.Estimate;
bbm = b_men_model.Coefficients.Estimate;
bbw = b_women_model.Coefficients.Estimate;


% Define months
months = 1:12;
month_labels = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', ...
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};


% Estimated unemployment rates for different groups (approximated from the image)
unemployment_white_men = [bwm(1), bwm(2), bwm(3), bwm(4), bwm(5), bwm(6), bwm(7), bwm(8), bwm(9), bwm(10), bwm(11), bwm(12)];
unemployment_white_women = [bww(1), bww(2), bww(3), bww(4), bww(5), bww(6), bww(7), bww(8), bww(9), bww(10), bww(11), bww(12)];
unemployment_black_men = [bbm(1), bbm(2), bbm(3), bbm(4), bbm(5), bbm(6), bbm(7), bbm(8), bbm(9), bbm(10), bbm(11), bbm(12)];
unemployment_black_women = [bbw(1), bbw(2), bbw(3), bbw(4), bbw(5), bbw(6), bbw(7), bbw(8), bbw(9), bbw(10), bbw(11), bbw(12)];


% Plot the data
figure;
hold on;
plot(months, unemployment_white_men, '-oc', 'LineWidth', 2, 'MarkerFaceColor', 'c'); % Cyan line for White Men
plot(months, unemployment_white_women, '--dr', 'LineWidth', 2, 'MarkerFaceColor', 'r'); % Red dashed line for White Women
plot(months, unemployment_black_men, '-db', 'LineWidth', 2, 'MarkerFaceColor', 'b'); % Blue line for Black Men
plot(months, unemployment_black_women, ':mp', 'LineWidth', 2, 'MarkerFaceColor', 'm'); % Magenta dotted line for Black Women


% Customize the plot
xticks(months);
xticklabels(month_labels);
xlabel('Month');
ylabel('Estimated unemployment rate');
title('Estimated unemployment rate of 4 groups');
legend({'White Men', 'White Women', 'Black Men', 'Black Women'}, 'Location', 'Best');
grid on;
hold off;
