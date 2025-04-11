function sens = SensCheck(x, d)

% k = 1+d;
x0 = x;
x1 = [x(1)+d x(2) x(3)];
x2 = [x(1) x(2)+d x(3)];
x3 = [x(1) x(2) x(3)+d];

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = readmatrix("data\usage.csv");

f0 = objfun_disc(x0, azimuth, elevation, irradiation, usage);
f1 = objfun_disc(x1, azimuth, elevation, irradiation, usage);
f2 = objfun_disc(x2, azimuth, elevation, irradiation, usage);
f3 = objfun_disc(x3, azimuth, elevation, irradiation, usage);

d1 = (f1-f0)/d;
d2 = (f2-f0)/d;
d3 = (f3-f0)/d;
sens = [d1 d2 d3];