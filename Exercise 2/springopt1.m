% Two variable valve spring problem - Exercise 2.1
% Visualization of spring stiffness

% Initialization
clf, hold off, clear

% Assignment of constant design parameter values
springparams1;
Tau12max = 600e6; %N/m^2
freq1lb = 5000 / 60; %Hz

% Matrix of output values for combinations of design variables D and d 
D = [0.020:0.001:0.040];
d = [0.002:0.0002:0.005];

D = [0.01:0.001:0.1];
d = [0.001:0.0002:0.01];

for j=1:1:length(d)
  for i=1:1:length(D)
%   Analysis of valve spring.
    [svol,smass,bvol,matc,manc,Lmin,L2,k,F1,F2,Tau1,Tau2,freq1,F1min,F2min]=...
    springanalysis1(D(i),d(j),L0,L1,n,E,G,rho,Dv,h,p1,p2,nm,ncamfac,nne,matp,bldp);
    funk(j,i) = smass;    
    g1(j,i) = Lmin / L2 - 1;
    g2(j,i) = F1min / F1 - 1;
    g3(j,i) = F2min / F2 - 1;
    g4(j,i) = Tau12max / Tau2 - 1;
    g5(j,i) = freq1lb / freq1 - 1;
    g6(j,i) = D(i) / 0.04 - 1;
    g7(j,i) = 1 - D(i) / 0.02;
    g8(j,i) = d(j) / 0.005 - 1;
    g9(j,i) = 1 - d(j) / 0.002;
    
  end
end

% Contour plot of spring stiffness k
plot(2)
hold on;
contour(D, d, funk, [0.012 0.02 0.03 0.045 0.07 0.1], ShowText="on")

%g1
contour(D, d, g1, [0.0 0.0], 'r')
contour(D, d, g1, [0.01 0.01], 'r--')

%g2
contour(D, d, g2, [0.0 0.0], 'y')
contour(D, d, g2, [0.01 0.01], 'y--')

%g3
contour(D, d, g3, [0.0 0.0], 'b')
contour(D, d, g3, [0.01 0.01], 'b--')

%g4
contour(D, d, g4, [0.0 0.0], 'g')
contour(D, d, g4, [0.01 0.01], 'g--')

%g5
contour(D, d, g5, [0.0 0.0], 'c')
contour(D, d, g5, [0.01 0.01], 'c--')

%g6
contour(D, d, g6, [0.0 0.0], 'k')
contour(D, d, g6, [0.01 0.01], 'k--')

%g7
contour(D, d, g7, [0.0 0.0], 'k')
contour(D, d, g7, [0.01 0.01], 'k--')

%g8
contour(D, d, g8, [0.0 0.0], 'k')
contour(D, d, g8, [0.01 0.01], 'k--')

%g9
contour(D, d, g9, [0.0 0.0], 'k')
contour(D, d, g9, [0.01 0.01], 'k--')



xlabel('D (m)'), ylabel('d (m)'), title('      Contours of spring mass (kg)')
xlim([0.02, 0.04])
ylim([0.002, 0.005])
legend('', 'ObjFnc' ,'g1', 'g1 oob', 'g2', 'g2 oob', 'g3', 'g3 oob', 'g4', 'g4 oob', 'g5', 'g5 oob', 'g6-9', 'g6-9 oob');
grid


%end