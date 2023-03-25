function [updatedBall] = KickBall(ball, kickBallSigma, kickBallCoefficient, kickBallAcceleration, targetPosition, timeDelta)

% kickBallCoefficient 在updateplayer里面为 shootBallCoefficient=9;

ballPosition = ball(1,:);
updatedBall = ball;
%%set an error; error range:[-0.15,0.15]
error = 0.3 * rand()- 0.15;

distance_error = ballPosition - targetPosition;
distance = norm(distance_error);
direction = distance_error/distance;

kickDirection = direction + error;
% 更新球的速度
updatedBall(2,:)= updatedBall(2,:)+kickBallCoefficient*kickDirection;
end