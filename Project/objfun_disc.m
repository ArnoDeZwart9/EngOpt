function f = objfun_disc(x, data)


%% init
azi_sol = x(1); %degrees
ele_sol = x(2); %degrees
area = x(3); %m^2
eff = 0.1; %efficiency

%% load data
% azimuth = readmatrix("data\azimuth.csv");
% elevation = readmatrix("data\elevation.csv");
% irradiation = readmatrix("data\irradiation.csv");
% usage = transpose(readmatrix("data\usage.csv"));
azimuth = data(1);
elevation = data(2);
irradiation = data(3);
usage = data(4);

%% calculate
% Convert azimuth and elevation to Cartesian coordinates

overshoot_tot = 0;
power = zeros(24,12);
overshoot = zeros(24,12);

panel_vec = [cosd(ele_sol) * cosd(azi_sol), cosd(ele_sol) * sind(azi_sol), sind(ele_sol)];

for i = 1:numel(azimuth)
    sun_vec = [cosd(elevation(i)) * cosd(azimuth(i)), cosd(elevation(i)) * sind(azimuth(i)), sind(elevation(i))];
    angle = acosd(sum(sun_vec .* panel_vec));
    power(i) = max(0, cosd(angle) * irradiation(i) * area * eff);
    overshoot(i) = power(i) - usage(i);
    overshoot_tot = overshoot_tot + overshoot(i);
end

f = overshoot_tot;%overshoot_tot;