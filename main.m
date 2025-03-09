close all; clear; clc

% URA 8x8
Mx = 8;
My = 8;

freq = 3e9;                     % 3 GHz
lambda = (3e8) / freq;          % wavelength
delta = lambda/2;               % antenna spacing
snapshots = 200;                % number of samples
power = 0.1;                    % transmission power (w)
noisepowerdBm = -90;            % noise power in dBm
azimuth = [20, -30, 40];        % azimuth angles (degrees)
elevation = [50, 20, 15];       % elevation angles (degrees)
d = [500, 200, 120];            % distance
alpha = 2;                      % path loss expoent
source = length(azimuth);       % number of sources
theta_range = -90:1:90;         % grid theta
phi_range = 0:1:90;             % grid phi

set(groot,'defaultAxesTickLabelInterpreter','latex');

figure;
hold on; box on;
Y = signals(Mx, My, snapshots, delta, lambda, elevation, azimuth, d, ...
    source, power, noisepowerdBm, alpha);
Pmusic = music(Y, Mx, My, theta_range, phi_range, snapshots, delta, lambda, source);

surf(theta_range, phi_range, 10 * log10(Pmusic.'), 'EdgeColor', 'none');
colormap parula;

xlabel('Azimuth (degrees)','FontSize', 12);
ylabel('Elevation (degrees)','FontSize', 12);
set(gca,'fontsize',14);
shading interp;
view(0,90);
axis tight;
colorbar;

hold off;
