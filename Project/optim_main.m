clear all;

%% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = transpose(readmatrix("data\usage.csv"));

data = [azimuth elevation irradiation usage];

%% run objective 
format('long');

% options = optimoptions('fminsearch', ...
%     'Algorithm','quasi-newton', ...
%     'Display','iter', ...
%     'HessianApproximation','steepdesc', ...
%     'MaxFunctionEvaluations', 2e4);


x0 = [180 45 1];
% x = fminunc(@(x) objfun_disc(x,data), x0, options);
x = fminsearch(@(x) objfun_disc(x,data), x0);



disp(x)
%% plotting
% 
% time = 1:24;
% 
% figure(1); clf(1);
% hold on
% for i = 1:12
%     plot(time, f(time, i))
% end
% legend({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'}, Location="southwest")
