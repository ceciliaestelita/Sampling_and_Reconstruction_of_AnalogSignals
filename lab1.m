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
plot(1:samp, y1, 'r');
hold on
plot(1:samp, y2, 'g');
plot(1:samp, y3, 'b');

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


%% Analog-to-Digital Conversion
f = 10;
fs = f*10;

N = length(y);
t = linspace(0, 1, N);

% 1. sampling the analog signal with an impulse train,
impulse_train = zeros(size(y));
step = round(N/(fs/f));
impulse_train(1:step:end) = 1;

figure
stem(t, impulse_train);
title('impulse train');
xlabel('time');
grid on;

y_sampled = y .* impulse_train;

figure
stem(t, y_sampled);
title('Y sampled');
xlabel('time');
ylabel('amplitude');
grid on;

% 2. applying a zero-order hold (ZOH) to obtain a piecewise constant signal
dt = 0.01;
t_piecewise = dt:0:max(t);

figure
stem(t,t_piecewise);
   
    
