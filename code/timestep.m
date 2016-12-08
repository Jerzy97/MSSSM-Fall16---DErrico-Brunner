% This script iterates all the processes
% Can be fusioned with other files later

% Initializing

% Define duration of simulation
intervall = 100;        % [Days]

% define the size of the grid -> Output: GridSize x GridSize
GridSize = 100;
% percentual cops: (nr_cops)/(nr_citizens+nr_cops)
perc_cops = 0.2;
% percentual occupied map
perc_occupied = 0.7;
% set CI
CI = 0.2;
% set PI
PI = 0.3;
% set rebel active state treshhold
treshhold = 0.6;

% Create Actors
M = create_initial_matrix(GridSize, perc_cops , perc_occupied, CI, PI, treshhold);

% Initialize Jail Matrix, containing rebells in jail
% Jail is a FIFO system (entering left, exiting right)
J = zeros(7, 1);

% Probability to come out of jail
PJail=0.05;

% Initialize VideoFrame out of loop for performance
VidFrame = struct('cdata', cell(1,intervall), 'colormap', cell(1,intervall));

% The main goal is to achieve the most uniform way of
% updating -> no missleading dynamics
for t=1:intervall
    
    [E,CITQUIET,COP,REB]=indicize_people(M);
    
    % Compute amount of cells belonging to each group
    num(1)=length(E);
    num(2)=length(CITQUIET);
    num(3)=length(COP);
    num(4)=length(REB);
    
    % Randomize each group itself
    E=E(randperm(num(1)));
    CITQUIET=CITQUIET(randperm(num(2)));
    COP=COP(randperm(num(3)));
    REB=REB(randperm(num(4)));    
    
    % Update the whole Grid
    for i=1:size(M,2)
        
        % Compute amount of cells belonging to each group
        % which has not been updated yet
        % Order: Empty, Quiet, Rebell, Jail, Cop
        notUpdated(1)=length(E);
        notUpdated(2)=length(CITQUIET);
        notUpdated(3)=length(COP);
        notUpdated(4)=length(REB);
        TotalNotUpdated=sum(notUpdated);
        
        % Compute probability for an update
        % Is assumed as
        % P=(#people belonging to a group)/(Total Population)
        Prob(1)=(notUpdated(1)/TotalNotUpdated);
        Prob(2)=(notUpdated(2)/TotalNotUpdated);
        Prob(3)=(notUpdated(3)/TotalNotUpdated);
        Prob(4)=(notUpdated(4)/TotalNotUpdated);
        
        distr=rand();
        
        if distr<Prob(1)
            % Update free cells
            % Probability of birth: proportional to the amount of empty
            % cells
            if E==0
                break
            end
            currentIndex=E(end);
            
            % Setting birth Rate
            PBirth = 0.1*notUpdated(1)/size(M,2);
            
            distr2 = rand;
            if distr2<PBirth
                M(2:end, currentIndex)=generate_actor(perc_cops, perc_occupied, CI, PI, treshhold);
            elseif distr2<(PBirth+PJail) && size(J, 2)>1
                M(2:end, currentIndex)=J(:,end);
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
            currentIndex=CITQUIET(end);
            currentCitizen=M(2:end, currentIndex);
            % Check Age - maybe die
            if currentCitizen(2)==0
                M(2:end, currentIndex)=zeros(7,1);
                break
            else
                currentCitizen(2)=currentCitizen(2)-1;
            end
            
            % Determine estimated arrest probability - Epstein
            neighbors=find_neighbors(currentIndex, GridSize);
            % Count Cops and Rebels in sight
            neighborCops=0;
            % Since, when counting the agent always counts with himself
            neighborRebels=1;
            for n=1:length(neighbors)
                if M(2, n)==2
                    neighborCops=neighborCops+1;
                elseif M(2, n)==3
                    neighborRebels=neighborRebels+1;
                end
            end
            CopToActiveRatio=neighborCops/neighborRebels;
            % The constant 0.1 is chosen to ensure reasonable values
            P = 1 - exp(-0.1*CopToActiveRatio);
            
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
                currentCitizen(1)=3;
            end
            % update matrix
            M(2:end, currentIndex) = currentCitizen;
            
            % Move
            [M, E, CITQUIET] = move_on_grid(currentIndex, M, E, CITQUIET);
            
            % update CITQUIET
            if length(CITQUIET)>1
                CITQUIET = CITQUIET(1:(end-1));
            else
                CITQUIET = 0;
            end
            
        elseif (distr>sum(Prob([1 2]))) && (distr<sum(Prob([1 2 3])))
            % Update Cops
            if COP == 0
                break
            end 
            currentIndex=COP(end);
            currentCop=M(2:end, currentIndex);
            % Check Age - maybe die
            if currentCop(2)==0
                M(2:end, currentIndex)=zeros(7,1);
            else
                currentCop(2)=currentCop(2)-1;
            end
            
            % Arrest
            neighbors=find_neighbors(currentIndex, GridSize);
            for k=1:length(neighbors)
                if M(2, neighbors(k)) == 3 && rand<currentCop(3)
                    J=[M(2:end, neighbors(k)) J];
                    M(2:end, neighbors(k))=zeros(7,1);
                end
            end
            
            % Move
            [M, E, COP] = move_on_grid(currentIndex, M, E, COP);
            
            if length(COP)>1
                COP = COP(1:(end-1));
            else
                COP = 0;
            end
            
        elseif (distr>sum(Prob([1 2 3])))&&(distr<sum(Prob))
            % Update Rebells
            if REB == 0
                break
            end
            % Basically the same procedure as  for a quiet citizen
            % For Doc check above
            currentIndex=REB(end);
            currentReb=M(2:end, currentIndex);
            
            if currentReb(2)==0
                M(2:end, currentIndex)=zeros(7,1);
                break
            else
                currentReb(2)=currentReb(2)-1;
            end
            
            neighbors=find_neighbors(currentIndex, GridSize);
            neighborCops=0;
            neighborRebels=1;
            for n=1:length(neighbors)
                if M(2, n)==2
                    neighborCops=neighborCops+1;
                elseif M(2, n)==3
                    neighborRebels=neighborRebels+1;
                end
            end
            CopToActiveRatio=neighborCops/neighborRebels;
            P = 1 - exp(-0.1*CopToActiveRatio);
            
            currentReb(3)=rand;
            currentReb(4)=rand;
            currentReb(5)=currentReb(3)*(1-currentReb(4));
            currentReb(6)=rand;
            currentReb(7)=currentReb(6)*P;

            if (currentReb(5)-currentReb(7))<treshhold
                currentReb(1)=1;
            end
            % update matrix
            M(2:end, currentIndex) = currentReb;
            
            % Move
            [M, E, REB] = move_on_grid(currentIndex, M, E, REB);
            
            if length(REB)>1
                REB = REB(1:(end-1));
            else
                REB = 0;
            end
        end
    end
    
    % Plot the current state
    create_plot_state(M);
    VidFrame(t)=getframe();
    
    % Needed when we see how fast/slow things are changing
    pause(0.01)
end

% Save data
v = VideoWriter('CivilViolenceSimu.avi', 'Uncompressed AVI');
open(v)
writeVideo(v, VidFrame);
close(v)


