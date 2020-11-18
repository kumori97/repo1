 %% 3.�Ż�����Сֵ�ķ���
clear, clc
hip_length = zeros(300,1);

for i = 0:299
    i = num2str(i);
    filex = strcat('./hips/',i,'x.txt');
    filey = strcat('./hips/',i,'y.txt');
    x = load(filex);
    y = load(filey);
    
    fun=@(t)sum((t(1)*x.^2+t(2)*x.*y+t(3)*y.^2+t(4)*x+t(5)*y+t(6)).^2);
    X = [1,1,1,1,1,1];
    [t, fval]= fminunc( fun , X);  %�ޱ߽��Ԫ�Ż�����
    %clf , plot(x,y,'.')
   % hold on
   % syms x y
    %ezplot(t(1)*x.^2+t(2)*x.*y+t(3)*y.^2+t(4)*x+t(5)*y+t(6), [-40 40 -40 40] ) 
   % axis square
    %��ͼ�������д���Դ�һ�㣬��֤����ͼ������
    A =t(1)/t(6);
    B =t(2)/t(6);
    C =t(3)/t(6);
    D =t(4)/t(6);
    E =t(5)/t(6);
    F =t(6)/t(6);

    %�������
    theta = 0.5*atan(B/(A-C));
    %��Բ��������
    Xc = (B*E-2*C*D)/(4*A*C-B*B);
    Yc = (B*D-2*A*E)/(4*A*C-B*B);
    %���̰���
    a = (2*(A*Xc*Xc+C*Yc*Yc+B*Xc*Yc-1)/((A+C)+((A-C).^2+B*B).^0.5)).^0.5;
    b = (2*(A*Xc*Xc+C*Yc*Yc+B*Xc*Yc-1)/((A+C)-((A-C).^2+B*B).^0.5)).^0.5;
    %������
    e = (a*a-b*b).^0.5/a;
    %��Բ���ܳ�
    perimeter = 2*pi*b+4*(a-b)
    i = str2num(i);
    hip_length(i+1,1) = perimeter;
   % filename = strcat('./hip_perimeter/hips',i,'.txt')
   % save(filename,'perimeter','-ascii')
end

xlswrite('C:\Users\kumori\Desktop\Parameter_statistics.xlsx',{'hips'},'A1:A1')
xlswrite('C:\Users\kumori\Desktop\Parameter_statistics.xlsx',hip_length,'A2:A301')