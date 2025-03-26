clear all;

f = objfun([180 45 10]);

%% plotting

time = 1:24;

figure(1); clf(1);
hold on
for i = 1:12
    plot(time, double(subs(f(i), time)))
end
legend({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'}, Location="southwest")
