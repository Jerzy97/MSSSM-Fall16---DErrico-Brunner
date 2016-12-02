% This script iterates all the processes
% Can be fusioned with other files later

% Initializing

% Define duration of simulation
intervall = 10;        % [Days]

% define the size of the grid (number cells)
length = 25;
% percentual cops: (nr_cops)/(nr_citizens+nr_cops)
perc_cops = 0.1;
% percentual occupied map
perc_occupied = 0.7;
% set CI
CI = 0.2;
% set PI
PI = 0.3;
% set rebel active state treshhold
treshhold = 0.6;

% Create Actors
M = create_initial_matrix(length, perc_cops , perc_occupied, CI, PI, treshhold);

% Initialize Jail Matrix, containing rebells in jail
% Jail is a FIFO system (entering left, exiting right)
J = zeros(8, 1);

% Probability to come out of jail
PJail=0.05;

% Initialize VideoFrame out of loop for performance
VidFrame=zeros(1, intervall);

% The main goal is to achieve the most uniform way of
% updating -> no missleading dynamics
for t=1:intervall
    
    [E,CITQUIET,REB,COP]=indicize_people(M);
    
    % Compute amount of cells belonging to each group
    num(1)=length(E);
    num(2)=length(CITQUIET);
    num(3)=length(REB);
    num(4)=length(COP);
    
    % Randomize each group itself
    E=E(randperm(num(1)));
    CITQUIET=CITQUIET(randperm(num(2)));
    REB=REB(randperm(num(3)));
    COP=COP(randperm(num(4)));    
    
    % Update the whole Grid
    for i=1:size(M,2)
        
        % Compute amount of cells belonging to each group
        % which has not been updated yet
        % Order: Empty, Quiet, Rebell, Jail, Cop
        notUpdated(1)=length(E);
        notUpdated(2)=length(CITQUIET);
        notUpdated(3)=length(REB);
        notUpdated(4)=length(COP);
        TotalPop=sum(notUpdated);
        
        % Compute probability for an update
        % Is assumed as
        % P=(#people belonging to a group)/(Total Population)
        Prob(1)=(notUpdated(1)/TotalPop);
        Prob(2)=(notUpdated(2)/TotalPop);
        Prob(3)=(notUpdated(3)/TotalPop);
        Prob(4)=(notUpdated(4)/TotalPop);
        
        distr=rand();
        
        if distr<Prob(1)
            % Update free cells
            % Probability of birth: inversely proportional to the amount
            % of empty cells
            if E==0
                break
            end
            PBirth = 0.1*notUpdated(1)/size(M,2);
            distr2 = rand;
            if distr2<PBirth
                M(2:end, E(end))=generate_actor(perc_cops, perc_occupied, CI, PI, treshhold);
            elseif distr2<(PBirth+PJail)
                M(2:end, E(end))=J(:,end);
                J=J(:,1:(end-1));
            end
            if length(E)>1
                E=E(1:(end-1));
            else
                E=0;
            end
            
        elseif (distr>Prob(1))&&(distr<sum(Prob([1 2])))
            if CITQUIET == 0
                break
            end
            % Update quiet citizen
            currentCitizen=M(2:end, CITQUIET(end));
            % check if time has come
            currentCitizen(2)=currentCitizen(2)-1;
            if currentCitizen(2)==0
                M(2:end, CITQUIET(end))=zeros(8,1);
            end
            % define hardship from government H  ---> now set it random
            currentCitizen(3)=rand;
            % define legitimacy of government L  ---> now set it random
            currentCitizen(4)=rand;
            % define grievance G
            currentCitizen(5)=currentCitizen(3)*(1-currentCitizen(4));
            % define agent's risk aversion R ---> now set it random
            currentCitizen(6)=rand;
            % define agent's net risk N
            currentCitizen(7)=currentCitizen(6)*P;
            % define state
            if (currentCitizen(5)-currentCitizen(7))>treshhold
                currentCitizen(8)=1;
            end
            % update matrix
            M(2:end, CITQUIET(end)) = currentCitizen;
            % update CITQUIET
            if length(CITQUIET)<1
                CITQUIET = CITQUIET(1:(end-1));
            else
                CITQUIET = 0;
            end
            
        elseif (distr>sum(Prob([1 2])))&&(distr<sum(Prob([1 2 3])))
            % Update Rebells
            
        elseif (distr>sum(Prob([1 2 3])))&&(distr<sum(Prob))
            % Update Cops
            % Can be put into a different file later
            % Just for testing purposes
            currentIndex=COP(notUpdated(4));
            neigh=find_neighbors(currentIndex);
            % Arrest
            notUpdated(4)=notUpdated(4)-1;
        end
    end
    
    % Plot the current state
    create_image(M)
    VidFrame(t)=getframe();
    
    % Needed when we see how fast/slow things are changing
    % pause(0.1)
end

% Save data
v = VideoWriter('CivilViolenceSimu.avi', 'Uncompressed AVI');
open(v);
writeVideo(v, VidFrame);


