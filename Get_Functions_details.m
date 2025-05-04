function [lb,ub,dim,fobj] = Get_Functions_details(F)
global data data1 B

switch F
    case 'ceed'              
        fobj = @ceed;
        lb =data(:,4)';   % Lower bound
        ub = data(:,5)';  % Upper bound
        dim=54;
end
end

% F1

function o = ceed(x)
global data Pd data1 B 
x=abs(x);
n=length(data(:,1));
P1=x;
for i=1:n
   
      F1(i)=data(i,1)* P1(i)^2+data(i,2)*P1(i)+data(i,3);
%       E1(i)=data(i,1)* P1(i)^2+data(i,2)*P1(i)+data(i,3);
%       F1max(i)=data(i,1)*data(i,5)^2+data(i,2)*data(i,5)+data(i,3);
%       E1max(i)=data1(i,1)*data1(i,5)^2+data1(i,2)*data1(i,5)+data1(i,3);
%       h(i)=F1max(i)/E1max(i);
      ceed(i)=F1(i);%for Economic Dispatch
%        ceed(i)=E1(i);%for Emission Dispatch
%      ceed(i)=F1(i)+h(i)*E1(i);%For CEED


end

lam=abs(sum(P1)-Pd);
o=sum(ceed)+1000*lam;

end

