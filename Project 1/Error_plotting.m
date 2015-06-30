%res= zeros(13,1000);
hold on;
ss=['m','c','r','g','b','w','k','m','r--o','g--o','b--o','w--o','k--o'];
for i=3:10
    temp=load(strcat('k',num2str(i),'.mat'));
    plot(1:1000,temp.err_history,ss(i-2));
    legendinfo{i-2}=['k=' num2str(i)];
end
legend(legendinfo);
xlabel('Number of iterations')
ylabel('Value of Cost(Error) Function')