%
% % This function will apply Case 1 approximation to the dataset/simulations

%%output in the order of Fitted Y Fitted theta parameters residuals and saturation 

function [b_nl1,para,r,Y_fit1,T,Case1_fun] = Fit_Case1_func_c(t1,S1,Ks)
%myfun = @(B, x) B(3)*(1-B(1)*exp(-x(2)*B(2)*x(1)));
% fit the linear case with no assomption of over expression
t11 = t1((t1(:,2)==1),1);
S11 = S1((t1(:,2)==1),:);
t12 = t1((t1(:,2)>=1.3),1);
S12 = S1((t1(:,2)>=1.3),:);
b_nl11 = [];
try
[b_nl11,para11,r11,Y_fit11a,T11,Case1_fun11] = Fit_Case1_func(t11,S11,Ks);
catch
end
try
[b_nl11,para11,r11,Y_fit11a,T11,Case1_fun11] = Fit_Case1_func(t12,S12,Ks);
catch
end
%%
inc = 0.01;
for i = 1:1000
    T(i) = i*inc;
end
inc=10;
for i = 1001:4850
    T(i)=10+(i-1000);
end
T=T';
T(:,2)=1;
T1 = T;
T1(:,2) = 3;
T = cat(1,T,T1);
% %
%% For the non linear regression
% to design a function handle for the unique function we have
IP_sat = Ks;
if(isempty(b_nl11)==1)
    b_nl11 = [0.0002 0.002 Ks]
end
%Conc_TF = 1.2*10^(-5);
% Defining the input feed for the nonlinar models 
% B = [Theta_0, KaCtf, Is]
b0 = real([abs(b_nl11(2)) abs((1-b_nl11(1))*b_nl11(2)/b_nl11(1))]);
%b0 = real([abs(b_nl11(2)) 35*abs(b_nl11(2))]);

%b0 = [0.0001 0.001]
myfun = @(B, x) IP_sat*(1-((1-((B(1).*x(:,2)./((B(1).*x(:,2))+B(2))))).*exp(-1*B(1).*x(:,1).*x(:,2))));
b_nl = [];
try
[b_nl,r,J,COVB,mse] = nlinfit(t1,S1,myfun,b0);
catch
end
if(isempty(b_nl)==1)
    b_nl11 = [NaN NaN]
end
%[Ypread dlt] = nlpredci(myfun,t1,b_nl,r,j, )
Y_fit11 = myfun(b_nl,T((T(:,2)==1),:));
Y_fit12 = myfun(b_nl,T((T(:,2)>=1.3),:));

Y_fit1 = cat(1,Y_fit11,Y_fit12);
%for i = 1:t1(:,1)
%    Y_fit(i) = myfun(b_nl,t1(i,:));
%end
para = [b_nl(1) b_nl(2) IP_sat];
Case1_fun = myfun;
%%
IP_sat = Ks;
b_nl11(3)=Ks;
if(isempty(b_nl11)==1)
    b_nl11 = [0.0002 0.002 Ks]
end
% B = [Theta_0, KaCtf, Is]
b0 = real([abs(b_nl11(2)) abs((1-b_nl11(1))*b_nl11(2)/b_nl11(1)) b_nl11(3)]);
myfun1 = @(B, x) B(3)*(1-((1-((B(1).*x(:,2)./((B(1).*x(:,2))+B(2))))).*exp(-1*B(1).*x(:,1).*x(:,2))));
b_nl1 = [];
try
[b_nl1,r,J,COVB,mse] = nlinfit(t1,S1,myfun1,b0);
catch
end
if(isempty(b_nl1)==1)
    b_nl11 = [NaN NaN NaN]
end
%[Ypread dlt] = nlpredci(myfun,t1,b_nl,r,j, )
Y_fit11 = myfun1(b_nl1,T((T(:,2)==1),:));
Y_fit12 = myfun1(b_nl1,T((T(:,2)>=1.3),:));
Y_fit1 = cat(1,Y_fit11,Y_fit12);
%for i = 1:t1(:,1)
%    Y_fit(i) = myfun(b_nl,t1(i,:));
%end
para = [b_nl1(1) b_nl1(2) b_nl1(3)];
Case1_fun = myfun1;
