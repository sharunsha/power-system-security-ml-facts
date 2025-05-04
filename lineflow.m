%  This program is used in conjunction with lfgauss or lf Newton
%  for the computation of line flow and line losses.
SLT = 0;
count = 1;
count1 = 1;
count2=1;
fprintf('\n')
fprintf('                           Line Flow and Losses \n\n')
fprintf('     --Line--  Power at bus & line flow    --Line loss--  Transformer\n')
fprintf('     from  to    MW      Mvar     MVA       MW      Mvar      tap\n')

for n = 1:nbus
    busprt = 0;
    for L = 1:nbr;
        if busprt == 0
            fprintf('   \n'), fprintf('%6g', n), fprintf('      %9.4f', P(n)*basemva)
            fprintf('%9.4f', Q(n)*basemva), fprintf('%9.4f\n', abs(S(n)*basemva))

            busprt = 1;
        end
        if nl(L)==n
            k = nr(L);
            In = (V(n) - a(L)*V(k))*y(L)/a(L)^2 + Bc(L)/a(L)^2*V(n);
            Ik = (V(k) - V(n)/a(L))*y(L) + Bc(L)*V(k);
            Snk = V(n)*conj(In)*basemva;
            Skn = V(k)*conj(Ik)*basemva;
            Qs(count1) = imag(Snk)/100;
            Ps(count1) = real(Snk)/100;
            Qr(count1) = imag(Skn)/100;
            Pr(count1) = real(Skn)/100;
            count1 = count1 + 1;
            Pline=Ps;
            Pline(Ps<0)=Pr(Ps<0);
            Qline=Qs;
            Qline(Qs<0)=Qr(Qs<0);

            SL  = Snk + Skn;
            SLT = SLT + SL;
       elseif nr(L)==n
            k = nl(L);
            In = (V(n) - V(k)/a(L))*y(L) + Bc(L)*V(n);
            Ik = (V(k) - a(L)*V(n))*y(L)/a(L)^2 + Bc(L)/a(L)^2*V(k);
            Snk = V(n)*conj(In)*basemva;
            Skn = V(k)*conj(Ik)*basemva;
            
%             count = count + 1;
            SL = Snk + Skn;
            SLT = SLT + SL;
            
        end
        
            
         if nl(L)==n || nr(L)==n
            fprintf('%12g', k),
            fprintf('%9.4f', real(Snk)), fprintf('%9.4f', imag(Snk))
            fprintf('%9.4f', abs(Snk)),
            fprintf('%9.4f', real(SL)),
            
         
            if nl(L) ==n && a(L) ~= 1
                fprintf('%9.4f', imag(SL)), fprintf('%9.4f\n', a(L))
            else
                fprintf('%9.4f\n', imag(SL))
             end
         end
    end
end
SLT = SLT/2;
fprintf('   \n'), fprintf('    Total loss                         ')
fprintf('%9.4f', real(SLT)), fprintf('%9.4f\n', imag(SLT))
% clear Ik In SL SLT Skn
