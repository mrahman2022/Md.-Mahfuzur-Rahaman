
%% Analog to Digital Signal Simulation
% Compare Sampling Frequencies and Quantization Levels
clear; clc; close all;

%% 1. Generate Analog Signal
f = 100;                     % Signal frequency (Hz)
t = 0:0.0001:0.03;           % Continuous-like time
x_analog = sin(2*pi*f*t);    % Analog signal

figure;
plot(t, x_analog, 'LineWidth', 1.5);
title('Analog Signal (Continuous)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

%% 2. Sampling (Below, At, and Above Nyquist)
Fs_list = [150, 200, 1000];  % Below, At, Above Nyquist (2*f = 200 Hz)

figure;
for i = 1:length(Fs_list)
    Fs = Fs_list(i);
    Ts = 1/Fs;
    n = 0:Ts:0.03;
    x_s = sin(2*pi*f*n);
    
    subplot(3,1,i);
    stem(n, x_s, 'filled');
    hold on; plot(t, x_analog, 'r--');
    title(['Sampling at Fs = ' num2str(Fs) ' Hz']);
    xlabel('Time (s)'); ylabel('Amplitude');
    legend('Sampled','Analog');
    grid on;
end
sgtitle('Sampling Comparison (Below / At / Above Nyquist)');

%% 3. Quantization (8, 16, 64 Levels)
Fs = 1000;                   % Use high sampling frequency
Ts = 1/Fs;
n = 0:Ts:0.03;
x_s = sin(2*pi*f*n);         % Sampled signal

levels_list = [8, 16, 64];   % Quantization levels

figure;
for i = 1:length(levels_list)
    L = levels_list(i);
    q_step = 2 / L;                        % Step size for normalized range (-1 to 1)
    x_q = round(x_s / q_step) * q_step;    % Quantization
    
    subplot(3,1,i);
    stem(n, x_q, 'filled');
    hold on; plot(n, x_s, 'r--');
    title([num2str(L) ' Levels Quantization']);
    xlabel('Time (s)'); ylabel('Amplitude');
    legend('Quantized','Sampled');
    grid on;
end
sgtitle('Quantization Comparison (8 / 16 / 64 Levels)');

%% 4. Summary
fprintf('\nSimulation Complete!\n');
fprintf('Sampling Frequencies Tested: %s Hz\n', num2str(Fs_list));
fprintf('Quantization Levels Tested: %s\n', num2str(levels_list));
fprintf('Observe: Below Nyquist -> Distortion (Aliasing)\n');
fprintf('          More Levels -> Better Signal Quality\n');
