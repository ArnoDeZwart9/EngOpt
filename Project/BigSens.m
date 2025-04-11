load('Optima.mat')

d = 1e-5;

sens_Anneal = SensCheck(x_Anneal, d);
sens_GA = SensCheck(x_GA, d);
sens_Nelder = SensCheck(x_Nelder, d);
sens_Swarm = SensCheck(x_Swarm, d);
%%
clear
x0 = [180 45 30];
d = logspace(0, -15, 50);

for i = 1:length(d)
    sens(i,:) = SensCheck(x0, d(i));
end

figure(1);clf(1);
plot(d, sens(:,1)-sens(15,1), Marker="o")
grid on; hold on; xscale log; xlim([1e-15 1]); ylim([-5 5]);
yline(1, 'k--')
yline(-1, 'k--')
xlabel('step size Azimuth (deg)')
ylabel('Error in df/dAzimuth (%)')

figure(2);clf(2);
plot(d, sens(:,2)-sens(15,2), Marker="o")
grid on; hold on; xscale log; xlim([1e-15 1]); ylim([-5 5]);
yline(1, 'k--')
yline(-1, 'k--')
xlabel('step size Elevation (deg)')
ylabel('Error in df/dElevation (%)')

figure(3);clf(3);
plot(d, sens(:,3)-sens(15,3), Marker="o")
grid on; hold on; xscale log; xlim([1e-15 1]); ylim([-5 5]);
yline(1, 'k--')
yline(-1, 'k--')
xlabel('step size Area (m^2)')
ylabel('Error in df/dArea (%)')