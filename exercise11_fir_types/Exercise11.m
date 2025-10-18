clc; clear; close all;

% Define impulse responses
h1 = [1 2 3 4 4 3 2 1];     % Type I: symmetric, even length
h2 = [1 2 3 4 3 2 1];       % Type II: symmetric, odd length
h3 = [-1 -2 -3 -4 3 3 2 1]; % Type III: antisymmetric, even length
h4 = [-1 -2 -3 0 3 2 1];    % Type IV: antisymmetric, odd length

filters = {h1, h2, h3, h4};
titles = {'FIR Type I', 'FIR Type II', 'FIR Type III', 'FIR Type IV'};

figure('Name', 'FIR Filter Types Responses', 'NumberTitle', 'off');

for i = 1:4
    h = filters{i};
    [H, w] = freqz(h, 1, 512);

    % Magnitude plot
    subplot(4,3,(i-1)*3+1);
    plot(w/pi, abs(H), 'LineWidth',1.5);
    title([titles{i} ' - Magnitude']);
    xlabel('Normalized Frequency (\omega/\pi)');
    ylabel('|H(\omega)|');
    grid on;

    % Phase plot
    subplot(4,3,(i-1)*3+2);
    plot(w/pi, unwrap(angle(H)), 'LineWidth',1.5);
    title([titles{i} ' - Phase']);
    xlabel('Normalized Frequency (\omega/\pi)');
    ylabel('Phase (radians)');
    grid on;

    % Pole-Zero plot
    subplot(4,3,(i-1)*3+3);
    zplane(h,1);
    title([titles{i} ' - Pole-Zero']);
end