usage = readmatrix("data\usage.csv");
new_usage = usage .* 0.4;
csvwrite("data\usage.csv", new_usage);