clear;

%% load data

azimuth = readmatrix("data\azimuth.csv");
elevation = readmatrix("data\elevation.csv");
irradiation = readmatrix("data\irradiation.csv");
usage = readmatrix("data\usage.csv");


%% run objective 
format('long');
x0 = [180 45 30];
lb = [0 0 0];
ub = [360 90 100];

%% Nelder-Mead simplex 
Nelder_options = optimset(...
    'Display','iter', ...
    'MaxFunEvals', 2e4);

[x_Nelder, f_Nelder] = fminsearch(@(x) objfun_disc(x,azimuth, elevation, irradiation, usage), x0, Nelder_options);

%% Simulated Annealing algorithm.
Anneal_options = optimoptions('simulannealbnd', ...
    'Display','iter', ...
    'MaxFunctionEvaluations', 1e3);

[x_Anneal, f_Anneal] = simulannealbnd(@(x) objfun_disc(x,azimuth, elevation, irradiation, usage), x0, lb, ub, Anneal_options);

%% Genetic algorithm
GA_options = optimoptions("ga", ...
    Display="iter");

A = [];
b = [];
Aeq = [];
beq = [];

[x_GA, f_GA] = ga(@(x) objfun_disc(x,azimuth, elevation, irradiation, usage), 3, A, b, Aeq, beq, lb, ub);

%% Particle Swarm
Swarm_options = optimoptions("particleswarm", ...
    Display="iter");

[x_Swarm, f_Swarm] = particleswarm(@(x) objfun_disc(x,azimuth, elevation, irradiation, usage), 3, lb, ub, Swarm_options);