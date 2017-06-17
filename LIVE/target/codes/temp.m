% JP2K
load('../../source/IQA_SVR_Sigmoid_Model.mat');
load('features_1.mat');
fts = [fts(:, 1).*fts(:, 3), fts(:, 1).*fts(:, 5), fts(:, 1).*fts(:, 7), fts(:, 3).*fts(:, 5),...
    fts(:, 3).*fts(:, 7), fts(:, 5).*fts(:, 7)];
Y = rand(size(fts, 1), 1);
Xr = normr(fts);
[scores, ~, ~] = svmpredict(Y, Xr, model,'-q');
save('../results/LIVE/jp2k/QualityScores.mat', 'scores');
% JPEG
load('../../source/IQA_SVR_Sigmoid_Model.mat');
load('features_2.mat');
fts = [fts(:, 1).*fts(:, 3), fts(:, 1).*fts(:, 5), fts(:, 1).*fts(:, 7), fts(:, 3).*fts(:, 5),...
    fts(:, 3).*fts(:, 7), fts(:, 5).*fts(:, 7)];
Y = rand(size(fts, 1), 1);
Xr = normr(fts);
[scores, ~, ~] = svmpredict(Y, Xr, model,'-q');
save('../results/LIVE/jpeg/QualityScores.mat', 'scores');
% AWGN
load('../../source/IQA_SVR_Sigmoid_Model.mat');
load('features_3.mat');
fts = [fts(:, 1).*fts(:, 3), fts(:, 1).*fts(:, 5), fts(:, 1).*fts(:, 7), fts(:, 3).*fts(:, 5),...
    fts(:, 3).*fts(:, 7), fts(:, 5).*fts(:, 7)];
Y = rand(size(fts, 1), 1);
Xr = normr(fts);
[scores, ~, ~] = svmpredict(Y, Xr, model,'-q');
save('../results/LIVE/wn/QualityScores.mat', 'scores');
% GBLUR
load('../../source/IQA_SVR_Sigmoid_Model.mat');
load('features_4.mat');
fts = [fts(:, 1).*fts(:, 3), fts(:, 1).*fts(:, 5), fts(:, 1).*fts(:, 7), fts(:, 3).*fts(:, 5),...
    fts(:, 3).*fts(:, 7), fts(:, 5).*fts(:, 7)];
Y = rand(size(fts, 1), 1);
Xr = normr(fts);
[scores, ~, ~] = svmpredict(Y, Xr, model,'-q');
save('../results/LIVE/gblur/QualityScores.mat', 'scores');