%% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = transpose(readmatrix("data\usage.csv"));


I0 = 100; % Length of first interval
I = I0; 
x0 = [50 180 10]; % Starting location
x = x0; 
phi = (sqrt(5)-1)/2; % Golden ratio
i = 0;

f1 = objfun_disc(x, azimuth, elevation, irradiation, usage);
f2 = objfun_disc(x+[I*(1-phi) 0 0], azimuth, elevation, irradiation, usage); 
f3 = objfun_disc(x+[I 0 0], azimuth, elevation, irradiation, usage); 
f4 = objfun_disc(x+[I*phi 0 0], azimuth, elevation, irradiation, usage); 

plot(x(1),objfun_disc(x, azimuth, elevation, irradiation, usage),'o','MarkerSize',12) % Plot for visualization
hold on
while I >= 0.01 % Internal stop length condition

    plot(x(1),objfun_disc(x, azimuth, elevation, irradiation, usage),'.','MarkerSize',9) % Plot for visualization
    I = I0*phi^i; % Calculates new interval length for step size

    if f4 > f2 % If function is larger choose this side of the interval
    %f1 = f1; 
    f3 = f4;
    f4 = f2;
    f2 = objfun_disc(x+[I*(1-phi) 0 0], azimuth, elevation, irradiation, usage);
   
    else % if the funtion is lower choose this side of the interval
    x = x + [I*(1-phi) 0 0];
    f1 = f2;
    f2 = f4;
    %f3 = f3
    f4 = objfun_disc(x+[I*phi 0 0], azimuth, elevation, irradiation, usage);
    
    end
    i = i+1; % Adjust counter for interval size
    hold on

 end
plot(x(1),objfun_disc(x, azimuth, elevation, irradiation, usage),'o','MarkerSize',12) % Plot for visualization

X = linspace(0, 360, 1000);
Y = arrayfun(@(x) objfun_disc([x, x0(2), x0(3)], azimuth, elevation, irradiation, usage), X); % Apply function element-wise
hold on
plot(X, Y) % Plot the results
hold off