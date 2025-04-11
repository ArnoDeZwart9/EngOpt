close all
%% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = readmatrix("data\usage.csv");

x0 = [180 45 30]; % Starting location
x = x0; 

x_old = [0 0 0];
d = [0 0 0];
n = 0;
f_old = 0;
f = 2;

while norm(f-f_old) > 1
    x_old = x;
    f_old = f;

    %% Forward difference
    % azimuth is x direction, elevation is y direction
    h = 0.001;
    f = objfun_disc(x, azimuth, elevation, irradiation, usage);
    % Step in x direction
    fxplush = objfun_disc(x+[h 0 0], azimuth, elevation, irradiation, usage);
    dfx = (fxplush - f)/h;
    % Now for the y direction
    
    fyplush = objfun_disc(x+[0 h 0], azimuth, elevation, irradiation, usage);
    dfy = (fyplush - f)/h;
    
    fzplush = objfun_disc(x+[0 0 h], azimuth, elevation, irradiation, usage);
    dfz = (fzplush - f)/h;

    % Direction of step:
    d = -[dfx dfy dfz];
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
    
    while I >= 0.1 % Internal stop length condition
    
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
      
        
    end
    
end


if x(1) > 180
    x(1) = x(1)-180;
end
if x(2) > 90
    x(2) = x(2)-90;
end

fprintf('This is the optimum Azimuth :%4.2f\n',x(1))
fprintf('This is the optimum Elevation :%4.2f\n',x(2))
fprintf('This is the optimum Area :%4.2f\n',x(3))
fprintf('This is the objective value :%4.0f\n',f)



% Contour plot to show optimum objective function
az = 1:4:360;
el = 1:1:90;

for j=1:1:length(el)
  for i=1:1:length(az)
      fplot = objfun_disc([az(i) el(j) x(3)], azimuth, elevation, irradiation, usage);
      funk(j,i) = fplot;
  end
end



figure(1);
contour(az,el,funk,"ShowText","on")
xlabel("Azimuth Angle [Degrees]")
ylabel("Elevation Angle [Degrees]")
hold on
plot(x(1),x(2),'o','markersize',15)


figure(2);
surf(az,el,funk)
xlabel("Azimuth Angle [Degrees]")
ylabel("Elevation Angle [Degrees]")
hold on
plot3(x(1),x(2),f,'.','markersize',15)