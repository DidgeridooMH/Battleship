% ==========================================================

% placeShip.m
%
% Author: Daniel Simpkins
%
% Places a ship on the board
%
% Parameters:	s = ship id
%				x = x tile location
%				y = y tile location
%				r = 0 horizontal(L->R)
%					1 veritical(U->D)
%				b = board to place onto
%
% Return: Board with ship
% ==========================================================

function o = placeShip(s, b, x, y, r)
	switch s
		% Destroyer
        case 0
            b(x,y) = 2;
			
            if ~r
                b(x+1,y) = 2;
			else
                b(x,y+1) = 2;
			end
		
		% Cruiser
		case 1
            if ~r
				for lx = x:x+2
					b(lx,y) = 3;
				end
			else
                for ly = y:y+2
					b(x,ly) = 3;
				end
			end
		
		% Submarine
		case 2
			if ~r
				for lx = x:x+2
					b(lx,y) = 6;
				end
			else
                for ly = y:y+2
					b(x,ly) = 6;
				end
			end
			
		% Battleship
		case 3
			if ~r
				for lx = x:x+3
					b(lx,y) = 4;
				end
			else
                for ly = y:y+3
					b(x,ly) = 4;
				end
			end
		
		% Aircraft Carrier
		case 4
			if ~r
				for lx = x:x+4
					b(lx,y) = 5;
				end
			else
                for ly = y:y+4
					b(x,ly) = 5;
				end
			end
	end
	
	o = b;
end
