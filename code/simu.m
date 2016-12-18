function SaveM = simu(CI, PI)

% Initializing

% Define duration of simulation
intervall = 300;            %[Days]

% define the size of the grid -> Output: GridSize x GridSize
GridSize = 40;
% percentual cops: (nr_cops)/(nr_citizens+nr_cops)
perc_cops = 0.075;
% percentual occupied map
perc_occupied = 0.8;
% set rebel active state treshhold
threshold = 0.5;

% For our model, we assume the State needs constant income in order not to
% collapse. This means this income has to be split equally amongst the
% population. The actual value is not of interest, only percentual values
StateIncome = 1;
% Initially all citizen are treated as non-active
taxes = StateIncome/((1-perc_occupied*perc_cops)*GridSize*GridSize);

% Create Actors
M = create_initial_matrix(GridSize, perc_cops , perc_occupied, CI, PI, threshold, taxes);

% Initialize Jail Matrix, containing rebells in jail
% Jail is a FIFO system (entering left, exiting right)
J = zeros(8, 1);

% Initialize need Structs, matrices, vectors, etc.
% VidFrame = struct('cdata', cell(1,intervall), 'colormap', cell(1,intervall));
SaveM = zeros(8, GridSize*GridSize, intervall);
SaveNum = zeros(5, intervall);

% The main goal is to achieve the most uniform way of
% updating -> no missleading dynamics
for t=1:intervall
    
    SaveM(:,:,t)=M;
    
    [E,CITQUIET,COP,REB]=indicize_people(M);
    
    % Compute amount of cells belonging to each group
    num(1)=length(E);
    num(2)=length(CITQUIET);
    num(3)=length(COP);
    num(4)=length(REB);
    num(5)=size(J, 2);
    SaveNum(:,t)=num;
    
    % State income has to be constant, rebels are not paying taxes
    taxes = StateIncome/num(2);
    
    % Randomize each group itself
    E=E(randperm(num(1)));
    CITQUIET=CITQUIET(randperm(num(2)));
    COP=COP(randperm(num(3)));
    REB=REB(randperm(num(4)));
    
    % Decrease Jail Time
    J(8,:) = J(8,:)-1;
    
    % Update the whole Grid
    for i=1:size(M,2)
        
        % Compute amount of cells belonging to each group
        % which has not been updated yet
        % Order: Empty, Quiet, Cop, Rebel
        notUpdated(1)=length(E);
        notUpdated(2)=length(CITQUIET);
        notUpdated(3)=length(COP);
        notUpdated(4)=length(REB);
        
        % Exception for completely empty arrays:
        if E(1) == 0
            notUpdated(1) = notUpdated(1) - 1;
        end
        if CITQUIET(1) == 0
            notUpdated(2) = notUpdated(2) - 1;
        end
        if COP(1) == 0
            notUpdated(3) = notUpdated(3) - 1;
        end
        if REB(1) == 0
            notUpdated(4) = notUpdated(4) - 1;
        end
        TotalNotUpdated=sum(notUpdated);
        
        % Compute probability for an update
        Prob(1)=(notUpdated(1)/TotalNotUpdated);
        Prob(2)=(notUpdated(2)/TotalNotUpdated);
        Prob(3)=(notUpdated(3)/TotalNotUpdated);
        Prob(4)=(notUpdated(4)/TotalNotUpdated);
        
        distr=rand;
        
        if distr<Prob(1)
            % Update free cells
            currentIndex=E(end);
            
            % Update cell
            [M, J] = update_free_cell(M, J, currentIndex, num(1), perc_cops, perc_occupied, CI, PI, threshold, taxes, num);
            
            % Update E
            if length(E)>1
                E=E(1:(end-1));
            else
                E=0;
            end
            
        elseif distr<sum(Prob([1 2]))
            % Update quiet citizen
            currentIndex=CITQUIET(end);
            
            % Update
            M = update_citizen(M, currentIndex, PI, threshold, taxes);
            
            % Move
            [M, E, CITQUIET] = move_on_grid(M, E, CITQUIET);
            
            % update CITQUIET
            if length(CITQUIET)>1
                CITQUIET = CITQUIET(1:(end-1));
            else
                CITQUIET = 0;
            end
            
        elseif distr<sum(Prob([1 2 3]))
            % Update Cops
            currentIndex=COP(end);
            
            % Update
            [M, J, REB] = update_cop(M, J, REB, currentIndex, CI);
            
            % Move
            [M, E, COP] = move_on_grid(M, E, COP);
            
            % Update COP
            if length(COP)>1
                COP = COP(1:(end-1));
            else
                COP = 0;
            end
            
        elseif distr<sum(Prob)
            % Update Rebells
            % Basically the same procedure as  for a quiet citizen
            % For Doc check above
            currentIndex=REB(end);
            
            % Update rebel
            M = update_citizen(M, currentIndex, PI, threshold, taxes);
            
            % Move
            [M, E, REB] = move_on_grid(M, E, REB);
            
            % Update REB
            if length(REB)>1
                REB = REB(1:(end-1));
            else
                REB = 0;
            end
            
        end
        
    end
    
    % Plot the current state
    % create_plot_state(M);
    % VidFrame(t)=getframe();
    
    % pause(0.01)
end

% Plot the data
create_plot_population(SaveNum, CI, PI);
% create_plot_local_outbursts(SaveM, CI, PI);
% create_plot_total_outbursts(SaveNum, CI, PI);

% Save data
% v = VideoWriter('CivilViolenceSimu.avi', 'Uncompressed AVI');
% open(v)
% writeVideo(v, VidFrame);
% close(v)

end
