clear all;

% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = readmatrix("data\usage.csv");

d = 1e-3;

%% aziiiii
az = 1:d:360;
% el = 0:1:90;
% ar = 1:1:100;

% az = 146;
el = 23;
ar = 21;

for i=1:1:length(az)
  f = objfun_disc([az(i) el ar], azimuth, elevation, irradiation, usage);
  funk1(i) = f;
end


figure(1); clf(1);
plot(az, funk1, LineWidth=2);
xlim([az(1) az(end)])
grid on
hold on
% plot([az(1), az(end)], [funk1(1), funk1(end)], '--r', 'LineWidth', 1.5);

xlabel('Azimuth (deg)')
ylabel('Total power difference (W)')

%% azz sensitivity
fink1 = [];
for i=1:1:length(az)
    if i == length(az)
        fink1(i) = fink1(i-1);
    else
        fink1(i) = (funk1(i+1) - funk1(i))/d;
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
el =  0:d:90;
% ar = 1:1:100;

az = 146;
% el = 23;
ar = 21;

for i=1:1:length(el)
  f = objfun_disc([az el(i) ar], azimuth, elevation, irradiation, usage);
  funk2(i) = f;
end


figure(2); clf(2);
plot(el, funk2, LineWidth=2);
xlim([el(1) el(end)])
grid on
hold on
% plot([el(1), el(end)], [funk2(1), funk2(end)], '--r', 'LineWidth', 1.5);

xlabel('Elevation (deg)')
ylabel('Total power difference (W)')

%% ele sensitivity
fink2 = [];
for i=1:1:length(el)
    if i == length(el)
        fink2(i) = fink2(i-1);
    else
        fink2(i) = (funk2(i+1) - funk2(i))/d;
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
ar = 0:d:100;



az = 146;
el = 23;
% ar = 21;

for i=1:1:length(ar)
  f = objfun_disc([az el ar(i)], azimuth, elevation, irradiation, usage);
  funk3(i) = f;
end


figure(3); clf(3);
plot(ar, funk3, LineWidth=2);
xlim([ar(1) ar(end)])
grid on
hold on
% plot([ar(1), ar(end)], [funk3(1), funk3(end)], '--r', 'LineWidth', 1.5);

xlabel('Area (m^2)')
ylabel('Total power difference (W)')

%% ele sensitivity
fink3 = [];
for i=1:1:length(ar)
    if i == length(ar)
        fink3(i) = fink3(i-1);
    else
        fink3(i) = (funk3(i+1) - funk3(i))/d;
    end
end


figure(6); clf(6);
plot(ar, fink3, LineWidth=2);
xlim([ar(1) ar(end)])
grid on

xlabel('Area (m^2)')
ylabel('Sensitivity')


