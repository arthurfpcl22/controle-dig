%% Discretizacao de sistemas - Metodo aproximado
A = [-1 -4; 2 0];
B = [0.5; 0];
C = [0 1]; 
D = 0;

dT = 0.4;
stopTime = 4;
t = (0: dT: stopTime);
N = size(t', 1);
x = zeros(2, N);
u = ones(1, N); 
y = zeros(1, N);
%% Calculo da saida
for i = 2:N
    x(:,i) = x(:,i-1) + (A*x(:,i-1) + B*u(i-1))*dT;
    y(i) = C*x(:,i) + D*u(i);
end
subplot(2, 1, 1);
stem(t, y);

%% Metodo correto
%Podemos obter o sistema discreto equivalente da seguinte forma
sysC = ss(A, B, C, D);
sysD = c2d(sysC, dT);
phi = sysD.A;
gama = sysD.B;  

%% Calculo da saida
for i = 2:N
    x(:,i) = phi*x(:,i-1) + gama*u(i-1);
    y(i) = C*x(:,i) + D*u(i);
end+
subplot(2, 1, 2);
stem(t, y);