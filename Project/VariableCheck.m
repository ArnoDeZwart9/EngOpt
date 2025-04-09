clear all;

% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = transpose(readmatrix("data\usage.csv"));


%% aziiiii
az = 1:4:360;
% el = 0:1:90;
% ar = 1:1:100;

% az = 180;
el = 45;
ar = 30;

for i=1:1:length(az)
  f = objfun_disc([az(i) el ar], azimuth, elevation, irradiation, usage);
  funk1(i) = f;
end


figure(1); clf(1);
plot(az, funk1, LineWidth=2);
xlim([az(1) az(end)])
grid on
hold on
% plot([az(1), az(end)], [funk(1), funk(end)], '--r', 'LineWidth', 1.5);

xlabel('Azimuth (deg)')
ylabel('Total power difference (W)')

%% azz sensitivity
fink1 = [];
for i=1:1:length(az)
    if i == length(az)
        fink1(i) = fink1(i-1);
    else
        fink1(i) = funk1(i+1) - funk1(i);
    end
end


figure(4); clf(4);
plot(az, fink1, LineWidth=2);
xlim([az(1) az(end)])
grid on

xlabel('Azimuth (deg)')
ylabel('Sensitivity')


%% elllleeee
% az = 1:4:360;
el = 0:1:360;
% ar = 1:1:100;

az = 180;
% el = 45;
ar = 30;

for i=1:1:length(el)
  f = objfun_disc([az el(i) ar], azimuth, elevation, irradiation, usage);
  funk2(i) = f;
end


figure(2); clf(2);
plot(el, funk2, LineWidth=2);
xlim([el(1) el(end)])
grid on
hold on
% plot([el(1), el(end)], [funk(1), funk(end)], '--r', 'LineWidth', 1.5);

xlabel('Elevation (deg)')
ylabel('Total power difference (W)')

%% ele sensitivity
fink2 = [];
for i=1:1:length(el)
    if i == length(el)
        fink2(i) = fink2(i-1);
    else
        fink2(i) = funk2(i+1) - funk2(i);
    end
end


figure(5); clf(5);
plot(el, fink2, LineWidth=2);
xlim([el(1) el(end)])
grid on

xlabel('Elevation (deg)')
ylabel('Sensitivity')

%% area
% az = 1:4:360;
% el = 0:1:90;
ar = 1:1:100;

az = 180;
el = 45;
% ar = 30;

for i=1:1:length(ar)
  f = objfun_disc([az el ar(i)], azimuth, elevation, irradiation, usage);
  funk3(i) = f;
end


figure(3); clf(3);
plot(ar, funk3, LineWidth=2);
xlim([ar(1) ar(end)])
grid on
hold on
% plot([ar(1), ar(end)], [funk(1), funk(end)], '--r', 'LineWidth', 1.5);

xlabel('Area (m^2)')
ylabel('Total power difference (W)')

%% ele sensitivity
fink3 = [];
for i=1:1:length(ar)
    if i == length(ar)
        fink3(i) = fink3(i-1);
    else
        fink3(i) = funk3(i+1) - funk3(i);
    end
end


figure(6); clf(6);
plot(ar, fink3, LineWidth=2);
xlim([ar(1) ar(end)])
grid on

xlabel('Area (m^2)')
ylabel('Sensitivity')

%% Alle info jwz

az = 1:1:360;
el = 0:1:90;
ar = 1:1:100;

tot = length(az) * length(el) * length(ar);
nu = 0;

F = zeros(length(az),length(el),length(ar));

for i = 1:1:length(az)
    for j = 1:1:length(el)
        for k = 1:1:length(ar)
            F(i,j,k) = objfun_disc([az(i) el(j) ar(k)], azimuth, elevation, irradiation, usage);
            nu = nu + 1
        end
    end
end
