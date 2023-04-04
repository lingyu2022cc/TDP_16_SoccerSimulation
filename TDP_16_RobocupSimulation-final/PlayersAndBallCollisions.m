
function [x, y, ball, vx, vy] = PlayersAndBallCollisions(x, y, ball, particleRadius, vx, vy)

gridSize = length(x);
c = 1.2;

for i = 1:gridSize
    for j = 1:i-1
        if i ~= j
            deltaX = x(i) - x(j);
            deltaY = y(i) - y(j);
            distance = sqrt(deltaX^2 + deltaY^2);
            
            if distance < 2 * particleRadius        % Calculate collision response based on conservation of momentum       
                normalX = deltaX / distance;
                normalY = deltaY / distance;
                relativeVelocityX = vx(i) - vx(j);
                relativeVelocityY = vy(i) - vy(j);
                dotProduct = relativeVelocityX * normalX + relativeVelocityY * normalY;
                
                if dotProduct < 0
                    impulse = 2 * dotProduct / (1 / particleRadius + 1 / particleRadius);
                    vx(i) = vx(i) - impulse * normalX;
                    vy(i) = vy(i) - impulse * normalY;
                    vx(j) = vx(j) + impulse * normalX;
                    vy(j) = vy(j) + impulse * normalY;
                end
                
                % Reposition players to prevent overlapping
                overlap = 2 * particleRadius - distance;
                x(i) = x(i) + c * overlap * normalX / 2;
                x(j) = x(j) - c * overlap * normalX / 2;
                y(i) = y(i) + c * overlap * normalY / 2;
                y(j) = y(j) - c * overlap * normalY / 2;
            end
        end
    end
end


end
