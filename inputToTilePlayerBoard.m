% ==========================================================
% inputToTilePlayerBoard
%
% Authors: Daniel Simpkins
%
% Calculated which tile is clicked when given screen coords.
% ==========================================================

function [tx, ty] = inputToTilePlayerBoard(x,y)
	% Set x to grid offset
    ix = int32(x-221);
    
    % If the clicked tile is outside grid
    % then tile number is 0
    if ix < 0
        tileX = 0;
    else
        tileX = idivide(ix, 33) + 1;
	end
    
	% Set y to grid offset
    iy = int32(y-408);
    
    % If the clicked tile is outside grid
    % then tile number is 0
    if iy < 0
        tileY = 0;
    else
        tileY = idivide(iy, 33) + 1;
	end
    
    tx = tileX;
    ty = tileY;
end