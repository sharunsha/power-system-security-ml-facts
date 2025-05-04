
clc
clear variables

tic
Demand=[ 254.754 271.7376 283.06 297.213 311.366 325.519 367.978 396.284 328.3496 410.437 424.59 438.743 339.672 317.0272 291.5518 ];
g=[];
for xx=1:length(Demand)
global data Pd data1 B


%Plant data 
%no of rows denote the no of plants(n)
data=[
0	2	    0.0038	50	200
0	1.75	0.0175	20	80
0	1	    0.0625	15	50
0	3.25	0.0083	10	35
0	3	    0.025	10	30
0	3	    0.025	12	40
];
B=[
0.0217567964194053	0.0101821197388180	0.000868070544990643	-0.000726291245396378	0.00030291145434254  0.00359945773539635
0.0101821197388180	0.0177794441196245	0.000300457315787794	-0.00104544408175092	0.000285055367631795 0.00269032157410565
0.000868070544990645	0.000300457315787796	0.0408033243745644	-0.00962753103279484	-0.0139210208291539 -0.00323562920676142
-0.000726291245396346	-0.00104544408175090	-0.00962753103279483	0.0174319386210514	0.00750173945981064  0.00303354693722727
0.000302911454342530	0.000285055367631779	-0.0139210208291539	0.00750173945981063	0.0211764722597860  -0.000206077233885390
0.00359945773539634	0.00269032157410565	-0.00323562920676141	0.00303354693722725	-0.000206077233885397 0.0238159905657278
];


% Demand (MW)
disp('The Power Demand');
Pd=Demand(xx);
LB =data(:,4)';   % Lower bound
UB = data(:,5)';  % Upper bound

%--------------------------------------------------------------------------------------------------
nVar=3;

SearchAgents_no=50;
 % Number of search agents

Function_name='ceed'; 

Max_iteration=100;    % Maximum numbef of iterations

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);

[fMin,bestX,SSA_curve]=SSA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);  

%Draw objective space
% figure(xx)
% plot(SSA_curve,'Color','g')
% title('Objective space')
% xlabel('Iteration');
% ylabel('Best score obtained so far');
% %axis tight
% grid on
% box on
% legend('SSA')

n=length(data(:,1));
disp('The Power Generation obtained by SSA');
PG=bestX
P1=bestX(1);
% P2=bestX(2);% P3=bestX(3);% P4=bestX(4);% P5=bestX(5);
% P6=bestX(6);% P7=bestX(7);% P8=bestX(8);% P9=bestX(9);
% P10=bestX(10);% P11=bestX(11);% P12=bestX(12);
% P13=bestX(13);% P14=bestX(14);% P15=bestX(15);
% P16=bestX(16);% P17=bestX(17);% P18=bestX(18);% P19=bestX(19);

for i=1:n
      F1(i)=data(i,1)* PG(i)^2+data(i,2)*PG(i)+data(i,3);
%       E1(i)=data(i,1)* PG(i)^2+data(i,2)*PG(i)+data(i,3);
%      F1max(i)=data(i,1)*data(i,5)^2+data(i,2)*data(i,5)+data(i,3);
%       E1max(i)=data1(i,1)*data1(i,5)^2+data1(i,2)*data1(i,5)+data1(i,3);
%         h(i)=F1mmax(i)/E1max(i);
%       F1max(i)=data(i,1)*data(i,5)^2+data(i,2)*data(i,5)+data(i,3);
%       E1min(i)=data1(i,1)*data1(i,4)^2+data1(i,2)*data1(i,4)+data1(i,3);
%        h(i)=F1max(i)/E1min(i);
%       F1min(i)=data(i,1)*data(i,4)^2+data(i,2)*data(i,4)+data(i,3);
%       E1max(i)=data1(i,1)*data1(i,5)^2+data1(i,2)*data1(i,5)+data1(i,3);
%          h(i)=F1min(i)/E1max(i);
%       F1min(i)=data(i,1)*data(i,4)^2+data(i,2)*data(i,4)+data(i,3);
%       E1min(i)=data1(i,1)*data1(i,4)^2+data1(i,2)*data1(i,4)+data1(i,3)
%       h(i)=F1min(i)/E1min(i);
      ceed(i)=F1(i);%for Economic Dispatch
%       ceed(i)=E1(i);%for Emission Dispatch
%       ceed(i)=F1(i)+h(i)*E1(i);%For CEED
      
end

ploss_1=0;ploss_2=0;
for i=1:length(B)
    ploss_1=ploss_1+(B(i,i)*(PG(i)^2));
end

for i=1:length(B)
    for j=1:length(B)
        if i~=j
            ploss_2=ploss_2+((B(i,j)*B(j,i))*(PG(i)*PG(j)));
        end
    end
end

P1 = P1+ploss_1+ploss_2;
lam=abs(sum(P1)-Pd);
disp('The Total Fuelcost found by SSA is : ');
 o=sum(ceed)% Without RES
%o=sum(ceed)+0.1095*10^3*PV(xx);% Without Wind
%o=sum(ceed)+0.1368*10^3*WT(xx)%Without Soloar
%  o=sum(ceed)+0.1368*10^3*WT(xx)+0.1095*10^3*PV(xx);
% l2=zeros(length(PG));
% for i=1:length(B)
%     for j=1:length(B)
%             l2(i)=(B(i,j)*B(j,i))*(PG(i)*PG(j));
%     end
% end

g=[g;PG];

Final(xx,:)=[ xx Pd PG o];

end
disp('.....Time      Demand     P1        P2      P3    P4     P5       P6     Fuelcost......... ');
Final
total_cost=sum(Final(:,6))
