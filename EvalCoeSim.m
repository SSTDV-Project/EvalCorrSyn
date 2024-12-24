% Evaluation of synthetic data with statistical similarity
% Evaluation methods : correlation similarity index
clearvars;
%%% User defined variables %%%
RALV = readmatrix('RealData.csv');
SALV = readmatrix('SyntheticData.csv');
Nbootstrap = 20; % The number of bootstrapping
plotflag = 1; % 1 for results plotting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RcoeAll = []; ScoeAll = [];
for i = 1:Nbootstrap
%for i = 1
    Rindex = randperm(length(RALV), 200);
    d1 = RALV(Rindex, :); d2 = SALV(Rindex, :);
    %%% Calculation of pearson correlation coefficient
    Rcoe = corr(d1(:,1), d1(:,2));
    Scoe = corr(d2(:,1), d2(:,2));
    RcoeAll = [RcoeAll; Rcoe];
    ScoeAll = [ScoeAll; Scoe];
end
%%% t-test of correlation coefficient
[h,p,ci,stats] = ttest2(RcoeAll, ScoeAll);
if plotflag
    figure1 = figure;    
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    d1 = RALV; d2 = SALV;
    [P1, S1] = polyfit(d1(:,1),d1(:,2),1);
    Xaxis =[min(d1(:,1)):1:max(d1(:,1))];
    y1 = P1(1).*(Xaxis) + P1(2);
    scatter(d1(:,1), d1(:,2), 'r','DisplayName','Real Data'); hold on;
    plot(Xaxis, y1, 'r', 'DisplayName','Regression Line of Real Data'); hold on;
    [P2, S2] = polyfit(d2(:,1),d2(:,2),1);
    Xaxis =[min(d2(:,1)):1:max(d2(:,1))];
    y2 = P2(1).*(Xaxis) + P2(2);
    scatter(d2(:,1), d2(:,2), 'b', 'DisplayName','Synthetic Data'); hold on;
    plot(Xaxis, y2, 'b', 'DisplayName','Regression Line of Synthetic Data');
    xlabel('Age'); ylabel('Volume of Lateral Ventricle');
    legend(axes1,'show');
    hold off;    
    figure2 = figure;    
    axes2 = axes('Parent',figure2);
    hold(axes2,'on');
    d1 = RALV(Rindex,:); d2 = SALV(Rindex,:);
    [P1, S1] = polyfit(d1(:,1),d1(:,2),1);
    Xaxis =[min(d1(:,1)):1:max(d1(:,1))];
    y1 = P1(1).*(Xaxis) + P1(2);
    scatter(d1(:,1), d1(:,2), 'r','DisplayName','Real Data'); hold on;
    plot(Xaxis, y1, 'r', 'DisplayName','Regression Line of Real Data'); hold on;
    [P2, S2] = polyfit(d2(:,1),d2(:,2),1);
    Xaxis =[min(d2(:,1)):1:max(d2(:,1))];
    y2 = P2(1).*(Xaxis) + P2(2);
    scatter(d2(:,1), d2(:,2), 'b', 'DisplayName','Synthetic Data'); hold on;
    plot(Xaxis, y2, 'b', 'DisplayName','Regression Line of Synthetic Data'); 
    xlabel('Age'); ylabel('Volume of Lateral Ventricle');
    legend(axes2,'show');
    hold off;    
    figure3 = figure;
    axes3 = axes('Parent', figure3);
    hold(axes3, 'on');
    Err = [std(RcoeAll) std(ScoeAll)];
    data = [mean(RcoeAll), mean(ScoeAll)];
    xAxis = [1 2];
    bar(xAxis, data, 'FaceColor', [0.5 0.5 0.5]); 
    ylabel('Pearson''s Correlation coefficient');
    hold on;
    er = errorbar(xAxis,data,Err./2,Err./2);
    set(axes3,'YLim', [0 0.6], 'XTick',[1 2],'XTickLabel',{'Real Data','Synthetic Data'});
    er.Color = [0 0 0];                            
    er.LineStyle = 'none'; 
end
