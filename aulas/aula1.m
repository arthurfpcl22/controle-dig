%Amostragem e Reconstrucao de sinais
%% Especificacoes no tempo 
Fs = 10000;                    % Amostras por Segundo (No sinal original, muitas)
dt = 1/Fs;                     % Segundos por amostra
StopTime = 2;                  % Segundos
t = (0:dt:StopTime-dt)';
N = size(t,1);

%% Sinal de frequencia maxima Fc
Fc = 40;
x = 2*cos(2*pi*20*t)+8*cos(2*pi*Fc*t)+4*cos(2*pi*5*t)+8*cos(2*pi*10);
subplot(6, 1, 1);
plot(t, x);
xlabel('t(s)')
ylabel('x(t)')

%% Na frequencia, o sinal original
X = fftshift(fft(x));
dF = Fs/N;
f = -Fs/2:dF:Fs/2-dF;
subplot(6, 1, 2);
plot(f, X);
ylabel('|X(f)|');
xlabel('f');

%% Sinal amostrado
y = zeros(N,1);
Fa = 200; %frequencia de amostragem
Ta = 1/Fa; %periodo de amostragem
for i = 1:fix(Ta/dt):N
    y(i) = x(i);
end
subplot(6, 1, 3);
plot(t, y);
xlabel('t(s)')
ylabel('y(t)')

%% Na frequencia, o sinal amostrado
Y = fftshift(fft(y)); %deslocamento da fft para que o primeiro elemento va para o meio do array
subplot(6, 1, 4);
plot(f, Y);
ylabel('|Y(f)|');
xlabel('f');

%% Reconstrucao do sinal
Fc = 50; %Frequencia de Corte
Z = zeros(N, 1);
for i = (N/2-Fc/dF):1:(N/2+Fc/dF)
   Z(i) = Y(i);
end
subplot(6, 1, 5);
plot(f, Z);
ylabel('|Z(f)|');
xlabel('f');

%% Sinal reconstruido no tempo
z = ifft(circshift(Z, N/2)); %Inversa do sinal Z na Frequencia deslocado de volta
subplot(6, 1, 6); 
plot(t, z);
xlabel('t(s)')
ylabel('z(t)')
