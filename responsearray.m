function steeringvector = responsearray(Mx, My, delta, lambda, theta, phi)
    % Compute the far-field steering vector for a URA
    % Mx, My: Number of antennas in x and y directions
    % delta: Antenna spacing
    % lambda: Wavelength
    % theta: elevation angle (degrees)
    % phi: azimuth angle (degrees)
    
    theta_rad = deg2rad(theta); % Convert angles to radians
    phi_rad = deg2rad(phi);
    gamma = 2 * pi / lambda; % Wavenumber
    
    % Antenna indices in the URA
    [mx, my] = meshgrid(0:Mx-1, 0:My-1);
    mx = mx(:); my = my(:);
    
    % Far-field steering vector (planar wave approximation)
    phase_term = gamma * delta * (mx * sin(theta_rad) * cos(phi_rad) + my * sin(theta_rad) * sin(phi_rad));
    steeringvector = exp(1j * phase_term);

end
