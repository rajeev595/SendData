function target_main
% main file for the target set
    w = 11;
    mkdir('..', 'results');
    DataForScores = 'F:/MATLABf/GeoPath_Gist_6C/target/results/';
    PathToResults = '../results/';
    tic
    %clear all
    %close all
     
    no_target_patches = 4000; % number of target patches
    entropy_thresh = 3;
    
% extract patches and save in the result folder
    data = 1;
    for distortion = 2
        %getTargetPatches(w,no_target_patches,entropy_thresh,distortion,data, MainPath);
        %doTargetPCA(distortion,data, MainPath);
        %getScores(distortion,data,DataForScores,PathToResults);
        spearmanScore(distortion,data,PathToResults);       
    end
end    