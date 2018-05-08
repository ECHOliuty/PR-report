x1=mvnrnd([6 3],[2 0;0 2],50);  %通过二维正态分布的随机数产生两类训练样本，通过改变正太分布的均值、方差可以改变不同类别间差异性大小
x2=mvnrnd([2 1],[1 0;0 2],50); 
x5=[x1;x2];
sz=[1,100];
y1=zeros(sz);
for i=1:50
    y1(i)=1;
    y1(101-i)=-1;  %给两类样本指定标签，x1为正样本，x2为负样本
end
w=[0.1;0.1;0.1];%设置初始权值矩阵
lr=0.008;    %设置学习率
for i=1:2000   %i指定最大迭代次数
    flag=0;  %flag指示是否产生错分
    correct=0;  %在当前超平面下正确分类的样本点的数目
    for j=1:100  %遍历每个样本点
        o=[x5(j,1) x5(j,2) 1]*w; %计算感知器输出
        if(o>0)
            o=1;
        else
            o=-1;
        end
        if(y1(j)==o)
            correct=correct+1;  %每次正确分类使correct加一
        else
            w=w+lr*[x5(j,1);x5(j,2);1]*(y1(j)-o); %每次错误分类都要通过感知器法则调整权值
            flag=1;  %表示已经产生错误分类
        end
    end
    disp(w);  %显示权值矩阵
    disp(correct)%显示正确分类数目
    if(flag==0)  %所有样本点均未错分，则跳出循环
        break
    else
        continue %产生错分则需重新遍历所有样本点
    end
end
k=1:50;
scatter(x5(k,1),x5(k,2),'p')
hold on;
k=51:100;
scatter(x5(k,1),x5(k,2),'r')
hold on;
x=linspace(0,10);
y=(-(w(1)/w(2))*x)-w(3)/w(2);  %绘制超平面
plot(x,y)
