% Valve spring design  - Exercise 5.1

% Computation of gradients of objective function and constraint g1.


% Initialization
clf, hold off, clear

% Note: Constant parameter values are read within the functions sprobj1 and sprcon1

% Design point for which gradients are computed 
x = [0.024 0.004];  

% Forward finite diffence gradients of objective function and constraints
hx = logspace(-20,0,100); % vector of finite difference steps
for i=1:1:length(hx)

  % Finite diffence step
  hxi = hx(i);

  % Objective function
  fx = springobj1(x);
  fx1plush = springobj1([x(1)+hxi, x(2)]);
  fx2plush = springobj1([x(1), x(2)+hxi]);
  dfdx1(i) = (fx1plush - fx)/hxi;
  dfdx2(i) = (fx2plush - fx)/hxi;

  % Constraints 
  gx = springcon1(x);
  gx1plush = springcon1([x(1)+hxi, x(2)]);
  gx2plush = springcon1([x(1), x(2)+hxi]);
  dgdx1(i,:) = (gx1plush - gx)./hxi;
  dgdx2(i,:) = (gx2plush - gx)./hxi;

end

% Plotting finite difference gradients
subplot(241)
semilogx(hx,dfdx1)
xlabel('Difference step hx'), ylabel('df/dx1'), title('Spring mass')

subplot(242)
semilogx(hx,dfdx2)
xlabel('Difference step hx'), ylabel('df/dx2'), title('Spring mass')

%dfa
subplot(243)
semilogx(hx,dgdx1(:,1)')
xlabel('Difference step hx'), ylabel('dg1/dx1'), title('Length constraint') 

subplot(244)
semilogx(hx,dgdx2(:,1)')
xlabel('Difference step hx'), ylabel('dg1/dx2'), title('Length constraint') 

%fwad
subplot(245)
semilogx(hx,dgdx1(:,4)')
xlabel('Difference step hx'), ylabel('dg4/dx1'), title('Shear stress constraint') 

subplot(246)
semilogx(hx,dgdx2(:,4)')
xlabel('Difference step hx'), ylabel('dg4/dx2'), title('Shear stress constraint') 

%dfa
subplot(247)
semilogx(hx,dgdx1(:,5)')
xlabel('Difference step hx'), ylabel('dg5/dx1'), title('Frequency constraint') 

subplot(248)
semilogx(hx,dgdx2(:,5)')
xlabel('Difference step hx'), ylabel('dg5/dx2'), title('Frequency constraint') 



