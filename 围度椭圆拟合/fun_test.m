function f = fun_test(x)
%�������,ע���ļ���Ҫ�ӵ�����
    load('-mat','aaa');
    load('ps_input_.mat');
    load('ps_output_.mat');
    c = mapminmax('apply',x,ps_input_);
    d = sim(net,c);
    f = mapminmax('reverse',d,ps_output_);
end

