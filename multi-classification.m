A=load('x1');
B=load('x2');
C=load('x3');
sc1=struct2cell(A);
x1=cell2mat(sc1);
sc2=struct2cell(B);
x2=cell2mat(sc2);
sc3=struct2cell(C);
x3=cell2mat(sc3);
t1=0;t2=0;t3=0;
prior1=length(x1)/(length(x1)+length(x2)+length(x3));
prior2=length(x2)/(length(x1)+length(x2)+length(x3));
prior3=length(x3)/(length(x1)+length(x2)+length(x3));
mu1=sum(x1')/length(x1);
mu2=sum(x2')/length(x2);
mu3=sum(x3')/length(x3);
w1=(cov(x1'));
w2=(cov(x2'));
w3=(cov(x3'));
for i=1:50
    g1(i)=-0.5*(x1(:,i)-mu1')'*inv(w1)*(x1(:,i)-mu1')+log(prior1)-0.5*det(w1);
    g2(i)=-0.5*(x1(:,i)-mu2')'*inv(w2)*(x1(:,i)-mu2')+log(prior2)-0.5*det(w2);
    g3(i)=-0.5*(x1(:,i)-mu3')'*inv(w3)*(x1(:,i)-mu3')+log(prior3)-0.5*det(w3);
    if((g1(i)>g2(i))&&(g1(i)>g3(i)))
        t1=t1+1;
    else if((g2(i)>g1(i))&&(g2(i)>g3(i)))
            t2=t2+1;
        else if((g3(i)>g1(i))&&(g3(i)>g2(i)))
                t3=t3+1;
            end
        end
    end
end
for i=1:50
    plot(x1(1,i),x1(2,i),'*');
    hold on;
end
for i=1:50
    plot(x2(1,i),x2(2,i),'.');
    hold on;
end
for i=1:100
    plot(x3(1,i),x3(2,i),'^');
    hold on;
end
figure;
x=-5:0.2:15;
y=-5:0.2:15;
[X,Y]=meshgrid(x,y); % 产生网格数据并处理
p=prior2*mvnpdf([X(:),Y(:)],mu2,w2)+6*prior3*mvnpdf([X(:),Y(:)],mu3,w3);
q=prior1*mvnpdf([X(:),Y(:)],mu1,w1)+prior3*mvnpdf([X(:),Y(:)],mu3,w3);
r=6*prior1*mvnpdf([X(:),Y(:)],mu1,w1)+prior2*mvnpdf([X(:),Y(:)],mu2,w2);
P=reshape(p,size(X)); % 求取联合概率密度
Q=reshape(q,size(X));
R=reshape(r,size(X));
figure(2)
surf(X,Y,P);
figure;
surf(X,Y,Q);
figure;
surf(X,Y,R);
figure;
syms x y;
g12=-0.5*[(x-mu1(1));(y-mu1(2))]'*inv(w1)*[(x-mu1(1));(y-mu1(2))]+log(prior1)-0.5*det(w1)+0.5*[(x-mu2(1));(y-mu2(2))]'*inv(w2)*[(x-mu2(1));(y-mu2(2))]-log(prior2)+0.5*det(w2);
h1=ezplot(g12,[0,15,0,15]);
set(h1,'Color','r');
hold on;
g13=-0.5*[(x-mu1(1));(y-mu1(2))]'*inv(w1)*[(x-mu1(1));(y-mu1(2))]+log(prior1)-0.5*det(w1)+0.5*[(x-mu3(1));(y-mu3(2))]'*inv(w3)*[(x-mu3(1));(y-mu3(2))]-log(prior3)+0.5*det(w3);
h2=ezplot(g13,[0,15,0,15]);
set(h2,'Color','g');
hold on;
g23=-0.5*[(x-mu2(1));(y-mu2(2))]'*inv(w2)*[(x-mu2(1));(y-mu2(2))]+log(prior2)-0.5*det(w2)+0.5*[(x-mu3(1));(y-mu3(2))]'*inv(w3)*[(x-mu3(1));(y-mu3(2))]-log(prior3)+0.5*det(w3);
h3=ezplot(g23,[0,15,-2,15]);
set(h3,'Color','b');
