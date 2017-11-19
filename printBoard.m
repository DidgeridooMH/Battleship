% ==========================================================
% printBoard function
%
% Authors: Daniel Simpkins
%
% Useful debug tool that prints the given board to the
% command console.
% ==========================================================

function printBoard(pb)
	fprintf('\n');
    for y = 1:10
        for x= 1:10
            fprintf('%i\t', pb(x,y));
        end
        fprintf('\n');
    end
end