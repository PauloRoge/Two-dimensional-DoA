function Y = signals(Mx, My, snapshots, delta, lambda, AoA, Elev, d, ...
    source, power, noisepowerdBm, alpha)
    noisepower = 10^((noisepowerdBm - 30) / 10); % Convert dBm to Watts
    M = Mx * My; % Total number of antennas
    H = zeros(M, source);

    % Constante de path loss (Upsilon) com expoente de perda
    Upsilon = (lambda / (4 * pi))^alpha;
    
    % Compute channel matrix with far-field steering vector
    for s = 1:source
        A = responsearray(Mx, My, delta, lambda, Elev(s), AoA(s)); % steering vector
        g = sqrt(Upsilon * (1/d(s))^alpha);
        H(:, s) = g * A; % mssume unit path loss in far-field
    end
    
    X = sqrt(power) * randn(source, snapshots) / sqrt(2); % Transmitted signals
    Z = sqrt(noisepower) * (randn(M, snapshots) + 1j * randn(M, snapshots)) / sqrt(2); % AWGN noise
    Y = H * X + Z; % Received signal matrix
    
    % Compute and display SNR
    SNR = 10 * log10(sum(abs(Y).^2, 'all') / sum(abs(Z).^2, 'all'));
    disp(['SNR = ', num2str(SNR), ' dB']);
end
