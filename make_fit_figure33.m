 figure(no)
    hold on
    plot(T_1f((T_1f(:,2)==1),1),Y_fit_1f(ind,(T_1f(:,2)==1),3),'b','LineWidth',3)
    plot(T_1f((T_1f(:,2)==3),1),Y_fit_1f(ind,(T_1f(:,2)==3),3),'r','LineWidth',3)
    plot(t((t(:,2)==1),1),S((t(:,2)==1)),'o','LineWidth',1.75,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor','c')
    plot(t(((t(:,2)>=1.3)),1),S((t(:,2)>=1.3)),'o','LineWidth',1.75,'MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor','m')
    for k = 1:length(t)
        plot(t_1(k,:),Up_Lo_b(k,:)','k','LineWidth',2)
    end
    title(title_1,'fontsize',16)
    xlabel('Time (s)','fontsize',16)
    ylabel('Normalized ChIP Signal (\theta_x_l)','fontsize',16)
    xlim([0 3700])
    hold off
