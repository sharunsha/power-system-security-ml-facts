% Fvsi_index computes the FVSI voltage stability index 
fprintf('\n') 
fprintf(' Voltage Collapse Proximity Line Index \n\n') 
fprintf(' Line From To FVSI \n') 
fprintf(' No. Bus Bus \n') 
del = 0; theta=0; den=0; Fvsi=0; Qj=0; 
for k = 1 : nbr 
 denf(k) = V(nl(k))^2*X(k); 
 %Qj(k) = imag(Spq(k(k>0)))/basemva; 
 Fvsi(k) =abs(4*(Z(k)^2)*Qr(k(k>0))/denf(k)); 
 fprintf(' %5g', k), fprintf(' %5g', nl(k)), fprintf(' %5g', nr(k)), fprintf(' %7.5f\n', Fvsi(k)) 
end 
 
FVSI=Fvsi'




