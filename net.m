traindata=[1 1 1 1;2 2 2 2;1 2 1 2;2 1 2 1;
           10 10 10 10;12 10 12 12;13 14 12 11;
           -12 -12 -12 -14;-12 -14 -10 -19;-16 -17 -18 -16];
labeldata=[1 0 0;1 0 0;1 0 0;0 1 0;0 1 0;0 1 0;0 0 1;0 0 1;0 0 1];          
x=zeros(4,1);   %输入
w=zeros(4,3);   %输入到隐层权值矩阵
v=zeros(3,3);   %隐层到输出层权值矩阵
H=zeros(3,1);   %隐层激活前
Ha=zeros(3,1);  %隐层激活后
T=zeros(3,1);   %输出层激活前
o=zeros(3,1);   %计算输出
y=zeros(3,1);   %目标输出
E=zeros(3,1);   %误差
n=20000  %最大迭代次数
lr=0.05;
for p=1:n
    cost=0;
    for k=1:9
        x=traindata(k,:)';
        y=labeldata(k,:)';
        H=w'*x;
        Ha=1./(1+exp(-H));%隐层输出
        T=v'*Ha;
        o=1./(1+exp(-T));%输出
        E=o-y;   %计算代价
        cost=cost+0.5*sum(E.^2);%计算当前代价
    end
    if(cost<error)
        break
    end
  for l=1:9
%前向传播计算输出
    x=traindata(l,:)';
    y=labeldata(l,:)';
    H=w'*x;
    Ha=1./(1+exp(-H));%隐层输出
    T=v'*Ha;
    o=1./(1+exp(-T));%输出

%反向传播更新权值
    for i=1:3
        for j=1:3
            b(i)=Ha(i);
            g(j)=(o(j)-y(j))*o(j)*(1-o(j));
            dv(i,j)=g(j)*b(i);%输出层权值更新矩阵
        end
    end
    for i=1:4
        for h=1:3
            re=(o(1)-y(1))*y(1)*(1-y(1))*v(h,1)+(o(2)-y(2))*y(2)*(1-y(2))*v(h,2)+(o(3)-y(3))*y(3)*(1-y(3))*v(h,3);
            dw(i,h)=Ha(h)*(1-Ha(h))*re*x(i);
        end
    end
    v=v-lr*dv;
    w=w-lr*dw;
    end
end
        
        