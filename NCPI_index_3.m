
% NCPI_index computes the NCPI voltage stability index
fprintf('\n')
fprintf(' Voltage Collapse Proximity Line Index (NCPI) \n\n')
fprintf(' Line    From    To      NCPI \n')
fprintf(' No.     Bus     Bus\n')
 
% Initialize necessary variables
del = 0; theta = 0; den = 0; NCPI = 0; 
Pj = zeros(1, nbr); % Initialize Pj array
Fvsi = zeros(1, nbr); % Assuming FVSI data is loaded from previous calculation
epsilon = 1e-6; % Small epsilon to prevent division by zero
 
% Loop through each line to calculate NCPI
for k = 1 : nbr
    % Recalculate Snk based on bus voltage differences for each line
    In = (V(nl(k)) - V(nr(k))) * (Z(k) / (Z(k)^2 + X(k)^2 + epsilon));
    Snk = V(nl(k)) * conj(In) * basemva; % Calculate power flow at the sending end of line
 
%     % Calculate real power at bus j (Pj) normalized by base MVA
%     Pj(k) = real(Snk) / basemva;
%   % Calculate terms for NCPI formula
%     denf_k = V(nl(k))^4 * X(k)^2 + epsilon; % Denominator with epsilon
% 
%     % Calculate the NCPI based on the provided formula
%     NCPI(k) = abs((4 * Z(k)^4 * Pj(k)^4) / denf_k) + Fvsi(k);
 
 % Calculate terms for NCPI formula
    A1=[4*Z(k)^4]/[X(k)* V(nl(k))^2];
    B1=[[Z(k)^2]*[Pr(k(k>0))]]/[[X(k)* V(nl(k))^2]];
    C1=Qr(k(k>0));
    NCPI(k)=abs(A1*[B1+C1]);
    % Display results
    fprintf(' %5g', k), fprintf(' %5g', nl(k)), fprintf(' %5g', nr(k)), fprintf(' %10.5f\n', NCPI(k))
end