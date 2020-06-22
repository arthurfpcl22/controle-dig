%Determinando planta sob a forma de equação de estados(sistema estável)
num1=1;
den1=[1 3 2];
sys1=tf(num,den);
[A1,B1,C1,D1]=tf2ss(num1,den1);
%Determinado planta sob a forma de equação de estados(sistema instável)
num2=0.5;
den2=[1 1 -2];
sys2=tf(num2,den2);
[A2,B2,C2,D2]=tf2ss(num2,den2);
%intervalo de amostragem
h=0:0.2:20;
q_0=[0;0];
%resolução equação no domínio da frequência sistema estável,resposta ao
%degrau
syms s t;
FI_s=(inv(s*eye(2)-A1));
Q_sd=FI_s*q_0+FI_s*B1*(1/s);
y_sd=C1*Q_sd+D1*(1/s);
y_td=ilaplace(y_sd);
subplot(4,1,1);
yd=double(subs(y_td,t,h));
stem(h,yd);
%resolução equação no domínio da frequência sistema estável,resposta a
%senoide
Q_ss=FI_s*q_0+FI_s*B1*(2*pi*0.2/((s^2)+(2*pi*0.2)^2));
y_ss=C1*Q_ss+D1*(0.2/((s^2)+(0.2)^2));
y_ts=ilaplace(y_ss);
subplot(4,1,2);
ys=double(subs(y_ts,t,h));
stem(h,ys);
%resolução equação no domínio da frequência sistema instável,resposta ao
%degrau
syms s t;
FI_I=(inv(s*eye(2)-A2));
Q_sdI=FI_I*q_0+FI_I*B2*(1/s);
y_sdI=C2*Q_sdI+D2*(1/s);
y_tdI=ilaplace(y_sdI);
subplot(4,1,3);
ydI=double(subs(y_tdI,t,h));
stem(h,ydI);
%resolução equação no domínio da frequência sistema instável,resposta a
%senoide
Q_ssI=FI_I*q_0+FI_I*B2*(2*pi*0.2/((s^2)+(2*pi*0.2)^2));
y_ssI=C2*Q_ssI+D2*(2*pi*0.2/((s^2)+(2*pi*0.2)^2));
y_tsI=ilaplace(y_ssI);
subplot(4,1,4);
ysI=double(subs(y_tsI,t,h));
stem(h,ysI);
