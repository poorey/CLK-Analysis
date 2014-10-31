clear
clc
load ./sample.txt % The name of the input file 
% The format of the input file is 
%
%time(s)  CTF concentration multiplier  CFH Conc Multiplier     ChIP Signal     Error

% The file whould be Tab deliminated and should have only numbers

 t = sample(:,1:3); S = sample(:,4); error = sample(:,5);
ind = find(t(:,3)==8);
t(ind,:) = [];S(ind,:) = [];error(ind,:) = [];t(:,3) = [];
%%%%%%%%%%%%%%%%%%
IP_sat = 1.1; % User intial guess of IP-sat
%%%%%%%%%%%%%%%%%%
 title_1 = {'Model CLK Fits'}
no = 2; % Figure Number Anything Other than 1
%%%%%%%%%%%%%%%%%%
% Concentration Multiplier for the Overexpression
CTF = 3 ;
%%%%%%%%%%%%%%%%%%
Run_Script_to_fit; K_final = K_all_case1(ind,:); save Parameters.mat

'kaC     kd      kxlCFH     IP_sat'

K_final

open K_final
