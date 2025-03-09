function musicpseudospectrum = music(Y, Mx, My, theta, phi, snapshots, delta, lambda, source)
    R = (Y * Y') / snapshots; % covariance matrix
    [eigenvectors, eigenvalues] = eig(R);
    
    estimated_sources = source;
    [~, i] = sort(diag(eigenvalues), 'descend'); % seleciona subespaço de ruido
    eigenvectors = eigenvectors(:, i);
    Vn = eigenvectors(:, estimated_sources+1:end);
    
    Pmusic = zeros(length(theta), length(phi));
    
    for i = 1:length(theta)
        for j = 1:length(phi)
            a = responsearray(Mx, My, delta, lambda, theta(i), phi(j));
            Pmusic(i, j) = 1 / (a' * (Vn * Vn') * a);
        end
    end
    
    Pmusic = abs(Pmusic) / max(abs(Pmusic(:))); % normalize spectrum
    musicpseudospectrum = Pmusic;
end
