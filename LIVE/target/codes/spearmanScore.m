function spearmanScore(distortion,data,PathToResults)

    if(data == 1)
        load('E:/MATLABe/GeoPath/Database/LIVE/dmos.mat');
        if(distortion == 1)
        % Path to Correlation Scores
            pathToScores = strcat(PathToResults,'LIVE/jp2k/');
            dmos = dmos(1 : 227);
            orgs = orgs(1 : 227);
        elseif(distortion == 2)
        % Path to Correlation Scores            
            pathToScores = strcat(PathToResults,'LIVE/jpeg/');
            dmos = dmos(228 : 460);
            orgs = orgs(228 : 460);
        elseif(distortion == 3)
        % Path to Correlation Scores        
            pathToScores = strcat(PathToResults,'LIVE/wn/');
            dmos = dmos(461 : 634);
            orgs = orgs(461 : 634);
        else
        % Path to Correlation Scores            
            pathToScores = strcat(PathToResults,'LIVE/gblur/');
            dmos = dmos(635 : 808);
            orgs = orgs(635 : 808);
        end
    elseif(data == 2)
    elseif(data == 3)
    end

% Indices of distorted Images
    distIndcs = find(~orgs);

% DMOS values for only distorted images
    dmos = dmos(1, distIndcs);
    f = strcat(pathToScores,'QualityScores.mat');   % Adding Path to scores name
    load(f);                                        % Loading the Scores
    scores = scores(distIndcs, :);                  % Considering only distorted Images

    sroccEM = [];
    mseM = [];
     for iter = 1 : 100
         n = size(scores, 1);
         k = floor(0.2 * n);
         indcs = randperm(n, k);
         scores_iter = scores(indcs, :);
         dmos_iter = dmos(:, indcs);
         sroccE = corr(scores_iter, dmos_iter', 'Type', 'Spearman');
         sroccEM = [sroccEM; sroccE];
         %mseM = [mseM; mse];
         
         str = sprintf('%d iterations done! \n', iter);
         disp(str)
     end

%     for iter = 1 : 100
%         n = size(scores, 1);
%         k = floor(0.2 * n);
%         [~,indcs] = sort(dmos, 'ascend');
%         indcs = indcs(1 : k);
%         
%         dmos_iter = dmos(:, indcs);
%         scores_iter = scores(indcs, :);
%         mse = norm(scores_iter-dmos_iter', 2);
%         sroccE = corr(scores_iter, dmos_iter', 'Type', 'Spearman');
%         sroccEM = [sroccEM; sroccE];
%         mseM = [mseM; mse];
%     end

% Correlation of Global+Local scores    
    f = strcat(pathToScores, 'CorrScores.mat');
    save(f, 'sroccEM');
    
    str = sprintf('mean = %d, median = %d, std = %d \n', mean(sroccEM), median(sroccEM), std(sroccEM));
    disp(str);    
end