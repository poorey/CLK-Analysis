%
% % This function will apply Case 1 approximation to the dataset/simulations

%%output in the order of Fitted Y Fitted theta parameters residuals and saturation 

function [b_nl,para,r,Y_fit,T,Case1_fun] = Fit_Case1_func(t1,S1,Ks)
myfun = @(B, x) B(3)*(1-B(1)*exp(-1*B(2)*x));

%%output in the order of Fitted Y Fitted theta parameters residuals and saturation 
sat = max(S1);
k = length(t1);
Th_xl = S1/(sat+.005);
Y = log(1-Th_xl);
[b] = robustfit(t1,Y,'welsch');
Lin_Theta = 1-exp(b(1));
Lin_kaCace1 = -b(2);
inc = 0.01;
for i = 1:1000
    T(i) = i*inc;
end
inc=10;
for i = 1001:4850
    T(i)=10+(i-1000);
end
% % 
%% For the non linear regression
% to design a function handle for the unique function we have
IP_sat = Ks;
Conc_TF = 1.2*10^(-5);
% Defining the input feed for the nonlinar models 
% B = [Theta_0, KaCtf, Is]
b0 = real([Lin_Theta Lin_kaCace1]);
myfun = @(B, x) IP_sat*(1-(1-B(1)*exp(-1*B(2)*x)));
[b_nl,r,J,COVB,mse] = nlinfit(t1,S1,myfun,b0);
%[Ypread dlt] = nlpredci(myfun,t1,b_nl,r,j, )
Y_fit = myfun(b_nl,T);
para = [b_nl(1) b_nl(2) IP_sat];
Case1_fun = myfun;
