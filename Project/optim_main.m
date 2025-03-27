clear all;

%% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = transpose(readmatrix("data\usage.csv"));

data = [azimuth elevation irradiation usage];


%% run objective 
x = [180 45 1];
f = objfun_disc(x, data);

disp(f)
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
