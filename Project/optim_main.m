clear all;

f = objfun_disc([180 45 1]);







%% plotting

time = 1:24;

figure(1); clf(1);
hold on
for i = 1:12
    plot(time, f(time, i))
end
legend({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'}, Location="southwest")
