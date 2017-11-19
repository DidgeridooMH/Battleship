% ==========================================================
% renderShips function
%
% Authors: Daniel Simpkins
%
% Renders the main screen elements such as the board,
% grid and letters on the grid. Also, sets up the game
% screen if it is not initialized.
% ==========================================================

function renderScreen()
	global g_gameScreen;

	if g_gameScreen == 0
		% Create the gameboard handle
		g_gameScreen = figure('Name', 'Battleship', 'NumberTitle', 'off', 'Resize', 'off');
		set(gcf, 'Position', [200, 200, 750, 750]);

		% Clean the UI
		set(g_gameScreen, 'MenuBar', 'none');
		set(g_gameScreen, 'ToolBar', 'none');
	end
	
    % Read the background images
    gameBoard = imread('images/gameboard.png');
    [grid, ~, gridAlpha] = imread('images/grid.png');
    
    % Display the gameboard
    imshow(gameBoard, 'Border', 'tight');
    hold on;
    
    % Draw and grid with alpha data
    g = imshow(grid, 'XData', [200,551], 'YData', [387, 738]);
    set(g, 'AlphaData', gridAlpha);
	
    g1 = imshow(grid, 'XData', [200,551], 'YData', [12, 363]);
    set(g1, 'AlphaData', gridAlpha);
end
