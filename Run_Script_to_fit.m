ind = find(t(:,2)==3);t(ind,2)=CTF;
 f = [2 5 10 30 50 100 200 500 800 1000 2000 5000 10000 1000000] 
 % this is the multiplication factor used to generate multiple initial guesses for kxl 
 Full_model_Case1_fit
 ind = find(mse_1f==min(mse_1f))
 
 best_fit = Y_fit_1f(ind,:,3);
 best_fit_t = Full_fun_1f(K_all_case1(ind,:),t);
S = S/K_all_case1(ind,4);
Y_fit_1f = Y_fit_1f/K_all_case1(ind,4);
Up_Lo_b = Up_Lo_b/K_all_case1(ind,4);
make_fit_figure33
 R = abs(res_1f(:,ind)); R_N = abs(res_1f(:,ind)./(0.5*(S+best_fit_t)));
