clear all;

%% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = transpose(readmatrix("data\usage.csv"));



%% run objective 
format('long');

Nelder_options = optimset(...
    'Display','iter', ...
    'MaxFunEvals', 2e4);

x0 = [90 30 30];
x_Nelder = fminsearch(@(x) objfun_disc(x,azimuth, elevation, irradiation, usage), x0, Nelder_options);
% x_Anneal = simulannealbnd(@(x) objfun_disc(x,azimuth, elevation, irradiation, usage), x0, Anneal_options)


disp(x_Nelder)
%% laatste keer


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
