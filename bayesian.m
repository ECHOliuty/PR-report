w1=[-3.9847 -3.5549 -1.2401 -0.9780 -0.7932 -2.8531 -2.7605 -3.7287 -3.5414 -2.2692 -3.4549 -3.0752 -3.9934 -0.9780 -1.5799 -1.4885 -0.7431 -0.4221 -1.1186 -2.3462 -1.0826 -3.4196 -1.3193 -0.8367 -0.6579 -2.9683];
w2=[2.8792 0.7932 1.1882 3.0682 4.2532 0.3271 0.9846 2.7648 2.6588];
miu1=mean(w1);  %��ȡ��һ��������ֵ
sigma1=std(w1,1);%��һ����������
miu2=mean(w2);%�ڶ���������ֵ
sigma2=std(w2,1);%�ڶ�����������
x1=-10:0.1:10;

for i=1:201
class1(i)=normpdf(x1(i),miu1,sigma1);%��һ�����������������ϵĵ�
class2(i)=normpdf(x1(i),miu2,sigma2);%�ڶ������������������ϵĵ�
p2(i)=normpdf(x1(i),miu1,sigma1)*0.9/(normpdf(x1(i),miu1,sigma1)*0.9+normpdf(x1(i),miu2,sigma2)*0.1);%�������p2�����ϵĵ�
p1(i)=normpdf(x1(i),miu2,sigma2)*0.1/(normpdf(x1(i),miu1,sigma1)*0.9+normpdf(x1(i),miu2,sigma2)*0.1);%�������p1�����ϵĵ�
end
plot(x1,class1);%������������������
hold on
plot(x1,class2);
figure;
plot(x1,p1);%���ƺ����������
hold on;
plot(x1,p2);

