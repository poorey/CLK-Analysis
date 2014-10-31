% For Case 1
Ks = IP_sat; %1.1;
[b_nl1,para1,r1,Y_fit1,T_1,Case1_fun] = Fit_Case1_func_c(t,S,Ks);
 % B = [Theta_0, KaCtf, Ip_sat]
 ka = b_nl1(1); kd = b_nl1(2); IP_sat=b_nl1(3);
 para1
'Case 1' 
t_1 = [t(:,1) t(:,1)];
Up_Lo_b = [S+error S-error];
figure (1); subplot(2,3,1)
subplot(2,1,1) 
 plot(t((t(:,2)==1),1),S((t(:,2)==1)),'o','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor','m')
 hold on
 plot(t(((t(:,2)>=1.3)),1),S((t(:,2)>=1.3)),'o','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','y')

 plot(T_1((T_1(:,2)==1),1),Y_fit1(T_1(:,2)==1),'k','LineWidth',2.5)
 plot(T_1((T_1(:,2)>=1.3),1),Y_fit1(T_1(:,2)>=1.3),'r','LineWidth',2.5)%,'linestyle', '--')
    for k = 1:length(t)
        plot(t_1(k,:),Up_Lo_b(k,:)','k','LineWidth',2)
    end
xlim([0 2000])
 hold off


for i = 1:length(f) 
    ka = para1(1);
    kd = (para1(2));
    kxl = (max(abs([para1(1) para1(2)]))*f(i));
clear Ks; Ks = abs([ka kd kxl IP_sat]);


    [b_nl_1f,para_1f,res_1f(:,i),mse_1f(i),Y_fit_1f(i,:,:),T_1f,Full_fun_1f,sat_out_1f,C_p1f(:,:,i)] = Full_theory_NLfit_function_c2(t,S,Ks);
 
    ka_f = para_1f(13);
    kd_f = para_1f(14);
    kxl_f = para_1f(15);
    subplot(2,1,2)
   
    plot(t((t(:,2)==1),1),S((t(:,2)==1)),'o','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor','m')
  hold on
    plot(t(((t(:,2)>=1.3)),1),S((t(:,2)>=1.3)),'o','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','y')

    plot(T_1f((T_1f(:,2)==1),1),Y_fit_1f(i,(T_1f(:,2)==1),3),'k','LineWidth',2.5)
 
    plot(T_1f((T_1f(:,2)==3),1),Y_fit_1f(i,(T_1f(:,2)==3),3),'r','LineWidth',2.5)%,'linestyle', '--')
 
    K_all_case1(i,:) = [ka_f kd_f kxl_f sat_out_1f]

    K_all_app_case1(i,:) = [ka kd kxl IP_sat]

    for k = 1:length(t)
        plot(t_1(k,:),Up_Lo_b(k,:)','k','LineWidth',2)
    end
    xlim([0 2000])
 end
    hold off

'K_all has stored [KaCtf kd KxlCfh IP_sat]'
