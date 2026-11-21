clear all;
close all;
clc;
global fa f1 f2 f3 a1 a2 a3 t ph1 ph2 ph3 samp
fa = 100000;
f1 = 300;
f2 = 500;
f3 = 1000;
a1 = 1;
a2 = 2;
a3 = 3;
ph1 = rand;
ph2 = rand;
ph3 = rand;
samp = 1500;
t = (0:samp-1)/fa;
%%  Analog Signal Generation
y1 = a1*sin(2*pi*f1*t - ph1);
y2 = a2*sin(2*pi*f2*t - ph2);
y3 = a3*sin(2*pi*f3*t - ph3);
y = y1+y2+y3;
figure
plot(1:samp, y1,'r');
hold on
plot(1:samp, y2, 'b');
plot(1:samp, y3);
title('f1, f2, f3');
xlabel('samples');
ylabel('amplitude');
legend('f1 = 300 Hz', 'f2 = 500 Hz', 'f3 = 1000 Hz');
xlim([0 1500]);
grid on;
hold off;
figure
plot(1:samp, y);
title('f1 + f2 + f3');
xlabel('samples');
ylabel('amplitude');
xlim([0 1500]);
grid on;
%% 2 Analog-to-Digital Conversion
% sampling
f=10;
fs=f*500;
r=fa/fs;
N = length(y);
impulse_train = zeros(size(y));
impulse_train(1:r:end) = 1;
figure
stem(t, impulse_train);
title('impulse train');
xlabel('time');
ylabel('amplitude');
grid on;
y_sampled = y .* impulse_train;
figure
plot(t,y,'b');
hold on
stem(t, y_sampled);
title('Y sampled');
xlabel('time');
ylabel('amplitude');
legend('original signal', 'sampled signal');
grid on;
hold off;
%% 2.2 ZOH to get a piece of constant signal
y_zoh=repelem(y(1:r:end),r);
y_zoh=y_zoh(1:N);
figure
plot(t,y,'b');
hold on
plot(t,y_zoh,'r');
stem(t,y_sampled);
title('zero order hold');
xlabel('time');
ylabel('amplitude');
legend('original','zoh','sampled');
grid on;
hold off;
%% 2.3Quantization
% q= deltaX/((2^Nbits)-1)
deltaX=12;
Nbits=3;
q=deltaX/((2^Nbits)-1);
sq=q*round(y_zoh/q);
error_q=y_zoh-sq;
figure
plot(t,y_zoh,'b');
hold on
stairs(t,sq,'r');
hold on
plot(t,error_q);
title('quantization');
xlabel('time');
ylabel('amplitude');
legend('before quantization','after quantization', 'quantization error');
grid on;
hold off;
%% 2.4 encoding
final_samples=sq(1:r:end);
figure
plot(t,y,'b');
hold on
stem(t(1:r:end),final_samples, 'r');
title('original and final sample');
xlabel('time');
ylabel('amplitude');
legend('original','final');
grid on;
hold off;
%% digital to analog conversion
Nbits=4;
q4=deltaX/((2^Nbits)-1);
samples4=q4*round(y(1:r:end)/q4);
y_zoh=repelem(samples4,r);
y_zoh=y_zoh(1:N);
figure
plot(t, y, 'b');
hold on
stairs(t, y_zoh, 'r');
title('signal after zoh (4 bits)');
xlabel('time');
ylabel('amplitude');
legend('original', 'zoh');
grid on;
hold off;
%% lowpass filter butterworth
[B, A]=butter(5,2*2000/fa);
[hcont,freq]=freqz(B,A,1024,fa);
figure
plot(freq,abs(hcont));
xlim([0 20000])
title('butterworth filter frequency response');
xlabel('frequency');
ylabel('magnitude');
grid on;

