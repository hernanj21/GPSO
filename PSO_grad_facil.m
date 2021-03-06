function [Fmin, G, it_tot, err] = PSO_grad_facil(name,lim,N,it,opt,errmax)

alpha = 1.5;
beta = 2.5;
acc = 0.01;
theta = 1;
% Cada fila es una variable, col1 limite inf, col 2 lim sup

X = zeros(2,N);
F = zeros(1,N);
Fnew = zeros(1,N);
V = zeros(2,N);

for i = 1:N
    X(1,i) = rand(1)*(lim(1,2)-lim(1,1))+lim(1,1);
    X(2,i) = rand(1)*(lim(2,2)-lim(2,1))+lim(2,1);
    F(i) = feval(name,[X(1,i),X(2,i)]);
end
[Fmin, index] = min(F);
G = X(:,index);
P = X;
err = abs(Fmin-opt);
i = 0;
while i < it
    
    i = i+1;
    for j = 1:N
        
        V(:,j) = acc*V(:,j) + alpha*rand(size(X(:,j))).*(G-X(:,j)) + beta*rand(size(X(:,j))).*(P(:,j)-X(:,j));
        %X(:,j) = X(:,j) + V(:,j);
        %%%%%%%%%%%%%%
        grad1 = gradiente(X(:,j)',name);
        grad1 = grad1';
        x = X(:,j) + V(:,j) - 0.2*theta*grad1;
        grad2 = gradiente(x',name);
        grad2 = grad2';
        transpuesta = transpose(x-X(:,j));
        restgrad = grad2-grad1;
        theta = abs(dot(transpuesta,restgrad))/norm(restgrad)^2;
        X(:,j) = X(:,j) + V(:,j) - 0.2*theta*grad1;
        %%%%%%%%%%%%%%%%%%%%%%
        
        if (X(1,j) < lim(1,2)) && (X(1,j) > lim(1,1)) && (X(2,j) < lim(2,2)) && (X(2,j) > lim(2,1))
            Fnew(j) = feval(name,[X(1,j),X(2,j)]);
        else
            Fnew(j) = 20000000000;
        end
        if Fnew(j) < F(j)
            P(:,j) = X(:,j);
        end
    end
    if min(Fnew) < Fmin
        [Fmin, index] = min(Fnew);
        G = X(:,index);
        err = abs(Fmin-opt);
        if err < errmax
            break
        end
    end
    
    F = Fnew;
%     Fplot = [Fplot Fmin];
%     plot(Fplot);
%     drawnow
%     disp(Fmin);
end
it_tot = i;
end