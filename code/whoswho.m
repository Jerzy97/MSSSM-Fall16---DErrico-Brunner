function groups = whoswho(M)
% This function returns a matrix that contains
% information on which index of the Actors array
% belongs to which group
%
% Structure of 'overview' 
%
%                    |# group members|index|...
% NOBODY            0|   
% CITIZEN INACTIVE  1|
% COP               2|
% CITIZEN ACTIVE    3|
% CITIZEN IN JAIL   4|

GridSize=size(M,2);

nobody=0;
citizen=0;
cop=0;
citactive=0;
citinjail=0;

% Iterate through Actors array
for i=1:GridSize
    if M(2, i)==0
        nobody(1)=nobody(1)+1;
        nobody(end+1)=i;
    elseif M(2,i)==1
        if M(9,i)==0
            if M(10,i)==0
                citizen(1)=citizen(1)+1;
                citizen(end+1)=i;
            else
                citactive(1)=citactive(1)+1;
                citacitve(end+1)=i;
            end
        else
            citinjail(1)=citinjail(1)+1;
            citinjail(end+1)=i;
        end
    else
        cop(1)=cop(1)+1;
        cop(end+1)=i;
    end
end

% Padding Zeros to the end of the vectors
% so that they can be put in a single matrix
dif1=GridSize-length(nobody);
dif2=GridSize-length(citizen);
dif3=GridSize-length(cop);
dif4=GridSize-length(citactive);
dif5=GridSize-length(citinjail);

nobody(end+dif1)=0;
citizen(end+dif2)=0;
cop(end+dif3)=0;
citactive(end+dif4)=0;
citinjail(end+dif5)=0;

groups=[nobody;citizen;cop;citactive;citinjail];

end