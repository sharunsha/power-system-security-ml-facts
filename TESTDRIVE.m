%% IEEE30T: IEEE30 Transmission bus system  
clc
clear
basemva = 100;  accuracy = 0.001; accel = 1.8; maxiter = 100; 

%        IEEE 30-BUS TEST SYSTEM (American Electric Power)
%        Bus Bus  Voltage Angle   ---Load---- -------Generator----- Static Mvar
%        No  code Mag.    Degree  MW    Mvar  MW  Mvar Qmin Qmax    +Qc/-Ql
busdata=[
         1   1    1.06    0.0     0.0   0.0    0.0  0.0   0   0       0
         2   2    1.043   0.0   21.70  12.7   40.0  0.0 -40  50       0
         3   0    1.0     0.0     2.4   1.2    0.0  0.0   0   0       0
         4   0    1.06    0.0     7.6   1.6    0.0  0.0   0   0       0
         5   2    1.01    0.0    94.2  19.0    0.0  0.0 -40  40       0
         6   0    1.0     0.0     0.0   0.0    0.0  0.0   0   0       0
         7   0    1.0     0.0    22.8  10.9    0.0  0.0   0   0       0
         8   2    1.01    0.0    30.0  30.0    0.0  0.0 -30  40       0
         9   0    1.0     0.0     0.0   0.0    0.0  0.0   0   0       0
        10   0    1.0     0.0     5.8   2.0    0.0  0.0    0  0      19
        11   2    1.082   0.0     0.0   0.0    0.0  0.0   -6  24       0
        12   0    1.0     0       11.2  7.5    0    0     0   0       0
        13   2    1.071   0        0    0.0    0    0    -6  24       0
        14   0    1       0       6.2   1.6    0    0     0   0       0
        15   0    1       0       8.2   2.5    0    0     0   0       0
        16   0    1       0       3.5   1.8    0    0     0   0       0
        17   0    1       0       9.0   5.8    0    0     0   0       0
        18   0    1       0       3.2   0.9    0    0     0   0       0
        19   0    1       0       9.5   3.4    0    0     0   0       0
        20   0    1       0       2.2   0.7    0    0     0   0       0
        21   0    1       0      17.5  11.2    0    0     0   0       0
        22   0    1       0       0     0.0    0    0     0   0       0
        23   0    1       0       3.2   1.6    0    0     0   0       0
        24   0    1       0       8.7   6.7    0    0     0   0      4.3
        25   0    1       0       0     0.0    0    0     0   0       0
        26   0    1       0       3.5   2.3    0    0     0   0       0
        27   0    1       0       0     0.0    0    0     0   0       0
        28   0    1       0       0     0.0    0    0     0   0       0
        29   0    1       0       2.4   0.9    0    0     0   0       0
        30   0    1       0      10.6   1.9    0    0     0   0       0];

%                                        Line code
%         Bus bus   R      X     1/2 B   = 1 for lines
%         nl  nr  p.u.   p.u.   p.u.     > 1 or < 1 tr. tap at bus nl
linedata=[
          1   2   0.0192   0.0575   0.02640    1
          1   3   0.0452   0.1852   0.02040    1
          2   4   0.0570   0.1737   0.01840    1
          %3   4   0.0132   0.0379   0.00420    1
          2   5   0.0472   0.1983   0.02090    1
          2   6   0.0581   0.1763   0.01870    1
          4   6   0.0119   0.0414   0.00450    1
          5   7   0.0460   0.1160   0.01020    1
          6   7   0.0267   0.0820   0.00850    1
          6   8   0.0120   0.0420   0.00450    1
          6   9   0.0      0.2080   0.0    0.978
          6  10   0         .5560   0      0.969
          9  11   0         .2080   0          1
          9  10   0         .1100   0          1
          4  12   0         .2560   0      0.932
         12  13   0         .1400   0          1
         12  14    .1231    .2559   0          1
         12  15    .0662    .1304   0          1
         12  16    .0945    .1987   0          1
         14  15    .2210    .1997   0          1
         16  17    .0824    .1923   0          1
         15  18    .1073    .2185   0          1
         18  19    .0639    .1292   0          1
         19  20    .0340    .0680   0          1
         10  20    .0936    .2090   0          1
         10  17    .0324    .0845   0          1
         10  21    .0348    .0749   0          1
         10  22    .0727    .1499   0          1
         21  22    .0116    .0236   0          1
         15  23    .1000    .2020   0          1
         22  24    .1150    .1790   0          1
         23  24    .1320    .2700   0          1
         24  25    .1885    .3292   0          1
         25  26    .2544    .3800   0          1
         25  27    .1093    .2087   0          1
         28  27     0       .3960   0      0.968
         27  29    .2198    .4153   0          1
         27  30    .3202    .6027   0          1
         29  30    .2399    .4533   0          1
          8  28    .0636    .2000   0.0214     1
          6  28    .0169    .0599   0.065      1
];
 

G(1)=0.4; G(2)=0.2; G(3)=0.4;
lfybus                            % form the bus admittance matrix
lfnewton2          % Load flow solution by Newton-Raphson method
busout              % Prints the power flow solution on the screen
lineflow   
LSindex% computes and displays the line flow and losses

%  Lmn_index_1 
%  
% % %Fvsi_index 
%  Fvsi_index_1 
 NCPI_index_3 
% % % %Hybrid_index 
% % Hybrid_index_1
% 
% 
% 
% % NCPI_index_3
% 
% fprintf('\n') 
% fprintf(' Voltage Collapse Proximity Line Indices \n\n') 
% fprintf(' Line From To Lmn \n  Fvsi \n     Hsi \n    NCPI \n  ') 
% fprintf(' No. Bus Bus \n') 
% for k = 1 : nbr 
% %  fprintf(' %5g', k), fprintf(' %5g', nl(k)), printf(' %5g',nr(k)), fprintf(' %7.5f', Lmn(k)),      
% %          fprintf(' %7.5f', Fvsi(k)),  fprintf(' %7.5f', Hsi(k),fprintf(' %7.5f', NCPI(k) )
%                                       
%         disp('Table using disp command'),disp(' k     nl(k)     nr(k)    Lmn(k) Fvsi(k) Hsi(k)  NCPI(k)' )
%         disp([k', nl(k)', nr(k)', Lmn(k)', Fvsi(k)',Hsi(k)',NCPI(k)'])
% end 
%       
% 
%  timeforcomputing = toc(tic)


