%% Sistemas em tempo Continuo
clear [sysC1, sysC2];
% Sistema estavel
sysC1 = tf(1, [1 3 2]);
% Sistema instavel
sysC2 = tf(0.5, [1 1 -2]);

% Podemos obter uma representacao em espaço de estados do sistema
[A1, B1, C1, D1] = deal(ss(sysC1).A, ss(sysC1).B, ss(sysC1).C, ss(sysC1).D);
[A2, B2, C2, D2] = deal(ss(sysC2).A, ss(sysC2).B, ss(sysC2).C, ss(sysC2).D);

%% Obtendo as respostas do sistema em tempo Continuo
figure(1);
% Respostas ao impulso
subplot(2, 2, 1);
step(sysC1, 6);
xlabel('t')
ylabel('y(t)')
subplot(2, 2, 2);
step(sysC2, 6);
xlabel('t')
ylabel('y(t)')

% Respostas a senoides - Sistema 1
dt = 0.01;
stopTime = 20;
t = 0:dt:stopTime;
u1 = sin(2*pi*0.2*t);
subplot(2, 2, 3);
lsim(sysC1,u1,t);
xlabel('t')
ylabel('y(t), x(t)')

% Respostas a senoides - Sistema 2
stopTime = 6;
t2 = 0:dt:stopTime;
u2 = sin(2*pi*1.5*t2);
subplot(2, 2, 4);
lsim(sysC2,u2,t2);
xlabel('t')
ylabel('y(t), x(t)')

%% Discretizando os sistemas
dn = 0.1;
%Dessa forma, podemos ter sinais de no maximo 1/0.05 = 20Hz
sysD1 = c2d(ss(sysC1), dn);
sysD2 = c2d(ss(sysC2), dn);
[phi1, gama1] = deal(sysD1.A, sysD1.B);
[phi2, gama2] = deal(sysD2.A, sysD2.B);

%% Respostas do sistema em tempo discreto
% Respostas ao degrau
figure(2);
stopN = 6;
n = 0:dn:stopN;
N = size(n', 1);
stepD = ones(N);
[x1, x2] = deal(zeros(2, N));
[y1, y2] = deal(zeros(1, N));
for i = 2:N
    x1(:,i) = phi1*x1(:,i-1) + gama1*stepD(i-1);
    y1(i) = C1*x1(:,i) + D1*stepD(i);
end
subplot(2, 2, 1);
stem(n, y1);
xlabel('n');
ylabel('y[n]');
for i = 2:N
    x2(:,i) = phi2*x2(:,i-1) + gama2*stepD(i-1);
    y2(i) = C2*x2(:,i) + D2*stepD(i);
end
subplot(2, 2, 2);
stem(n, y2);
xlabel('n');
ylabel('y[n]');
%% 

% Respostas a senoide
stopN = 20;
n = 0:dn:stopN;
N = size(n', 1);
u1 = sin(2*pi*0.2*n);
x1=zeros(2, N);
y1=zeros(1, N);
for i = 2:N
    x1(:,i) = phi1*x1(:,i-1) + gama1*u1(i-1);
    y1(i) = C1*x1(:,i) + D1*u1(i);
end
subplot(2, 2, 3);
stem(n, y1);
xlabel('n');
ylabel('y[n]');
stopN = 6;
n = 0:dn:stopN;
u2 = sin(2*pi*1.5*n);
N = size(n', 1);
x2=zeros(2, N);
y2=zeros(1, N);
for i = 2:N
    x2(:,i) = phi2*x2(:,i-1) + gama2*u2(i-1);
    y2(i) = C2*x2(:,i) + D2*u2(i);
end
subplot(2, 2, 4);
stem(n, y2);
xlabel('n');
ylabel('y[n]');