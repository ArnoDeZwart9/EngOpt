function f = springobjw3(alpha,xq,sq,ktarget,frtarget,w);
% Two variable valve spring problem - Exercise 3
% Scaled objective function for line search 
% involving both spring stiffness and lowest eigenfrequency. 

% Input:
%  Design variable:
%   alpha    : [1x1] scalar step size variable
%  Fixed parameters (apart from the constant parameters read from sprinp1).
%   xq       : current design point q (xq represents [Dq dq]')
%   sq       : search direction in point q (sq represents [sDq sdq]')
%   Usage:
%       design point x = [D d]' = xq = alpha*sq
%   ktarget  : target value for spring stiffness.
%   frtarget : target value for lowest eigenfrequency.
%   w        : weighing factor between objective function components.

% Output:
%   f  : {1x1] scalar of objective function value, defined as:
%
%   f = abs((k - ktarget)/ktarget) + w*abs((freq1 - frtarget)/frtarget)
%
% Note: the objective function components are scaled around the
%       respective target values.

% Computation of design point:
D = xq(1) + alpha*sq(1);
d = xq(2) + alpha*sq(2);

% Constant parameter values
springparams1;

% Analysis of current valve spring design.
[svol,smass,bvol,matc,manc,Lmin,L2,k,F1,F2,Tau1,Tau2,freq1]=...
        (D,d,L0,L1,n,E,G,rho,Dv,h,p1,p2,nm,ncamfac,nne,matp,bldp);
 
 % Scaled objective function
   f = abs((k - ktarget)/ktarget) + w*abs((freq1 - frtarget)/frtarget);
    
%end 