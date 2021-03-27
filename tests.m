clear; clc;
global llamadas
llamadas = 0;
N = 20;
it = 40;
alpha = 1.5;
beta = 2.5;
acc = 0.001;
name = 'levy';
errmax = 1e-3;
opt = 0;  %-1.0316 camel
errgrad=0;
llamadasgrad=0;
errpso=0;
llamadaspso=0;
% Cada fila es una variable, col1 limite inf, col 2 lim sup
lim = [-50, 50; -50, 50];
for i=1:200
llamadas=0;
[Fmin, G, it, err] = PSO(name,lim,N,it,opt,errmax);
errpso=[errpso err];
llamadaspso=[llamadaspso llamadas];

llamadas=0;

[Fmin, G, it, err] = PSO_grad(name,lim,N,it,opt,errmax);
errgrad=[errgrad err];
llamadasgrad=[llamadasgrad llamadas];

end
figure(1)
plot(llamadasgrad,errgrad,'*')
figure(2)
plot(llamadaspso,errpso,'o')
mean(llamadasgrad)
mean(llamadaspso)
mean(errgrad)
mean(errpso)