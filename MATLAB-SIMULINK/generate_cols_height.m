%{
@name loadShip
@description Generates random values that simulates the height of each
column on the ship.
@params no-params
@return array of size "cols_ship" containing the height of each column.
%}

function [h_cols] = generate_cols_height(max_n_cnts,n_cols,c_height)
    rng('shuffle')
    h_cols = c_height * randi([0,max_n_cnts],n_cols,1);
end

