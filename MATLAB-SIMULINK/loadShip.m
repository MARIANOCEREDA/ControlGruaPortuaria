%{
@name loadShip
@description Generates random values that simulates the height of each
column on the ship.
@params no-params
@return array of size "cols_ship" containing the height of each column.
%}

function [heights] = loadShip()
n_c = 10; %amount of containers
height_c = 2.89; %height of each container
cols_ship = 20; %amount of container columns over the ship over the dock (0,0) point.s
rng('default')
heights = height_c + (n_c*height_c-height_c).*rand(cols_ship,1);
disp(heights)
end

