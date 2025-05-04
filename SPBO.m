

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
% lb=[mini1,mini2,...,minin] where mini is the lower bound of variable n
% ub=[maxi1,maxi2,...,maxin] where maxi is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define mini and maxi as two single numbers

% To run SPBO: [Best_fitness,Best_student,Convergence_curve]=SPBO(student,Max_iteration,lb,ub,dim,fobj)
%______________________________________________________________________________________________





function [Best_fitness,Best_student,Convergence_curve]=SPBO(student,Max_iteration,ub,lb,dim,fobj)

display('SPBO is optimizing your problem');

%Initialize the set of random solutions
X=initialization(student,dim,ub,lb);

sol=zeros(1,dim);
ans=inf;

Convergence_curve=zeros(1,Max_iteration);
Objective_values = zeros(1,size(X,1));

% Calculate the fitness of the first set and find the Best_fitness one
for i=1:student
    Objective_values(i,1)=fobj(X(i,:));
   
        sol(i,:)=X(i,:);
        ans(i,1)=Objective_values(i,1);
end
% display (sol);
% display (ans);

Best_fitness = min(ans);
for ft=1:1:student
    if Best_fitness==ans(ft,1)
        Best_student=sol(ft,:);
    end;
end;

%Main loop
 
for t=1:1:Max_iteration
    
   for do=1:1:dim
        
    sum=zeros(1,dim);
    for gw=1:1:dim
    for fi=1:1:student
        sum(1,gw)=sum(1,gw)+sol(fi,gw);
    end;
    mean(1,gw)=sum(1,gw)/student;
    end;
     par=sol;
     par1=sol;
    
  
    
     check=rand(student,1);
    mid=rand(student,1);
    for dw=1:1:student
       % Best Student
        if Best_fitness==ans(dw,1)
            
             jg=ans(randperm(numel(ans),1));
         
         for oi=1:1:student
             if jg==ans(oi,1)
                 lk=oi;
             end;
         end;
     
            par1(dw,do)=par(dw,do)+(((-1)^(round(1+rand)))*rand*(par(dw,do)-par(lk,do)));       % Equation (1)
           
        else if check(dw,1)<mid(dw,1)
         % Good Student
                rta=rand;
                if rta>rand
                    par1(dw,do)=Best_student(1,do)+(rand*(Best_student(1,do)-par(dw,do)));      % Equation (2a)
                else
                
                par1(dw,do)=par(dw,do)+(rand*(Best_student(1,do)-par(dw,do)))+((rand*(par(dw,do)-mean(1,do))));         % Equation (2b)
                end;
            else
                an=rand;
          % Average Student
                if rand>an
                    
                    par1(dw,do)=par(dw,do)+(rand*(mean(1,do)-par(dw,do)));      % Equation (3)
                  
                else
           % Students who improves randomly
                        par1(dw,do)=lb(do)+(rand*(ub(do)-lb(do)));                    % Equation (4)
                   
                end;
            end;
        end;
    end;

   
    % Boundary checking of the improvement of the students
    for z=1:1:student
       
            if par1(z,do)>ub(do)
                par1(z,do)=ub(do);
            else if par1(z,do)<lb(do)
                    par1(z,do)=lb(do);
                end;
            
        end;
    end;
    
    X=par1;
    
   for i=1:1:size(X,1)
        % Calculate the objective values
        Objective_values(i,1)=fobj(X(i,:));
   end;
        
        
       fun1=Objective_values;

        % Update the solution if there is a better solution
        for vt=1:1:student
        if ans(vt,1)>fun1(vt,1)
            ans(vt,1)=fun1(vt,1);
            sol(vt,:)=par1(vt,:);
        end;
    end;
       
     Best_fitness1=min(ans);
     for fo=1:1:student
             if Best_fitness1==ans(fo,1)
                 Best_student1=sol(fo,:);
             end;
         end;
         
         % Update the best student
          if Best_fitness>Best_fitness1
         Best_fitness=Best_fitness1;
         Best_student=Best_student1;
     end;
      end;
    
       
      
   % Display the iteration and Best_fitness optimum obtained so far 
    Convergence_curve(t)=Best_fitness;
    display (t);
    display (Best_fitness);
    
    
    
end