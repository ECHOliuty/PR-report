
feature=[feature1;feature2;feature3;feature4]';
a=feature(1:30,:);
b=feature(51:80,:);
c=feature(121:150,:);
d=feature(31:50,:);
e=feature(81:100,:);
f=feature(101:120,:);
inp=[a;b;c];
tep=[d;e;f];
y=num2str(zeros(90,1));
for i=1:30
    y(i)='a';
end
for i=31:60
    y(i)='b';
end
for i=61:90
    y(i)='c';
end
y1=cell(60,1);
for i=1:20
    y1(i)={'a'};
end
for i=21:40
    y1(i)={'b'};
end
for i=41:60
    y1(i)={'c'};
end
yi=y1'
t=treefit(inp,y);
level=1;
t=treeprune(t,'level',level);
view(t);
pp=eval(t,tep)
pp=pp'
correct=0
for i=1:60
    x=char(yi{i});
    if(x=='a')
        u=1;
    elseif(x=='b')
        u=2;   
    elseif(x=='c')
        u=3;
    end
    m=char(pp{i});
    if(m=='a')
        v=1;
    elseif(m=='b')
        v=2;   
    elseif(m=='c')
        v=3;
    end
    if(v==u)
        correct=correct+1;
    end
end