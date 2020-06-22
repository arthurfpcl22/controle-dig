A=[0 1;-1/6 5/6];
B=[0;1];
C=[-1 5];
D=0;
q_0=[2;3];
n=1:10;

z=sym('z');
X=ztrans(sym('1'));
Q=inv(eye(2)-z^(-1)*A)*q_0+inv(z*eye(2)-A)*B*X;
Q=simplify(Q);

Y=simplify(C*Q);
y=iztrans(Y);

y_ES0=iztrans(simplify(C*inv(eye(2)-z^(-1)*A)*q_0));
y_EN0=y-y_ES0;

y=double(subs(y,n));
y_ES0=double(subs(y_ES0,n));
y_EN0=double(subs(y_EN0,n));



subplot(3,1,1);
stem(n,y);
axis([1 10 min(y) max(y)]);
xlabel('n');
ylabel('y[n]');
title('Resposta no domínio do tempo');
subplot(3,1,2);
stem(n,y_ES0);
axis([1 10 min(y_ES0) max(y_ES0)]);
xlabel('n');
ylabel('y[n]ES0');
title('Resposta Estado Nulo');
subplot(3,1,3);
stem(n,y_EN0);
axis([1 10 min(y_EN0) max(y_EN0)]);
xlabel('n');
ylabel('y[n]EN0');
title('Resposta Entrada Nula');
