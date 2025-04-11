close all
%% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = readmatrix("data\usage.csv");
A = 20;
x0 = [50 50 A]; % Starting location
x = x0; 

%% Plotting for illustration

az = 1:4:360;
el = 1:1:90;
    
for j=1:1:length(el)
  for i=1:1:length(az)
      f = objfun_disc([az(i) el(j) A], azimuth, elevation, irradiation, usage);
      funk(j,i) = f;
  end
end

figure();
surf(az,el,funk,'FaceAlpha',0.75,EdgeColor='none')
hold on
%figure();
%contour(az,el,funk,10)
xlabel("Azimuth Angle [Degrees]")
ylabel("Elevation Angle [Degrees]")


x_old = [0 0 0];
d = [0 0 0];

n = 0;
while norm(x-x_old) > 1
    
    d_old = d;
    x_old = x;

    %% Forward difference
    % azimuth is x direction, elevation is y direction
    h = 0.01;
    f = objfun_disc(x, azimuth, elevation, irradiation, usage);
    % Step in x direction
    fxplush = objfun_disc(x+[h 0 0], azimuth, elevation, irradiation, usage);
    dfx = (fxplush - f)/h;
    % Now for the y direction
    
    fyplush = objfun_disc(x+[0 h 0], azimuth, elevation, irradiation, usage);
    dfy = (fyplush - f)/h;
    
    % Direction of step:
    d = -[dfx dfy 0];
    d = d/norm(d);
  
  


    %% Line search to next point
    I0 = 100; % Length of first interval
    I = I0; 
    phi = (sqrt(5)-1)/2; % Golden ratio
    i = 0;
    
    f1 = objfun_disc(x, azimuth, elevation, irradiation, usage);
    f2 = objfun_disc(x+I*(1-phi)*d, azimuth, elevation, irradiation, usage); 
    f3 = objfun_disc(x+I*d, azimuth, elevation, irradiation, usage); 
    f4 = objfun_disc(x+I*phi*d, azimuth, elevation, irradiation, usage); 
    
    %plot(x(1), x(2),'.','MarkerSize',20)
    plot3(x(1), x(2),objfun_disc(x, azimuth, elevation, irradiation, usage),'.','MarkerSize',30)
 
    while I >= 0.01 % Internal stop length condition
    
        I = I0*phi^i; % Calculates new interval length for step size
        I_new = I0*phi^(i+1);
    
        if f4 > f2 % If function is larger choose this side of the interval
        %f1 = f1; 
        f4 = f2;
        f3 = f4;
        f2 = objfun_disc(x+I_new*(1-phi)*d, azimuth, elevation, irradiation, usage);
       
        else % if the funtion is lower choose this side of the interval
        x = x + I*(1-phi)*d;
        f1 = f2;
        f2 = f4;
        %f3 = f3
        f4 = objfun_disc(x+I_new*phi*d, azimuth, elevation, irradiation, usage);
        
        end
        i = i+1; % Adjust counter for interval size
        hold on
        %plot(x(1), x(2),'.','MarkerSize',8)
        plot3(x(1), x(2),objfun_disc(x, azimuth, elevation, irradiation, usage),'.','MarkerSize',12)
    
    end
    %plot(x(1), x(2),'.','MarkerSize',20) 
    n = n+1;
end