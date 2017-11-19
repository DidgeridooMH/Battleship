% ==========================================================
% VerifyShip function
%
% Authors: Daniel Simpkins
%
% Checks to see if a ship is able to be placed at the
% desired location and orientation.
% 
% Returns the verified coordinates and success flag
% ==========================================================

function [o, x, y, r] = verifyShip(s, x, y, r, b)
	% Set success flag
	o = 1;
	
	% Check for obvious failures (ie. tile 0 and wrong orientation)
	if x == 0 || y == 0 || r > 1
		o = 0;
		return
	end
	
	switch s
		% Destroyer (2 Space)
		case 0
			% Check orientation of ship
			if ~r
				% Check if theres room
				if x > 9
					x = 9;
				end
				
				for lx = x:(x+1)
					if b(lx, y) ~= 0
						o = 0;
						return
					end
				end
			else
				if y > 9
					y = 9;
				end
				
				for ly = y:(y+1)
					if b(x, ly) ~= 0
						o = 0;
						return
					end
				end
			end
			
		% Submarine (3 spaces)
		case 1
			% Check orientation of ship
			if ~r
				% Check if theres room 
				if x > 8
					x = 8;
				end
				
				for lx = x:(x+2)
					if b(lx, y) ~= 0
						o = 0;
						return
					end
				end
			else
				if y > 8
					y = 8;
				end
				
				for ly = y:(y+2)
					if b(x, ly) ~= 0
						o = 0;
						return
					end
				end
			end
			
		% Cruiser (3 Spaces)
		case 2
			% Check orientation of ship
			if ~r
				% Check if theres room
				if x > 8
					x = 8;
				end
				
				for lx = x:(x+2)
					if b(lx, y) ~= 0
						o = 0;
						return
					end
				end
			else
				if y > 8
					y = 8;
				end
				
				for ly = y:(y+2)
					if b(x, ly) ~= 0
						o = 0;
						return
					end
				end
			end
			
		% Battleship (4 Space)
		case 3
			% Check orientation of ship
			if ~r
				% Check if theres room
				if x > 7
					x = 7;
				end
				
				for lx = x:(x+3)
					if b(lx, y) ~= 0
						o = 0;
						return
					end
				end
			else
				if y > 7
					y = 7;
				end
				
				for ly = y:(y+3)
					if b(x, ly) ~= 0
						o = 0;
						return
					end
				end
			end
			
		% Carrier (5 Space)
		case 4
			% Check orientation of ship
			if ~r
				% Check if theres room
				if x > 6
					x = 6;
				end
				
				for lx = x:(x+4)
					if b(lx, y) ~= 0
						o = 0;
						return
					end
				end
			else
				if y > 6
					y = 6;
				end
				
				for ly = y:(y+4)
					if b(x, ly) ~= 0
						o = 0;
						return
					end
				end
			end
	end
end
