clear all
clc
% ��������
my_FileName =['C:\Users\kumori\Desktop\Parameter_statistics.xlsx'];
my_SheetName = 'Sheet1';
my_NIR = xlsread(my_FileName,my_SheetName,'A2:C301');
my_octane =  xlsread(my_FileName,my_SheetName,'D2:F301');
% �������ѵ�����Ͳ��Լ�
my_temp = randperm(size(my_NIR,1));
% ѵ��������204������
P_train_ = my_NIR(my_temp(1:204),:)';
T_train_ = my_octane(my_temp(1:204),:)';
% ���Լ�����96������
P_test_ = my_NIR(my_temp(205:end),:)';
T_test_ = my_octane(my_temp(205:end),:)';
N = size(P_test_,2);
%���ݹ�һ��
[p_train_, ps_input_s] = mapminmax(P_train_,0,1);
p_test_ = mapminmax('apply',P_test_,ps_input_s);
[t_train_, ps_output_s] = mapminmax(T_train_,0,1);
% BP�����紴����ѵ�����������
% ��������
net = newff(p_train_,t_train_,10);
%����ѵ������
net.trainParam.epochs = 600;
net.trainParam.goal = 1e-3;
net.trainParam.lr = 0.0000001;
% ѵ������
net = train(net,p_train_,t_train_);
%�������
t_sim_ = sim(net,p_test_);
%���ݷ���һ��
T_sim_ = mapminmax('reverse',t_sim_,ps_output_s);
%������error
error = abs(T_sim_ - T_test_)./T_test_;
% ����Ա�
my_result = [T_test_' T_sim_' error'];
%��ͼ
figure
plot(1:N,T_test_(3,:),'b:*',1:N,T_sim_(3,:),'r-o')
legend('��ʵֵ','Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('8th para')
%ƽ�������
average_error = sum(error(3,:))/N
%����ѵ���õ������ڵ�ǰ����Ŀ¼�µ�bbb�ļ��У�netΪ������
x = [93.38391902,89.74097402,97.6411468]'
c = mapminmax('apply',x,ps_input_s);
d = sim(net,c);
f = mapminmax('reverse',d,ps_output_s)
