% ==========================================================
% renderShips function
%
% Authors: Daniel Simpkins
%
% Render the ships on to the frame for either on the board
% or on the side of the window.
% ==========================================================

function renderShips(player)
	%% Render Destroyer

	% Read destroyer image files
	[destroyerImg, ~, destroyerAlpha] = imread('images/destroyer.png');
	sDestroyerImg = imread('images/greenDestroyer.png');
	
	onBoardDestroyer = 0;
	
	% Check the ships state and orientation to print to screen
	if player.destroyer.placed
		if player.destroyer.R
			onBoardDestroyer = imshow(destroyerImg, 'XData', [220 + 33*(player.destroyer.X - 1), 220 + 33*(player.destroyer.X)], 'YData', [408 + 33*(player.destroyer.Y - 1), 408 + 33 * (player.destroyer.Y) + 33]);
			set(onBoardDestroyer, 'AlphaData', destroyerAlpha);
		else
			rDestroyerImg = imrotate(destroyerImg, 90);
			rDestroyerAlpha = imrotate(destroyerAlpha, 90);
			onBoardDestroyer = imshow(rDestroyerImg, 'XData', [220 + 33*(player.destroyer.X - 1), 220 + 33*(player.destroyer.X) + 33], 'YData', [408 + 33*(player.destroyer.Y - 1), 408 + 33 * (player.destroyer.Y)]);
			set(onBoardDestroyer, 'AlphaData', rDestroyerAlpha);
		end
	end
	
	if ~player.destroyer.finalized
		if player.destroyer.selected
			sDestroyerRender = imshow(sDestroyerImg, 'XData', [ 20, 53 ], 'YData', [400, 466]);
			set(sDestroyerRender, 'AlphaData', destroyerAlpha);
		else
			destroyerRender = imshow(destroyerImg, 'XData', [ 20, 53 ], 'YData', [400, 466]);
			set(destroyerRender, 'AlphaData', destroyerAlpha);
		end
	end
	
	%% Render Submarine
	
	% Read submarine image files
	[submarineImg, ~, submarineAlpha] = imread('images/submarine.png');
	sSubmarineImg = imread('images/greenSubmarine.png');
	
	onBoardSubmarine = 0;
	
	% Check the ships state and orientation to print to screen
	if player.submarine.placed
		if player.submarine.R
			onBoardSubmarine = imshow(submarineImg, 'XData', [220 + 33*(player.submarine.X - 1), 220 + 33*(player.submarine.X)], 'YData', [408 + 33*(player.submarine.Y - 1), 408 + 33 * (player.submarine.Y) + 66]);
			set(onBoardSubmarine, 'AlphaData', submarineAlpha);
		else
			rSubmarineImg = imrotate(submarineImg, 90);
			rSubmarineAlpha = imrotate(submarineAlpha, 90);
			onBoardSubmarine = imshow(rSubmarineImg, 'XData', [220 + 33*(player.submarine.X - 1), 220 + 33*(player.submarine.X) + 66], 'YData', [408 + 33*(player.submarine.Y - 1), 408 + 33 * (player.submarine.Y)]);
			set(onBoardSubmarine, 'AlphaData', rSubmarineAlpha);
		end
	end
	
	if ~player.submarine.finalized
		if player.submarine.selected
			sSubmarineRender = imshow(sSubmarineImg, 'XData', [ 73, 106 ], 'YData', [400, 499]);
			set(sSubmarineRender, 'AlphaData', submarineAlpha);
		else
			submarineRender = imshow(submarineImg, 'XData', [ 73, 106 ], 'YData', [400, 499]);
			set(submarineRender, 'AlphaData', submarineAlpha);
		end
	end
	
	%% Render Cruiser
	
	% Read cruiser image files
	[cruiserImg, ~, cruiserAlpha] = imread('images/cruiser.png');
	sCruiserImg = imread('images/greenCruiser.png');
	
	onBoardCruiser = 0;
	
	% Check the ships state and orientation to print to screen
	if player.cruiser.placed
		if player.cruiser.R
			onBoardCruiser = imshow(cruiserImg, 'XData', [220 + 33*(player.cruiser.X - 1), 220 + 33*(player.cruiser.X)], 'YData', [408 + 33*(player.cruiser.Y - 1), 408 + 33 * (player.cruiser.Y) + 66]);
			set(onBoardCruiser, 'AlphaData', cruiserAlpha);
		else
			rCruiserImg = imrotate(cruiserImg, 90);
			rCruiserAlpha = imrotate(cruiserAlpha, 90);
			onBoardCruiser = imshow(rCruiserImg, 'XData', [220 + 33*(player.cruiser.X - 1), 220 + 33*(player.cruiser.X) + 66], 'YData', [408 + 33*(player.cruiser.Y - 1), 408 + 33 * (player.cruiser.Y)]);
			set(onBoardCruiser, 'AlphaData', rCruiserAlpha);
		end
	end
	
	if ~player.cruiser.finalized
		if player.cruiser.selected
			sCruiserRender = imshow(sCruiserImg, 'XData', [ 126, 159 ], 'YData', [400, 499]);
			set(sCruiserRender, 'AlphaData', cruiserAlpha);
		else
			cruiserRender = imshow(cruiserImg, 'XData', [ 126, 159 ], 'YData', [400, 499]);
			set(cruiserRender, 'AlphaData', cruiserAlpha);
		end
	end
	
	%% Render Battleship
	
	% Read battleship image files
	[battleshipImg, ~, battleshipAlpha] = imread('images/battleship.png');
	sBattleshipImg = imread('images/greenBattleship.png');
	
	onBoardBattleship = 0;
	
	% Check the ships state and orientation to print to screen
	if player.battleship.placed
		if player.battleship.R
			onBoardBattleship = imshow(battleshipImg, 'XData', [220 + 33*(player.battleship.X - 1), 220 + 33*(player.battleship.X)], 'YData', [408 + 33*(player.battleship.Y - 1), 408 + 33 * (player.battleship.Y) + 99]);
			set(onBoardBattleship, 'AlphaData', battleshipAlpha);
		else
			rBattleshipImg = imrotate(battleshipImg, 90);
			rBattleshipAlpha = imrotate(battleshipAlpha, 90);
			onBoardBattleship = imshow(rBattleshipImg, 'XData', [220 + 33*(player.battleship.X - 1), 220 + 33*(player.battleship.X) + 99], 'YData', [408 + 33*(player.battleship.Y - 1), 408 + 33 * (player.battleship.Y)]);
			set(onBoardBattleship, 'AlphaData', rBattleshipAlpha);
		end
	end
	
	if ~player.battleship.finalized
		if player.battleship.selected
			sBattleshipRender = imshow(sBattleshipImg, 'XData', [ 20, 53 ], 'YData', [530, 654]);
			set(sBattleshipRender, 'AlphaData', battleshipAlpha);
		else
			battleshipRender = imshow(battleshipImg, 'XData', [ 20, 53 ], 'YData', [530, 654]);
			set(battleshipRender, 'AlphaData', battleshipAlpha);
		end
	end
	
	%% Render Carrier
	
	% Read battleship image files
	[carrierImg, ~, carrierAlpha] = imread('images/carrier.png');
	sCarrierImg = imread('images/greenCarrier.png');
	
	onBoardCarrier = 0;
	
	% Check the ships state and orientation to print to screen
	if player.carrier.placed
		if player.carrier.R
			onBoardCarrier = imshow(carrierImg, 'XData', [220 + 33*(player. carrier.X - 1), 220 + 33*(player.carrier.X)], 'YData', [408 + 33*(player.carrier.Y - 1), 408 + 33 * (player.carrier.Y) + 132]);
			set(onBoardCarrier, 'AlphaData', carrierAlpha);
		else
			rCarrier = imrotate(carrierImg, 90);
			rCarrierAlpha = imrotate(carrierAlpha, 90);
			onBoardCarrier = imshow(rCarrier, 'XData', [220 + 33*(player.carrier.X - 1), 220 + 33*(player.carrier.X) + 132], 'YData', [408 + 33*(player.carrier.Y - 1), 408 + 33 * (player.carrier.Y)]);
			set(onBoardCarrier, 'AlphaData', rCarrierAlpha);
		end
	end
	
	if ~player.carrier.finalized
		if player.carrier.selected
			sCarrierRender = imshow(sCarrierImg, 'XData', [ 73, 106 ], 'YData', [530, 687]);
			set(sCarrierRender, 'AlphaData', carrierAlpha);
		else
			carrierRender = imshow(carrierImg, 'XData', [ 73, 106 ], 'YData', [530, 687]);
			set(carrierRender, 'AlphaData', carrierAlpha);
		end
	end
	
end