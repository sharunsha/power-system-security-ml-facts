%Stability indices code for case studies 
% Lmn_index computes the Lmn voltage stability line index 
fprintf('\n') 
% fprintf(' Voltage Collapse Proximity Line Index \n\n') 
% fprintf(' Line From To Lmn \n') 
% fprintf(' No. Bus Bus \n') 
del = 0; theta=0; den=0; LSI=0; Qj=0; 
for k = 1 : nbr 
 theta(k) = atand(X(k)/R(k)); 
 del(k) = (deltad(nl(k)) - deltad(nr(k))); 
 den(k) = (V(nl(k))*sind(theta(k) - del(k)))^2; 
 %Qj(k) = imag(Spq(k))/basemva; 
 LSI(k) = abs(4*X(k)*Qr(k)/den(k)); 
 %fprintf(' %5g', k), fprintf(' %5g', nl(k)), fprintf(' %5g', nr(k)), fprintf(' %7.5f\n', LSI(k)) 
end

Lmn=LSI';

D=table(nl,nr,Lmn);
 disp(D)