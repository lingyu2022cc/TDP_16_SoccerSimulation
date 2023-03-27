function [updatedBall] = KickBall(ball, kickBallSigma, kickBallCoefficient, kickBallAcceleration, targetPosition, timeDelta)

% kickBallCoefficient= = 0.2 
% shootBallCoefficient=9;

ballPosition = ball(1,:);
updatedBall = ball;
%%set an error; error range:[-0.15,0.15]
error = 0.5 * rand()- 0.15;

distance_error = targetPosition - ballPosition;
distance = norm(distance_error);
direction = distance_error/distance;

kickDirection = direction + error;

updatedBall(2,:)= updatedBall(2,:)+kickBallCoefficient*kickDirection;
end
