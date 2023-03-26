function [isGoal,goalsTeam1,goalsTeam2,kickoffTeam] = Goal(ball,goalsTeam1,goalsTeam2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
isGoal=false;
kickoffTeam=0;
fieldLength=120;
%fieldWidth=90;
if ball(1,1)>= 51 && ball(1,2)>-13 && ball(1,2)<13
    isGoal=true;
    goalsTeam1=goalsTeam1+1;
    kickoffTeam=1; %the other team will kickoff
elseif ball(1,1)<=-51 && ball(1,2)>-13 && ball(1,2)<13
    isGoal=true;
    goalsTeam2=goalsTeam2+1;
    kickoffTeam=0; %the other team will kickoff
end

end

