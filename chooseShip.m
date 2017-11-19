% ==========================================================
% chooseShip
%
% Authors: Daniel Simpkins
%
% Waits for player to select a ship from side of screen.
% ==========================================================

function ship = chooseShip(player)
	global g_gameScreen;

	valid = 0;
	
	% Validate the ship can be selected
	while valid == 0
		[sX, sY] = ginput(1);
		
		ship = 5;
		
		% Set ship id according to coords
		if sX >= 20 & sX <= 53 & sY >= 400 & sY <= 466
			ship = 0;
		elseif sX >= 73 & sX <= 106 & sY >= 400 & sY <= 499
			ship = 1;
		elseif sX >= 126 & sX <= 159 & sY >= 400 & sY <= 499
			ship = 2;
		elseif sX >= 20 & sX <= 53 & sY >= 530 & sY <= 654
			ship = 3;
		elseif sX >= 73 & sX <= 106 & sY >= 530 & sY <= 687
			ship = 4;
		end
		
		% Check if ship is placed
		switch ship
			case 0
				if player.destroyer.placed == 0
					valid = 1;
				end
			case 1
				if player.submarine.placed == 0
					valid = 1;
				end
			case 2
				if player.cruiser.placed == 0
					valid = 1;
				end
			case 3
				if player.battleship.placed == 0
					valid = 1;
				end
			case 4
				if player.carrier.placed == 0
					valid = 1;
				end
		end
	end
end