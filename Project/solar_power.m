function power = solar_power(azi_sol, ele_sol, azi_sun, ele_sun, iri_sun, area)

powerfactor = 1;

% Convert azimuth and elevation to Cartesian coordinates
sun_vec = [cosd(ele_sun) * cosd(azi_sun), cosd(ele_sun) * sind(azi_sun), sind(ele_sun)];
panel_vec = [cosd(ele_sol) * cosd(azi_sol), cosd(ele_sol) * sind(azi_sol), sind(ele_sol)];

% Compute dot product
dot_product = sum(sun_vec .* panel_vec);

% Compute the angle (in degrees)
theta_sym = acosd(dot_product);

% Simplify the expression
power = theta_sym * iri_sun * area * powerfactor;
 
% Simplify the expression
power = simplify(power);