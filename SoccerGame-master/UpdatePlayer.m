function [updatedPlayer, updatedBall] = UpdatePlayer(players, ball, indexOfPlayer, timeDelta, playerOriginalPosition,goalsTeam1,goalsTeam2)
% Updates the player state and ball state by action rules
% This is the function we can replace with different variants for
% comparing different players
global lastTeamOnBall;
global fallBehindTeam;
nAttributes = size(players{3},2);
updatedPlayer = {[0 0],[1 0],players{3}};
nPlayers=length(players{1});

kickBallSigma = 1/200;
passBallSigma = 1/200;
kickBallAcceleration = 1;
passBallAcceleration = 1;
shootBallCoefficient=7;
passBallCoefficient=0.2;
moveForwardCoefficient=0.5;
markedDistance=12; %10-15 seems optimal
threatedDistance=20;
kickBallProbabilityCoefficient=25;
actionBallDistance = 1.5;
actionPlayerDistance = 36;
actionGoalDistance = 30;


%fieldWidth=90;
%nPlayers=size(players{1},1);
playerTeam=players{3}(indexOfPlayer);

if playerTeam==0
    goalPosition = [+60 0];%60 0
else
    goalPosition = [-60 0];
end

kickBallLikelihood = 0.0;
passBallLikelihood = 0.5;
doNothingWithBallLikelihood = 0.5;

sumOfLikelihoods = kickBallLikelihood + passBallLikelihood + doNothingWithBallLikelihood;
if sumOfLikelihoods ~= 1
    ME = MException('The sum of the likelyhoods has to equal 1. They are currently summed to %s',sumOfLikelihoods);
    throw(ME)
end

playerPosition = players{1}(indexOfPlayer,:);
ballPosition = ball(1,:);
distanceToBall = sqrt((ballPosition(1) - playerPosition(1))^2 + (ballPosition(2) - playerPosition(2))^2);
distanceToGoal = sqrt((goalPosition(1) - playerPosition(1)).^2 + (goalPosition(2) - playerPosition(2)).^2);

 if goalsTeam1 > goalsTeam2
%      updatedPlayer = Attack(players, indexOfPlayer, updatedBall, timeDelta);
   fallBehindTeam=1;
 elseif goalsTeam1 < goalsTeam2
   fallBehindTeam=0;
 else
     fallBehindTeam=NaN;
 end

 


if distanceToBall < actionBallDistance
    lastTeamOnBall=playerTeam;
    kickBallLikelihood=exp(-distanceToGoal/kickBallProbabilityCoefficient);
    
    whatTodo = rand();
    kickLikeRange = kickBallLikelihood;
    passLikeRange = kickBallLikelihood + passBallLikelihood;
    
    if  whatTodo <= kickLikeRange || distanceToGoal < actionGoalDistance
%         while IsThreated==true


        targetPosition = goalPosition;
        ball = KickBall(ball, kickBallSigma, shootBallCoefficient, kickBallAcceleration, targetPosition, timeDelta);
    elseif IsMarked(players,indexOfPlayer,playerTeam,markedDistance) || mod(indexOfPlayer,nPlayers/2)==0 %pass if you are the goalie
        targetPosition = ChoosePlayerToPass(players,indexOfPlayer,markedDistance);       
        ball = PassBall(ball, passBallSigma, passBallCoefficient, passBallAcceleration, targetPosition, timeDelta);
    else 
        targetPosition = [goalPosition(1)+sign(playerTeam-1/2) players{1}(indexOfPlayer,2)];
        ball = KickBall(ball, kickBallSigma, moveForwardCoefficient, kickBallAcceleration, targetPosition, timeDelta); 
    end
end

updatedBall = ball;
% updatedPlayer = Move(players, indexOfPlayer, updatedBall, timeDelta, playerOriginalPosition);
if (fallBehindTeam==playerTeam) && (indexOfPlayer==(1+playerTeam*nPlayers/2) || indexOfPlayer==(2+playerTeam*nPlayers/2))
   updatedPlayer = Attack(players, indexOfPlayer, updatedBall, timeDelta);
else
   updatedPlayer = Move(players, indexOfPlayer, updatedBall, timeDelta, playerOriginalPosition);
end

end

% NOTE: To make sure that  the only file that we need to change to compare
% different PlayerAction.m files make sure to put all your helpfiles inside
% this function.



