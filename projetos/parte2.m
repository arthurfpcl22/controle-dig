%% Planta estavel - Valor em Regime e análise do transitorio 
% Para essa planta, podemos obter a transformada Z rapidamente fazendo
sysC1 = tf(1, [1 3 2]);
dt = 0.1;
sysD1 = c2d(ss(sysC1), dt);
tf(sysD1)

%O valor em regime pode então ser obtido fazendo 
z = 1;
R = z*(0.004528*z + 0.004097)/(z^2-1.724*z+0.7408);
%A estabilidade pode ser obtida analisando os polos da FT
P = pole(sysD1);
pzmap(sysD1);

%Polo dominante -> 0.9048
%90% do valor em regime, considerando so o polo dominante:
k = (log(1-0.9))/(log(0.9048));
%Valor encontrado analiticamente: k = 33
%% Representação em E.E 
% representação controlavel e observável 
Co = ctrb(sysD1.A, sysD1.B);
Ob = obsv(sysD1.A, sysD1.C);

%% Resposta em frequência
figure(2);
bode(sysD1);

sysC2 = tf(0.5, [1 1 -2]);
sysD2 = c2d(ss(sysC2), dt);
figure(3);
bode(sysD2);

%Para o sistema estavel, vejamos o efeito de atenuacao em diferentes
%frequencias - 1Hz, 3Hz (frequencias contínuas)
figure(4);
N = 200;
n = 1:N;
w1 = 1;
w2 = 3;
u1 = sin(w1*dt*n);
u2 = sin(w2*dt*n);
x1=zeros(2, N);
y1=zeros(1, N);
for i = 2:N
    x1(:,i) = sysD1.A*x1(:,i-1) + sysD1.B*u1(i-1);
    y1(i) = C1*x1(:,i) + D1*u1(i);
end
stem(n,y1);
hold on;
x1=zeros(2, N);
y1=zeros(1, N);
for i = 2:N
    x1(:,i) = sysD1.A*x1(:,i-1) + sysD1.B*u2(i-1);
    y1(i) = C1*x1(:,i) + D1*u2(i);
end
stem(n,y1);