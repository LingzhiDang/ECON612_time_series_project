clear all
clc
cd('C:\Users\dangl\Desktop\ECON 612\PS2');
gdp=readtable("realgdpgrowth.xlsx"); 

%1a
row_q3 = strcmp(gdp.time, '2024q3'); % Logical index for 2024Q3
%row_q2 = strcmp(gdp.time, '2024q2'); % Logical index for 2024Q2

pce_q3 = gdp.pce_nondurables(row_q3); % PCE value for 2024Q3
%pce_q2 = gdp.pce_nondurables(row_q2); % PCE value for 2024Q2

%1b
pce_mean = mean(gdp.pce_nondurables);

%1c
pce_std = std(gdp.pce_nondurables);
n95_quantile = pce_mean + pce_std*1.645;
n5_quantile = pce_mean - pce_std*1.645;

%1d
pce_quantile = quantile(gdp.pce_nondurables, [0.05,0.95]);
%or
lower_bound_pce = quantile(gdp.pce_nondurables, 0.05); % 5th percentile
upper_bound_pce = quantile(gdp.pce_nondurables, 0.95); % 95th percentile


%2a
row2_q3 = strcmp(gdp.time, '2024q3');
pd_q3 = gdp.pce_durables(row2_q3);

%2b
pd_mean = mean(gdp.pce_durables);

%2c
pd_std = std(gdp.pce_durables);
n95_pd_n = pd_mean + pd_std*1.645;
n5_pd_n = pd_mean - pd_std*1.645;

%2d
pd_quantile = quantile(gdp.pce_durables, [0.05,0.95]);
%or
lower_bound_pd = quantile(gdp.pce_durables, 0.05); % 5th percentile
upper_bound_pd = quantile(gdp.pce_durables, 0.95); % 95th percentile


%5
% Define the range of y from 0 to 1
y = linspace(0, 1, 100); 

% Define the CDF and PDF
F_y = y.^2;        % CDF: F(y) = y^2
f_y = 2 * y;       % PDF: f(y) = 2y

% Plot the CDF
figure;
subplot(2,1,1); % Create a subplot for the CDF
plot(y, F_y, 'b', 'LineWidth', 2); % Plot the CDF in blue
title('CDF: F(y) = y^2'); % Title
xlabel('y'); % x-axis label
ylabel('F(y)'); % y-axis label
grid on; % Add grid

% Plot the PDF
subplot(2,1,2); % Create a subplot for the PDF
plot(y, f_y, 'r', 'LineWidth', 2); % Plot the PDF in red
title('PDF: f(y) = 2y'); % Title
xlabel('y'); % x-axis label
ylabel('f(y)'); % y-axis label
grid on; % Add grid


%6
% Define the range of x for the uniform distribution
x = linspace(0, 1, 100); % 100 points between 0 and 1

% PDF of the uniform distribution
pdf = ones(size(x)); % f(x) = 1 for uniform distribution on [0, 1]

% CDF of the uniform distribution
cdf = x; % F(x) = x for uniform distribution on [0, 1]

% Plot the PDF
figure;
subplot(2,1,1); % Create the first subplot
plot(x, pdf, 'b', 'LineWidth', 2); % Plot the PDF in blue
title('PDF of Uniform Distribution (U[0,1])'); % Title
xlabel('x'); % x-axis label
ylabel('f(x)'); % y-axis label
ylim([0 1.2]); % Adjust y-axis limits for better visualization
grid on; % Add grid

% Plot the CDF
subplot(2,1,2); % Create the second subplot
plot(x, cdf, 'r', 'LineWidth', 2); % Plot the CDF in red
title('CDF of Uniform Distribution (U[0,1])'); % Title
xlabel('x'); % x-axis label
ylabel('F(x)'); % y-axis label
grid on; % Add grid

