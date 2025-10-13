%% DIGITAL SIGNAL PROCESSING DEMO
% Analog → Sampling → Quantization → Binary Encoding
% Author: IoT
% Date: <today>

clear; clc; close all;

%% 1. Analog Signal Generation
f = 100;                   % Signal frequency (Hz)
t = 0:0.0001:0.03;         % "Continuous" time (fine step)
x_analog = sin(2*pi*f*t);  % Analog sine wave

figure;
plot(t, x_analog, 'LineWidth', 1.5);
title('Analog Signal (Continuous Sine Wave)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

%% 2. Sampling - Compare different sampling frequencies
Fs_list = [150, 200, 1000];    % Below, at, and above Nyquist
Ts_list = 1 ./ Fs_list;

figure;
for i = 1:length(Fs_list)
    Fs = Fs_list(i);
    Ts = 1/Fs;
    n = 0:Ts:0.03;
    x_sampled = sin(2*pi*f*n);

    subplot(length(Fs_list),1,i);
    stem(n, x_sampled, 'filled');
    hold on;
    plot(t, x_analog, 'r--');
    title(['Sampling Frequency = ' num2str(Fs) ' Hz']);
    xlabel('Time (s)'); ylabel('Amplitude');
    legend('Sampled','Original');
    grid on;
end

sgtitle('Comparison of Sampling Frequencies (Nyquist Theorem)');

%% 3. Quantization - Compare different bit depths
Fs = 1000;                       % Fix good sampling rate
Ts = 1/Fs;
n = 0:Ts:0.03;
x_sampled = sin(2*pi*f*n);

bits_list = [3, 6, 8];           % Quantization levels
x_min = min(x_sampled);
x_max = max(x_sampled);

figure;
for i = 1:length(bits_list)
    bits = bits_list(i);
    levels = 2^bits;
    q_step = (x_max - x_min) / levels;

    x_index = round((x_sampled - x_min) / q_step);
    x_quantized = x_index * q_step + x_min;

    subplot(length(bits_list),1,i);
    stem(n, x_quantized, 'filled');
    hold on;
    plot(n, x_sampled, 'r--');
    title([num2str(bits) '-bit Quantization (' num2str(levels) ' Levels)']);
    xlabel('Time (s)'); ylabel('Amplitude');
    legend('Quantized','Sampled');
    grid on;
end

sgtitle('Comparison of Quantization Bit Depths');

%% 4. Encoding Example (Binary)
bits = 4;
levels = 2^bits;
q_step = (x_max - x_min) / levels;
x_index = round((x_sampled - x_min) / q_step);
binary_codes = dec2bin(x_index, bits);

disp('--- First 10 Encoded Samples (4-bit) ---');
disp(binary_codes(1:10,:));

%% 5. Bitstream Generation
bitstream = reshape(binary_codes.',1,[]);
disp('--- First 40 Bits of Bitstream ---');
disp(bitstream(1:40));

%% 6. Summary
fprintf('\nSimulation complete!\n');
fprintf('Analog → Sampling → Quantization → Binary Encoding → Bitstream\n');
fprintf('Total samples: %d\n', length(x_sampled));
fprintf('Bits per sample: %d\n', bits);
fprintf('Total bits: %d\n', length(bitstream));
