%% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = transpose(readmatrix("data\usage.csv"));


% Contour plot objective function
x = linspace(0,360);
y = linspace(0,90);
%z = linspace(1,1);
[X,Y] = meshgrid(x,y);
%Z = meshgrid(z,z);
for j=1:1:length(X)
  for i=1:1:length(Y)   
      F(j,i) = objfun_disc([x(j) y(i) 10], azimuth, elevation, irradiation, usage);
  end
end

figure(1);
contour(x,y,F,"ShowText","on")
xlabel("Azimuth Angle [Degrees]")
ylabel("Elevation Angle [Degrees]")


figure(2);
surf(x,y,F)
xlabel("Azimuth Angle [Degrees]")
ylabel("Elevation Angle [Degrees]")