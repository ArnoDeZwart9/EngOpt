clear all;

%% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = transpose(readmatrix("data\usage.csv"));


% Contour plot objective function
az = 1:4:360;
el = 1:1:90;

for j=1:1:length(el)
  for i=1:1:length(az)
      f = objfun_disc([az(i) el(j) 36.7], azimuth, elevation, irradiation, usage);
      funk(j,i) = f;
  end
end


figure(1);
contour(az,el,funk,"ShowText","on")
xlabel("Azimuth Angle [Degrees]")
ylabel("Elevation Angle [Degrees]")


figure(2);
surf(az,el,funk)
xlabel("Azimuth Angle [Degrees]")
ylabel("Elevation Angle [Degrees]")