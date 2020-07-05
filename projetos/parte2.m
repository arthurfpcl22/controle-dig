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

