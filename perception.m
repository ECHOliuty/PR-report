x1=mvnrnd([6 3],[2 0;0 2],50);
x2=mvnrnd([2 1],[1 0;0 2],50); 
x5=[x1;x2];
sz=[1,100];
y1=zeros(sz);
for i=1:50
    y1(i)=1;
    y1(101-i)=-1;
end
w=[0.1;0.1;0.1];
lr=0.008;
for i=1:2000
    flag=0;
    correct=0;
    for j=1:100
        o=[x5(j,1) x5(j,2) 1]*w;
        if(o>0)
            o=1;
        else
            o=-1;
        end
        if(y1(j)==o)
            correct=correct+1;
        else
            w=w+lr*[x5(j,1);x5(j,2);1]*(y1(j)-o);
            flag=1;
        end
    end
    disp(w);
    disp(correct)
    if(flag==0)
        break
    else
        continue
    end
end
k=1:50;
scatter(x5(k,1),x5(k,2),'p')
hold on;
k=51:100;
scatter(x5(k,1),x5(k,2),'r')
hold on;
x=linspace(0,10);
y=(-(w(1)/w(2))*x)-w(3)/w(2);
plot(x,y)
