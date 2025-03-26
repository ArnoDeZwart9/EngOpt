close all
% Plotting
[azimuth, elevation, irradiation, usage] = init_poly();

t_vals = linspace(0, 24, 100);  % Time from 0 to 24 hours

figure;
hold on;
for i = 1:12
    fplot(azimuth(i), [0, 24], 'DisplayName', sprintf('Month %d', i));
end
hold off;
title('Azimuth Angle Over Time');
xlabel('Time (hours)');
ylabel('Azimuth Angle (degrees)');
legend;
grid on;

figure;
hold on;
for i = 1:12
    fplot(elevation(i), [0, 24], 'DisplayName', sprintf('Month %d', i));
end
hold off;
title('Elevation Angle Over Time');
xlabel('Time (hours)');
ylabel('Elevation Angle (degrees)');
legend;
grid on;

figure;
hold on;
for i = 1:12
    fplot(irradiation(i), [0, 24], 'DisplayName', sprintf('Month %d', i));
end
hold off;
title('Irradiation Over Time');
xlabel('Time (hours)');
ylabel('Irradiation (W/m²)');
legend;
grid on;

figure;
hold on;
for i = 1:12
    fplot(usage(i), [0, 24], 'DisplayName', sprintf('Month %d', i));
end
hold off;
title('Usage Over Time');
xlabel('Time (hours)');
ylabel('Usage (W)');
legend;
grid on;