function getScores(distortion, data, PathToData, PathToResults)
    if(data == 1)
        mkdir(PathToResults,'LIVE');
        if(distortion == 1)
            mkdir(strcat(PathToResults,'LIVE'),'jp2k');
            PathToScores = strcat(PathToResults,'LIVE/jp2k/');          % Path to Scores
            PathToPatches = strcat(PathToData,'LIVE/jp2k/patches/');    % Path to Patches        
            PathToPCA = strcat(PathToData,'LIVE/jp2k/PCA/');            % Path to PCA
            PathToImgs = 'E:/MATLABe/GeoPath/Database/LIVE/data/jp2k/'; % Path to Images
            noImages = 227;
        elseif(distortion == 2)
            mkdir(strcat(PathToResults,'LIVE'),'jpeg');
            PathToScores = strcat(PathToResults,'LIVE/jpeg/');          % Path to Scores
            PathToPatches = strcat(PathToData,'LIVE/jpeg/patches/');    % Path to Patches        
            PathToPCA = strcat(PathToData,'LIVE/jpeg/PCA/');            % Path to PCA
            PathToImgs = 'E:/MATLABe/GeoPath/Database/LIVE/data/jpeg/'; % Path to Images            
            noImages = 233;
        elseif(distortion == 3)
            mkdir(strcat(PathToResults,'LIVE'),'wn');
            PathToScores = strcat(PathToResults,'LIVE/wn/');            % Path to Scores
            PathToPatches = strcat(PathToData,'LIVE/wn/patches/');      % Path to Patches        
            PathToPCA = strcat(PathToData,'LIVE/wn/PCA/');              % Path to PCA
            PathToImgs = 'E:/MATLABe/GeoPath/Database/LIVE/data/wn/';   % Path to Images            
            noImages = 174;
        else
            mkdir(strcat(PathToResults,'LIVE'),'gblur');
            PathToScores = strcat(PathToResults,'LIVE/gblur/');         % Path to Scores
            PathToPatches = strcat(PathToData,'LIVE/gblur/patches/');   % Path to Patches        
            PathToPCA = strcat(PathToData,'LIVE/gblur/PCA/');           % Path to PCA
            PathToImgs = 'E:/MATLABe/GeoPath/Database/LIVE/data/gblur/';% Path to Images            
            noImages = 174;
        end
    elseif(data == 2)
    elseif(data == 3)
    end

% Loading the trained SVR Model
    load('../../source/IQA_SVR_Model.mat');
    
    scores = [];
    
    for i = 1 : noImages
    %% Processing the image        
        img = sprintf('img%d.bmp',i);               % Reading the image name
        img = strcat(PathToImgs,img);               % Adding path of image to name   
        I = imread(img);                            % Reading the image  
        I = rgb2gray(I);                            % Converting the Color image to Grayscale
    %% Extracting the features
    % Display
        str = sprintf('Calculating Score for %d/%d image! \n', i, noImages);
        disp(str);        
        ft = scaled_fts(I);
    %% Score Calculation
        ftr = normr(ft);
        score = predict(Mdl,ftr);
    % Adding to the scores matrix
        scores = [scores; score];        
    end
% Saving the Scores
    saveScore = strcat(PathToScores, 'QualityScores.mat');
    save(saveScore, 'scores');
end