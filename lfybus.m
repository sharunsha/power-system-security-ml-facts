%  This program obtains th Bus Admittance Matrix for power flow solution

% %                      Line code
% %         Bus bus   R      X     1/2 B   = 1 for lines
% %         nl  nr  p.u.   p.u.   p.u.     > 1 or < 1 tr. tap at bus nl 
% 
% linedata=[1   2   0.02   0.06   0.030    1
%           1   3   0.08   0.24   0.025    1
%           2   3   0.06   0.18   0.020    1
%           2   4   0.06   0.18   0.020    1
%           2   5   0.04   0.12   0.015    1
%           3   4   0.01   0.03   0.010    1
%           4   5   0.08   0.24   0.025    1
%           ];  

      
j=sqrt(-1); i = sqrt(-1);
nl = linedata(:,1); nr = linedata(:,2); R = linedata(:,3);
X = linedata(:,4); Bc = j*linedata(:,5); a = linedata(:, 6);
nbr=length(linedata(:,1)); nbus = max(max(nl), max(nr));
Z = R + j*X; y= ones(nbr,1)./Z;        %branch admittance


for n = 1:nbr
if a(n) <= 0  a(n) = 1; else end
Ybus=zeros(nbus,nbus);     % initialize Ybus to zero
               % formation of the off diagonal elements
for k=1:nbr;
       Ybus(nl(k),nr(k))=Ybus(nl(k),nr(k))-y(k)/a(k);
       Ybus(nr(k),nl(k))=Ybus(nl(k),nr(k));
    end
end
              % formation of the diagonal elements
for  n=1:nbus
     for k=1:nbr
         if nl(k)==n
         Ybus(n,n) = Ybus(n,n)+y(k)/(a(k)^2) + Bc(k);
         elseif nr(k)==n
         Ybus(n,n) = Ybus(n,n)+y(k) +Bc(k);
         else, end
     end
end
Ybus;
