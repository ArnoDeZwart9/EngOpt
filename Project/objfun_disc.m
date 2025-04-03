function f = objfun_disc(x, azimuth, elevation, irradiation, usage)


%% init
azi_panel = x(1); %degrees
ele_panel = x(2); %degrees
area = x(3); %m^2
eff = 0.2; %efficiency

%% load data
% azimuth = readmatrix("data\azimuth.csv");
% elevation = readmatrix("data\elevation.csv");
% irradiation = readmatrix("data\irradiation.csv");
% usage = transpose(readmatrix("data\usage.csv"));
% azimuth = data(1);
% elevation = data(2);
% irradiation = data(3);
% usage = data(4);



%% calculate
% Convert azimuth and elevation to Cartesian coordinates

overshoot_tot = 0;
power = zeros(24,12);
overshoot = zeros(24,12);

panel_vec = [cosd(ele_panel) * cosd(azi_panel), cosd(ele_panel) * sind(azi_panel), sind(ele_panel)];

for i = 1:numel(azimuth)
    sun_vec = [cosd(elevation(i)) * cosd(azimuth(i)), cosd(elevation(i)) * sind(azimuth(i)), sind(elevation(i))];
    angle = acosd(sum(sun_vec .* panel_vec));
    power(i) = max(0, cosd(angle) * irradiation(i) * area * eff);
    overshoot(i) = power(i);%abs(power(i) - usage(i));
    overshoot_tot = overshoot_tot + overshoot(i);
end

f = overshoot_tot;%overshoot_tot;