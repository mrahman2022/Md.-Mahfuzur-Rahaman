%% ex12_main.m
% FIR Low-Pass Filter Design and Analysis
% Author: Your Name
% Date: YYYY-MM-DD

clear; clc; close all;

%% Parameters
wc = 1;                  % Cutoff frequency in radians
Ms = [20, 64];           % Filter orders to test
NFFT = 1024;             % Number of FFT points
figureFolder = 'figures';

if ~exist(figureFolder, 'dir')
    mkdir(figureFolder);
end

%% Loop through filter orders
H_all = zeros(length(Ms), NFFT); % Store frequency responses
w = linspace(-pi, pi, NFFT);     % Frequency axis

for idx = 1:length(Ms)
    M = Ms(idx);
    n = 0:M;
    
    % FIR low-pass impulse response
    h_LP = sin(wc*(n - M/2)) ./ (pi*(n - M/2));
    h_LP(n == M/2) = wc/pi;  % Handle divide-by-zero
    
    % Plot impulse response
    figure;
    stem(n, h_LP, 'filled'); grid on;
    title(sprintf('Impulse Response h_{LP}(n), M = %d', M));
    xlabel('n'); ylabel('h_{LP}(n)');
    saveas(gcf, fullfile(figureFolder, sprintf('hLP_M%d.png', M)));
    
    % Compute frequency response
    H_LP = fft(h_LP, NFFT);
    H_all(idx,:) = abs(fftshift(H_LP)); % Save magnitude for comparison
    
    % Plot magnitude response
    figure;
    plot(w/pi, abs(fftshift(H_LP)), 'LineWidth', 1.2); grid on;
    title(sprintf('Magnitude Response |H_{LP}(e^{jω})|, M = %d', M));
    xlabel('ω/π'); ylabel('|H_{LP}|');
    saveas(gcf, fullfile(figureFolder, sprintf('HLP_M%d.png', M)));
end

%% Compare magnitude responses for different M
figure;
plot(w/pi, H_all(1,:), 'LineWidth', 1.2); hold on;
plot(w/pi, H_all(2,:), 'LineWidth', 1.2);
grid on; legend(sprintf('M = %d', Ms(1)), sprintf('M = %d', Ms(2)));
title('Comparison of Magnitude Responses |H_{LP}(e^{jω})|');
xlabel('ω/π'); ylabel('|H_{LP}|');
saveas(gcf, fullfile(figureFolder, 'HLP_compare.png'));
