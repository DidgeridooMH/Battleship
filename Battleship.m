% ==========================================================
% Battleship function
%
% Authors: Daniel Simpkins and Colin Williams
%
% Hosts main game loop and functionality
% ==========================================================

function Battleship
    clear, clc;
	
	% Create a game handler
	global g_gameScreen;
	g_gameScreen = 0;
	
	% Input keys to be used later
	KEY_R = 0;
	KEY_ESC = 0;
	KEY_ENTER = 0;
	KEY_M = 0;
	
	% Create a structure for each ship for both players
	player.destroyer.health = 2;
	player.destroyer.placed = 0;
	player.destroyer.selected = 0;
	player.destroyer.X = 0;
	player.destroyer.Y = 0;
	player.destroyer.R = 0;
	player.destroyer.finalized = 0;
	
	player.submarine.health = 3;
	player.submarine.placed = 0;
	player.submarine.selected = 0;
	player.submarine.X = 0;
	player.submarine.Y = 0;
	player.submarine.R = 0;
	player.submarine.finalized = 0;
	
	player.cruiser.health = 3;
	player.cruiser.placed = 0;
	player.cruiser.selected = 0;
	player.cruiser.X = 0;
	player.cruiser.Y = 0;
	player.cruiser.R = 0;
	player.cruiser.finalized = 0;
	
	player.battleship.health = 4;
	player.battleship.placed = 0;
	player.battleship.selected = 0;
	player.battleship.X = 0;
	player.battleship.Y = 0;
	player.battleship.R = 0;
	player.battleship.finalized = 0;
	
	player.carrier.health = 5;
	player.carrier.placed = 0;
	player.carrier.selected = 0;
	player.carrier.X = 0;
	player.carrier.Y = 0;
	player.carrier.R = 0;
	player.carrier.finalized = 0;
	
	enemy.destroyer.health = 2;
	enemy.destroyer.placed = 0;
	enemy.destroyer.X = 0;
	enemy.destroyer.Y = 0;
	enemy.destroyer.R = 0;
	
	enemy.submarine.health = 3;
	enemy.submarine.placed = 0;
	enemy.submarine.X = 0;
	enemy.submarine.Y = 0;
	enemy.submarine.R = 0;
	
	enemy.cruiser.health = 3;
	enemy.cruiser.placed = 0;
	enemy.cruiser.X = 0;
	enemy.cruiser.Y = 0;
	enemy.cruiser.R = 0;
	
	enemy.battleship.health = 4;
	enemy.battleship.placed = 0;
	enemy.battleship.X = 0;
	enemy.battleship.Y = 0;
	enemy.battleship.R = 0;
	
	enemy.carrier.health = 5;
	enemy.carrier.placed = 0;
	enemy.carrier.X = 0;
	enemy.carrier.Y = 0;
	enemy.carrier.R = 0;
	
	% gamePhase = 1: Player choosing
	% gamePhase = 2: Enemy choosing
	% gamePhase = 3: Player Turn
	% gamePhase = 4: Computer Turn
	% gamePhase = 5: End and close
	gamePhase = 1;
	
	% 0 for player victory
	% 1 for enemy victory
	victory = 1;
	
	% Counter for number of ships on board
	playerShipsPlaced = 0;
	enemyShipsPlaced = 0;
	
	% Create a 10x10 matrix for each board
    playerBoard(1:10, 1:10) = 0;
	enemyBoard(1:10, 1:10) = 0;
	
	% Create variables to assist enemy AI
	lastEnemyCoord = [0, 0];
	enemyState = 0;
	attackSuccess = 0;
	
	% Read in hit and miss images
	[hitImg, ~, hitAlpha] = imread('images/hit.png');
	[missImg, ~, missAlpha] = imread('images/miss.png');
	
	% Read tips images for bottom corner
    tipsImgOne = imread('images/tips_one.png');
    tipsImgTwo = imread('images/tips_two.png');
    tipsImgThree = imread('images/tips_three.png');
    tipsImgFour = imread('images/tips_four.png');
	tipsImgFive = imread('images/tips_five.png');
	
	% Render the screen
	renderScreen();
	renderShips(player);
	
	% Load and start music
	%music = audioread('audio/music.wav');
	%audio = audioplayer(music/2, 44100);
	%play(audio);
	
	% Load SoundFX
	%splash = audioread('audio/splash.wav');
	%sfx_splash = audioplayer(splash, 44100);
	
	%explosion = audioread('audio/explosion.wav');
	%sfx_explosion = audioplayer(explosion*2, 44100);
	
	% Game Loop
	while gamePhase > 0
		
		% Loop music
		%if ~isplaying(audio)
		%	play(audio);
		%end
		
		switch gamePhase
			% Player choosing ship placement
			case 1
				confirmed = 0;
				cancelled = 0;
				r = 0;
				x = 0;
				y = 0;
				
				% Display first tip
				imshow(tipsImgOne, 'XData', [564, 750], 'YData', [607, 750]);
				
				% Loop to allow player to choose ships
				while confirmed == 0
					% Wait for player to choose a ship
					ship = chooseShip(player);
					
					% Set the ships state to selected
					switch ship
						case 0
							player.destroyer.selected = 1;
						case 1
							player.submarine.selected = 1;
						case 2
							player.cruiser.selected = 1;
						case 3
							player.battleship.selected = 1;
						case 4
							player.carrier.selected = 1;
					end
					
					% Clear and render a frame
					renderScreen();
					renderShips(player);
					
					% Display tip
					imshow(tipsImgFive, 'XData', [564, 750], 'YData', [607, 750]);
					
					% Verify that the ship can be placed
					verified = 0;
	
					while verified == 0
						[tx, ty] = ginput(1);
						[x, y] = inputToTilePlayerBoard(tx, ty);
						if ~isempty(x) && ~isempty(y)
							[verified, x, y, r] = verifyShip(ship, x, y, r, playerBoard);
						end
					end
					
					% Create a board to modify
					tmp = placeShip(ship, playerBoard, x, y, 0);
					
					% Set the ships state
					switch ship
						case 0
							player.destroyer.placed = 1;
							player.destroyer.X = x;
							player.destroyer.Y = y;
							player.destroyer.R = r;
						case 1
							player.submarine.placed = 1;
							player.submarine.X = x;
							player.submarine.Y = y;
							player.submarine.R = r;
						case 2
							player.cruiser.placed = 1;
							player.cruiser.X = x;
							player.cruiser.Y = y;
							player.cruiser.R = r;
						case 3
							player.battleship.placed = 1;
							player.battleship.X = x;
							player.battleship.Y = y;
							player.battleship.R = r;
						case 4
							player.carrier.placed = 1;
							player.carrier.X = x;
							player.carrier.Y = y;
							player.carrier.R = r;
					end
					
					% Clear and render a frame
					renderScreen();
					renderShips(player);
					
					% Set keyboard interrupts
					set(g_gameScreen, 'WindowKeyPressFcn', @keyDown);
					
					finalize = 0;
					
					% Display tip
					imshow(tipsImgTwo, 'XData', [564, 750], 'YData', [607, 750]);
					
					% Wait for final input on ship
					while ~finalize
						
						% Rotate the ship
						if KEY_R
							[verified, x, y, r] = verifyShip(ship, x, y , ~r, playerBoard);
							if verified
								switch ship
									case 0
										player.destroyer.R = r;
										tmp = placeShip(ship, playerBoard, x, y, r);
									case 1
										player.submarine.R = r;
										tmp = placeShip(ship, playerBoard, x, y, r);
									case 2
										player.cruiser.R = r;
										tmp = placeShip(ship, playerBoard, x, y, r);
									case 3
										player.battleship.R = r;
										tmp = placeShip(ship, playerBoard, x, y, r);
									case 4
										player.carrier.R = r;
										tmp = placeShip(ship, playerBoard, x, y, r);
								end

								switch ship
									case 0
										player.destroyer.placed = 1;
										player.destroyer.X = x;
										player.destroyer.Y = y;
										player.destroyer.R = r;
									case 1
										player.submarine.placed = 1;
										player.submarine.X = x;
										player.submarine.Y = y;
										player.submarine.R = r;
									case 2
										player.cruiser.placed = 1;
										player.cruiser.X = x;
										player.cruiser.Y = y;
										player.cruiser.R = r;
									case 3
										player.battleship.placed = 1;
										player.battleship.X = x;
										player.battleship.Y = y;
										player.battleship.R = r;
									case 4
										player.carrier.placed = 1;
										player.carrier.X = x;
										player.carrier.Y = y;
										player.carrier.R = r;
								end
							else
								r = ~r;
							end
							
							renderScreen();
							renderShips(player);
							imshow(tipsImgTwo, 'XData', [564, 750], 'YData', [607, 750]);
							
							KEY_R = 0;
							
						% Cancel ship placement
						elseif KEY_ESC
							finalize = 1;
							player.destroyer.selected = 0;
							player.submarine.selected = 0;
							player.cruiser.selected = 0;
							player.battleship.selected = 0;
							player.carrier.selected = 0;
							
							switch ship
								case 0
									player.destroyer.placed = 0;
									player.destroyer.X = 0;
									player.destroyer.Y = 0;
									player.destroyer.R = 0;
								case 1
									player.submarine.placed = 0;
									player.submarine.X = 0;
									player.submarine.Y = 0;
									player.submarine.R = 0;
								case 2
									player.cruiser.placed = 0;
									player.cruiser.X = 0;
									player.cruiser.Y = 0;
									player.cruiser.R = 0;
								case 3
									player.battleship.placed = 0;
									player.battleship.X = 0;
									player.battleship.Y = 0;
									player.battleship.R = 0;
								case 4
									player.carrier.placed = 0;
									player.carrier.X = 0;
									player.carrier.Y = 0;
									player.carrier.R = 0;
							end
							cancelled = 1;
							confirmed = 1;
							KEY_ESC = 0;
							
						% Confirm and lock in ship placement
						elseif KEY_ENTER
							finalize = 1;
							
							player.destroyer.selected = 0;
							player.submarine.selected = 0;
							player.cruiser.selected = 0;
							player.battleship.selected = 0;
							player.carrier.selected = 0;
							playerBoard = tmp;
							
							confirmed = 1;
							KEY_ENTER = 0;
						elseif KEY_M
							% Verify that the ship can be placed
							verified = 0;

							while verified == 0
								[tx, ty] = ginput(1);
								[x, y] = inputToTilePlayerBoard(tx, ty);
								[verified, x, y, r] = verifyShip(ship, x, y, r, playerBoard);
							end

							% Create a board to modify
							tmp = placeShip(ship, playerBoard, x, y, r);

							% Set the ships state
							switch ship
								case 0
									player.destroyer.placed = 1;
									player.destroyer.X = x;
									player.destroyer.Y = y;
									player.destroyer.R = r;
								case 1
									player.submarine.placed = 1;
									player.submarine.X = x;
									player.submarine.Y = y;
									player.submarine.R = r;
								case 2
									player.cruiser.placed = 1;
									player.cruiser.X = x;
									player.cruiser.Y = y;
									player.cruiser.R = r;
								case 3
									player.battleship.placed = 1;
									player.battleship.X = x;
									player.battleship.Y = y;
									player.battleship.R = r;
								case 4
									player.carrier.placed = 1;
									player.carrier.X = x;
									player.carrier.Y = y;
									player.carrier.R = r;
							end
							
							% Clear and render a new frame
							renderScreen();
							renderShips(player);
							imshow(tipsImgTwo, 'XData', [564, 750], 'YData', [607, 750]);
							KEY_M = 0;
						end
						
						% Sleep the thread
						pause(.1);
					end
				end
				
				% Don't update if ship placement cancelled
				if ~cancelled
					playerShipsPlaced = playerShipsPlaced + 1;

					% Update ship states
					switch ship
						case 0
							player.destroyer.placed = 1;
							player.destroyer.X = x;
							player.destroyer.Y = y;
							player.destroyer.R = r;
							player.destroyer.finalized = 1;
						case 1
							player.submarine.placed = 1;
							player.submarine.X = x;
							player.submarine.Y = y;
							player.submarine.R = r;
							player.submarine.finalized = 1;
						case 2
							player.cruiser.placed = 1;
							player.cruiser.X = x;
							player.cruiser.Y = y;
							player.cruiser.R = r;
							player.cruiser.finalized = 1;
						case 3
							player.battleship.placed = 1;
							player.battleship.X = x;
							player.battleship.Y = y;
							player.battleship.R = r;
							player.battleship.finalized = 1;
						case 4
							player.carrier.placed = 1;
							player.carrier.X = x;
							player.carrier.Y = y;
							player.carrier.R = r;
							player.carrier.finalized = 1;
					end
				end
				
				% If all ships are placed move on
				if playerShipsPlaced == 5
					gamePhase = 2;
				end
			
				% Update the frame
				renderScreen();
				renderShips(player);
				
			% Place enemies ships
            case 2
                length = [5, 4, 3, 3, 2];
				shipID = [5, 4, 6, 3, 2];
				
				% Place all enemy ships in random locations
				while enemyShipsPlaced < 5
					% Get a random location and orientation
					x = randi(10);
					y = randi(10);
					r = randi(2) - 1;
					
					% Check right side
					if x < (10-length(enemyShipsPlaced+1)) && ~r
						valid = 1;
						for i = x:(x+length(enemyShipsPlaced+1)-1)
							if enemyBoard(i, y) ~= 0
								valid = 0;
							end
						end
						
						if valid == 1
							for i = x:(x+length(enemyShipsPlaced+1)-1)
								enemyBoard(i, y) = shipID(enemyShipsPlaced+1);
							end
							
							switch enemyShipsPlaced
								case 0
									enemy.carrier.placed = 1;
									enemy.carrier.X = x;
									enemy.carrier.Y = y;
									enemy.carrier.R = 0;
								case 1
									enemy.battleship.placed = 1;
									enemy.battleship.X = x;
									enemy.battleship.Y = y;
									enemy.battleship.R = 0;
								case 2
									enemy.cruiser.placed = 1;
									enemy.cruiser.X = x;
									enemy.cruiser.Y = y;
									enemy.cruiser.R = 0;
								case 3
									enemy.submarine.placed = 1;
									enemy.submarine.X = x;
									enemy.submarine.Y = y;
									enemy.submarine.R = 0;
								case 4
									enemy.destroyer.placed = 1;
									enemy.destroyer.X = x;
									enemy.destroyer.Y = y;
									enemy.destroyer.R = 0;
							end
							
							enemyShipsPlaced = enemyShipsPlaced + 1;
						end
					
					
					% Check down
					elseif y < (10-length(enemyShipsPlaced+1)) && r
						valid = 1;
						for i = y:(y+length(enemyShipsPlaced+1)-1)
							if enemyBoard(x, i) ~= 0
								valid = 0;
							end
						end
						
						if valid == 1
							for i = y:(y+length(enemyShipsPlaced+1)-1)
								enemyBoard(x, i) = shipID(enemyShipsPlaced+1);
							end
							
							switch enemyShipsPlaced
								case 0
									enemy.carrier.placed = 1;
									enemy.carrier.X = x;
									enemy.carrier.Y = y;
									enemy.carrier.R = 1;
								case 1
									enemy.battleship.placed = 1;
									enemy.battleship.X = x;
									enemy.battleship.Y = y;
									enemy.battleship.R = 1;
								case 2
									enemy.cruiser.placed = 1;
									enemy.cruiser.X = x;
									enemy.cruiser.Y = y;
									enemy.cruiser.R = 1;
								case 3
									enemy.submarine.placed = 1;
									enemy.submarine.X = x;
									enemy.submarine.Y = y;
									enemy.submarine.R = 1;
								case 4
									enemy.destroyer.placed = 1;
									enemy.destroyer.X = x;
									enemy.destroyer.Y = y;
									enemy.destroyer.R = 1;
							end
							
							enemyShipsPlaced = enemyShipsPlaced + 1;
						end
					end
				end
				
				gamePhase = 3;
                
			% Player's turn
			case 3
				% Display tip
				imshow(tipsImgThree, 'XData', [564, 750], 'YData', [607, 750]);
				
				% Check is tile is attackable
				validAttackPoint = 0;
				
				while validAttackPoint == false
                    % get mouse click coordinate
                    [tx, ty] = ginput(1);
                    % convert to tile coordinate
					[x, y] = inputToTileEnemyBoard(tx, ty);
					% check if point is valid
					if x > 0 && y > 0 && x <= 10 && y <= 10
						validAttackPoint = (enemyBoard(x, y) < 10);
					end
                end
                
                % Attack point on grid
				%
				% Will Render either miss tile or hit tile
				%
				% Also checks if audio needs repeated
				switch enemyBoard(x, y)
					case 0
						missRender = imshow(missImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [31 + 33 * (y - 1), 31 + 33 * y]);
						set(missRender, 'AlphaData', missAlpha);
						
						%if isplaying(sfx_splash)
						%	stop(sfx_splash);
						%end
						
						%play(sfx_splash);
					case 2
						enemy.destroyer.health = enemy.destroyer.health - 1;
						hitRender = imshow(hitImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [31 + 33 * (y - 1), 31 + 33 * y]);
						set(hitRender, 'AlphaData', hitAlpha);
						
						%if isplaying(sfx_explosion)
						%	stop(sfx_explosion);
						%end
						
						%play(sfx_explosion);
						
					case 3
						enemy.submarine.health = enemy.submarine.health - 1;
						hitRender = imshow(hitImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [31 + 33 * (y - 1), 31 + 33 * y]);
						set(hitRender, 'AlphaData', hitAlpha);
						
						%if isplaying(sfx_explosion)
						%	stop(sfx_explosion);
						%end
						
						%play(sfx_explosion);
						
					case 6
						enemy.cruiser.health = enemy.cruiser.health - 1;
						hitRender = imshow(hitImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [31 + 33 * (y - 1), 31 + 33 * y]);
						set(hitRender, 'AlphaData', hitAlpha);
						
						%if isplaying(sfx_explosion)
						%	stop(sfx_explosion);
						%end
						
						%play(sfx_explosion);
						
					case 4
						enemy.battleship.health = enemy.battleship.health - 1;
						hitRender = imshow(hitImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [31 + 33 * (y - 1), 31 + 33 * y]);
						set(hitRender, 'AlphaData', hitAlpha);
						
						%if isplaying(sfx_explosion)
						%	stop(sfx_explosion);
						%end
						
						%play(sfx_explosion);
						
					case 5
						enemy.carrier.health = enemy.carrier.health - 1;
						hitRender = imshow(hitImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [31 + 33 * (y - 1), 31 + 33 * y]);
						set(hitRender, 'AlphaData', hitAlpha);
						
						%if isplaying(sfx_explosion)
						%	stop(sfx_explosion);
						%end
						
						%play(sfx_explosion);
						
				end
				
				% Update status on enemy matrix
				enemyBoard(x, y) = enemyBoard(x, y) + 10;
				
				% Check for victory
				if enemy.destroyer.health == 0 && enemy.submarine.health == 0 && enemy.cruiser.health == 0 && enemy.battleship.health == 0 && enemy.carrier.health == 0
					victory = 0;
					gamePhase = 5;
				else
					gamePhase = 4;
				end
				
			% Enemy's Turn
			case 4
				% Display tip and give a 'natural' pause
				imshow(tipsImgFour, 'XData', [564, 750], 'YData', [607, 750]);
				pause(1.5);
				
				% Set x and y to last tile attacked
				validAttackPoint = 0;
				x = lastEnemyCoord(1);
				y = lastEnemyCoord(2);
				
				% Calculate tile to attack
				while validAttackPoint == false
					% If there was no hit last time find random tile
					if ~enemyState
						x = randi(10);
						y = randi(10);
					else
						% If there was a hit begin hitting tiles around
						% last known hit.
						switch enemyState
							case 1
								if x == 1
									enemyState = enemyState + 1;
								elseif playerBoard(x - 1, y) == 10
									enemyState = enemyState + 1;
								else
									x = x - 1;
								end
							case 2
								if x == 10
									enemyState = enemyState + 1;
								elseif playerBoard(x + 1, y) == 10
									enemyState = enemyState + 1;
								else
									x = x + 1;
								end
							case 3
								if y == 1
									enemyState = enemyState + 1;
								elseif playerBoard(x, y - 1) == 10
									enemyState = enemyState + 1;
								else
									y = y - 1;
								end
							case 4
								if y == 10
									enemyState = enemyState + 1;
								elseif playerBoard(x, y + 1) == 10
									enemyState = enemyState + 1;
								else
									y = y + 1;
								end
							case 5
								enemyState = 0;
						end
					end
					
					% check if point is valid
					validAttackPoint = (playerBoard(x, y) < 10);
                end
                
                % Attack point on grid
				%
				% Renders hit or miss image and plays audio accordingly
				switch playerBoard(x, y)
					case 0
						missRender = imshow(missImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [407 + 33 * (y - 1), 407 + 33 * y]);
						set(missRender, 'AlphaData', missAlpha);
						
						%play(sfx_splash);
					case 2
						player.destroyer.health = player.destroyer.health - 1;
						hitRender = imshow(hitImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [407 + 33 * (y - 1), 407 + 33 * y]);
						set(hitRender, 'AlphaData', hitAlpha);
						
						%play(sfx_explosion);
					case 3
						player.submarine.health = player.submarine.health - 1;
						hitRender = imshow(hitImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [407 + 33 * (y - 1), 407 + 33 * y]);
						set(hitRender, 'AlphaData', hitAlpha);
						
						%play(sfx_explosion);
					case 6
						player.cruiser.health = player.cruiser.health - 1;
						hitRender = imshow(hitImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [407 + 33 * (y - 1), 407 + 33 * y]);
						set(hitRender, 'AlphaData', hitAlpha);
						
						%play(sfx_explosion);
					case 4
						player.battleship.health = player.battleship.health - 1;
						hitRender = imshow(hitImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [407 + 33 * (y - 1), 407 + 33 * y]);
						set(hitRender, 'AlphaData', hitAlpha);
						
						%play(sfx_explosion);
					case 5
						player.carrier.health = player.carrier.health - 1;
						hitRender = imshow(hitImg, 'XData', [220 + 33 * (x - 1), 220 + 33 * x], 'YData', [407 + 33 * (y - 1), 407 + 33 * y]);
						set(hitRender, 'AlphaData', hitAlpha);
						
						%play(sfx_explosion);
				end
				
				% Update player matrix
				playerBoard(x, y) = playerBoard(x, y) + 10;
				
				% Update attack information
				lastEnemyAttack = playerBoard(x, y) > 10;
				
				if lastEnemyAttack && enemyState
					attackSuccess = 1;
				end
				
				% Plan next attack orientation
				if lastEnemyAttack && ~enemyState
					lastEnemyCoord = [x, y];
					enemyState = 1;
				elseif ~lastEnemyAttack && enemyState
					if enemyState == 2 && attackSuccess
						enemyState = 0;
						attackSuccess = 0;
					end
					
					enemyState = enemyState + 1;
					
					if enemyState > 4
						enemyState = 0;
						attackSuccess = 0;
					end
				end
				
				% Check for victory
				if player.destroyer.health == 0 && player.submarine.health == 0 && player.cruiser.health == 0 && player.battleship.health == 0 && player.carrier.health == 0
					victory = 1;
					gamePhase = 5;
				else
					gamePhase = 3;
				end
				
			case 5
				% Display victory window and end the game
				if victory
					[computerWinImg, ~, computerWinAlpha] = imread('images/computerWin.png');
					computerWinRender = imshow(computerWinImg, 'XData', [264, 495], 'YData', [314, 445]);
					set(computerWinRender, 'AlphaData', computerWinAlpha);
				else
					[playerWinImg, ~, playerWinAlpha] = imread('images/playerWin.png');
					playerWinRender = imshow(playerWinImg, 'XData', [264, 495], 'YData', [314, 445]);
					set(playerWinRender, 'AlphaData', playerWinAlpha);
				end
				gamePhase = 0;
		end
	end
	
	% Keyboard callback function
	function keyDown(~, event)
		if strcmpi(event.Key, 'R')
			KEY_R = 1;
		elseif strcmpi(event.Key,'escape')
			KEY_ESC = 1;
		elseif strcmpi(event.Key, 'return')
			KEY_ENTER = 1;
		elseif strcmpi(event.Key, 'M')
			KEY_M = 1;
		end
	end
end
