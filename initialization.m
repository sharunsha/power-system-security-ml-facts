


%  Student psychology based optimization (SPBO)algorithm 
%
%  Source codes demo version 1.0                                                                      
%                                                                                                     
%  Developed in MATLAB R2017b                                                                  
%                                                                                                     
%  Author and programmer: Bikash Das, V. Mukherjee, D. Das                                                         
%                                                                                                     
%         e-Mail: bcazdas@gmail.com, vivek_agamani@yahoo.com, ddas@ee.iitkgp.ernet.in                                               
%                                                                                                                                                             
%                                                                                                     
%  Main paper:                                                                                        
%  Bikash Das, V Mukherjee, Debapriya Das, Student psychology based optimization algorithm: A new population based
%   optimization algorithm for solving optimization problems, Advances in Engineering Software, 146 (2020) 102804.
%_______________________________________________________________________________________________
% You can simply define your objective function in a seperate file and load its handle to fobj 
% The initial parameters that you need are:
%__________________________________________
% fobj = @Objective function
% variable = number of your variables
% Max_iteration = maximum number of iterations
% student = number of search agents
% mini=[mini1,mini2,...,minin] where mini is the lower bound of variable n
% maxi=[maxi1,maxi2,...,maxin] where maxi is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define mini and maxi as two single numbers

% To run SPBO: [Best_fitness,Best_student,Convergence_curve]=SPBO(student,Max_iteration,mini,maxi,variable,fobj)
%______________________________________________________________________________________________





function X=initialization(student,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

% If the boundaries of all variables are equal and user enter a single number for both ub and lb
if Boundary_no==1
    X=lb+rand(student,dim).*(ub-lb);
end
%display (X);

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        X(:,i)=lb_i+rand(student,1).*(ub_i-lb_i);
    end
end