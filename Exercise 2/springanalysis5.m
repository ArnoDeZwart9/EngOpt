% Two variable valve spring problem - Exercise 2.1
% Visualization of spring stiffness

% Initialization
clf, hold off, clear

% Assignment of constant design parameter values
springparams1;

% Matrix of output values for combinations of design variables D and d 
D = [0.020:0.001:0.040];
d = [0.002:0.0002:0.005];
for j=1:1:length(d)
  for i=1:1:length(D)
%   Analysis of valve spring.
    [svol,smass,bvol,matc,manc,Lmin,L2,k,F1,F2,Tau1,Tau2,freq1]=...
    springanalysis1(D(i),d(j),L0,L1,n,E,G,rho,Dv,h,p1,p2,nm,ncamfac,nne,matp,bldp);
    funk(j,i) = Tau2;    
  end
end

% Contour plot of spring stiffness k
subplot(221)
contour(D, d, funk, [0.5e8 1e8 1.5e8 2e8 3e8 4e8 5e8 6e8 7e8 8e8 9e8], ShowText="on")
xlabel('D (m)'), ylabel('d (m)'), title('      Contours of shear stress (N/m^2)')
grid

% Plot of spring stiffness for constant d(1) = 0.002 
subplot(222)
plot(D, funk(1,:))
xlabel('D (m)'), ylabel('Shear stress (N/m^2)'), ...
   title('Wire diameter 0.002(m)') 
grid

%Plot of spring stiffness for constant D(1) = 0.02(m) 
subplot(223)
plot(d, funk(:,1))
xlabel('d (m)'), ylabel('Shear stress (N/m^2)'), ...
   title('Coil diameter 0.02 (m)') 
grid

%Plot of spring stiffness for constant D(21) = 0.04(m) 
subplot(224)
plot(d, funk(:,21))
xlabel('d (m)'), ylabel('Spring mass (Kg)'), ...
   title('Coil diameter 0.04 (m)') 
grid

%end