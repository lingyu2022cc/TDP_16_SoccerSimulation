function [updatedBall] = PassBall(ball, kickBallSigma, kickBallCoefficient, kickBallAcceleration, targetPosition, timeDelta)

ballPosition = ball(1,:);
updatedBall = ball;
%%set an error; error range:[-0.15,0.15]
error = 0.3 * rand()- 0.15;

distanceError = targetPosition- ballPosition;
distance = norm(distanceError);
direction = distanceError/distance;

kickDirection = direction + error;
% update the speed of ball
updatedBall(2,:)= updatedBall(2,:)+kickBallCoefficient*distance*kickDirection;
end
