function [reservoirs] = water_reservoirs(image, direction)
% rotate image into right direction
% 0 - top
% 1 - right
% 2 - bottom
% 3 - left
temp = rot90(image, direction);
reservoirs = zeros(size(temp));
size_x = size(temp, 2);
size_y = size(temp, 1);

% start at random point along top
start_x = 1;
start_y = randi([1 size_x]);


% begin dropping
drop_x = start_x;
drop_y = start_y;
dropping = 1;

while dropping
    % if next point is off the edge, stop
    if drop_x + 1 > size_x
        dropping = 0;
        continue;
        
    % if 0 point exists downwards, move there, begin again
    elseif temp(drop_x + 1, drop_y) == 0
        drop_x = drop_x + 1;
        continue;
        
    % if 0 point exists down-right, go that way
    elseif temp(drop_x + 1, drop_y + 1) == 0
        drop_x = drop_x + 1;
        drop_y = drop_y - 1;
        continue;
 
    % or down and left    
    elseif temp(drop_x + 1, drop_y - 1) == 0
        drop_x = drop_x + 1;
        drop_y = drop_y - 1;
        continue;
        
    % go right
    elseif drop_y + 1 > size_y
        dropping = 0;
        continue;
    elseif temp(drop_x, drop_y + 1) == 0
        drop_y = drop_y + 1;
        continue;
        
    % if 0 point exists left or right only, randomly choose
    else
        dropping = 0;
    end
end



% when no points left to move
% save resulting image in reservoirs
reservoirs(drop_x, drop_y) = 2;
% repeat until image stabilizes
reservoirs = reservoirs + temp;
end

