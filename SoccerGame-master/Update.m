function [players, ball] = Update(players, ball, timeSync, timeDelta, playerOriginalPosition,goalsTeam1,goalsTeam2)
% This function updated all the states of all the players and the field

[updatedPlayers, updatedBall] = UpdatePlayers(players, ball, timeDelta, playerOriginalPosition,goalsTeam1,goalsTeam2);
pause(timeSync);
players = updatedPlayers;
ball = updatedBall;

end

