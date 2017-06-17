function fts = scaled_fts(I)
    no_target_patches = 4000;
    entropy_thresh = 2.0;
%    sizes = [11, 23];
    sizes = [33];
    fts = [];
    
    for i = 1 : length(sizes)
        w = sizes(i);
        
        P = getPatchesDict(I, w, entropy_thresh);
        noPatches = size(P,2);
        if(noPatches < no_target_patches)
            patchIndcs = randsample(noPatches,noPatches);
        else
            patchIndcs = randsample(noPatches,no_target_patches);
        end    
        Xt = P(:,patchIndcs);
        
        
        [Pt, alpha, ~] = pca(Xt');
        f = sprintf('../../source/Source_PCA_w%d.mat', w);
        data = load(f);
        Ps = data.s_coeff;
        
    % Params
        d = floor(w^2/2);
        D = w^2;
    % Upper Interaction Matrix
        Psu = Ps(:, 1 : d);
        Ptu = Pt(:, 1 : d);
        Gu = GFK(Psu, Ptu);
        [Uu, Gammau, ~] = svd(Gu);
        Mu = Uu*(Gammau.^0.5);
        ftu = norm(Mu(:), 1);
    % Lower Interaction Matrix
        %str = sprintf('d = %d, D = %d', d, D);
        %disp(str);
        %size(Pt)
        Psl = Ps(:, d+1 : D-1);
        Ptl = Pt(:, d+1 : D-1);
        Gl = GFK(Psl, Ptl);
        [Ul, Gammal, ~] = svd(Gl);
        Ml = Ul*(Gammal.^0.5);
        ftl = norm(Ml(:), 1);
    % Subspace Alignment
        M = Pt' * Ps;
        score = norm(M(:), 1);
        score_sa = 100*score/(length(M)^2);
    % Global Score
        theta = sangle(Ps, Pt);
        score_g = norm(theta);
    % Local Score
        theta = sangle(Ps,Pt)*10^9;
        thetaE = alpha .* repmat(theta', [size(alpha,1),1]);
        score_l = mean(sqrt(diag(thetaE*thetaE')));

        fts = [fts, ftu, ftl, score_sa, score_g, score_l];
    end
end