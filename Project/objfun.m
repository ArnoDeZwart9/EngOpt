function f = objfun(x)
%% init
azi_sol = x(1);
ele_sol = x(2);
area = 1; %m^2
[azimuth, elevation, irradiation, usage] = init_poly();

%% rest

% power calculation

for i = 1:12
    power(i) = solar_power(azi_sol, ele_sol, azimuth(i), elevation(i), irradiation(i), area);
end

f = power;
% least squares






