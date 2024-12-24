% Evaluating Multivariate Distribution Similarity of Synthetic Data

% The statistical similarity between real and synthetic data for a pair of features. This is often referred to as the correlation or bivariate distribution of the features.
% In the script below
% 1) Read in a CSV file with age, intracranial volume, and lateral ventricle volume values from real and synthetic data to calculate the correlation between age and % volume of lateral ventricle
% 2) The correlation between age and lateral ventricle is modeled by first-, second-, and cubic equations.
% 3) Select the model that best fits the data.
% 4) Statistically validate the similarity between the parameters of the model estimated from the real data and those estimated from the synthetic data.

% Example features in real and synthetic data: age, intracranial volume, and volume of the lateral ventricles.
% The correlation of age and % volume of lateral ventricles was estimated by referring to the study below.
% Age-Related Differences in Brain Morphology and the Modifiers in Middle-Aged and Older Adults, Lu Zhao et al., Cerebral Cortex 2019

% The program below should be run in MATLAB version 2024a.

clearvars;
RealData = readmatrix('RealData.csv'); % Read real data
SynData = readmatrix('SyntheticData.csv'); % Real synthetic data
%%% User defined variables
Nboost = 20; % the number of bootstrapping
Nsample = 500; % the number of sampling
Norder = [1 2 3]; % the order of polynomial fitting
PlotFlag = 1; % flag for result display, 1 for yes, 0 for no
LineColor = [1 0 0;0 1 0;0 0 1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Rage = RealData(:,1); % age in real data
RLV = [RealData(:,3)./RealData(:,2)].*100; % % volume of lateral ventricle in real data
Sage = SynData(:,1); % age in real data
SLV = [SynData(:,3)./SynData(:,2)].*100; % % volume of lateral ventricle in real data
Xaxis = [min(Rage):0.01:max(Rage)];
if PlotFlag
   scatter(Rage, RLV, 'r'); xlabel('Age'); ylabel('% volume of lateral ventricle'); hold on;
end
for i = Norder
    [P, S] = polyfit(Rage,RLV, i);
    [y1, delta] = polyval(P,Xaxis, S);
    if PlotFlag
        titlestring = ['polynominal fit'];
        plot(Xaxis, y1, 'Color', LineColor(i,:));
        title(titlestring);
    end
    Rs(i,1) = S.rsquared;
end
if PlotFlag
    hold off;
end
LastNorder = i;
[Rs, Mo] = min(Rs);
sprintf('The mininum r squre is %d and selected model order is %d ', Rs, Mo)
RPall = []; SPall = []; % parameters of fitted model with real and synthetic data
for i = 1:Nboost
    Rindex = randperm(size(RLV,1), Nsample);
    AgeTemp = Rage(Rindex);
    RLVTemp = RLV(Rindex);
    SLVTemp = SLV(Rindex);
    [RP, RS] = polyfit(AgeTemp,RLVTemp, Mo);
    [SP, SS] = polyfit(AgeTemp, SLVTemp, Mo);
    RPall = [RPall; RP]; SPall = [SPall; SP];
    sprintf('%d th estimation of real data ended', i)
end

for i = 1: Mo+1
    [h,p,ci,stats] = ttest2(RPall(:,i), SPall(:,i)); % 2 sample t-test of estimated paramters
    if PlotFlag
        titlestring = ['Averaged estimated parameter ' num2str(i)];
        x = 1:2;
        data = [mean(RPall(:,i)) mean(SPall(:,i))]';
        Err = [std(RPall(:,i)) std(SPall(:,i))];
        errhigh = Err./2;
        errlow  = Err./2;
        F = figure(LastNorder+i);
        bar(x,data ,'FaceColor', [0.5 0.5 0.5]);
        title(titlestring);
        hold on
        er = errorbar(x,data,errlow,errhigh);
        set(gca,'XTick',[1 2],'XTickLabel',{'From Real data','From Synthetic data'});
        er.Color = [0 0 0];
        er.LineStyle = 'none';
        hold off
    end
    if p > 0.05
        sprintf('The parameter %d of fitted models from real and synthetic data is not statistically different(p = %f ).', i, p)
    else
        sprintf('The parameter %d of fitted models from real and synthetic data is statistically different(p = %f ).', i, p)
    end
end
