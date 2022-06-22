%{
@name generate_cols_height
@description - Genera aleatoriamente las alturas de cada columna de
contenedores. Pueden ser alturas sobre o debajo el nivel del muelle.
@params {int} max_n_cnts - Indica la maxima cantidad de contenedores por
columna
@params {int} n_cols - Indica cantidad de columnas del barco.
@params {float} c_height - Altura de un contenedor
@return {array} h_cols - Array que contiene las alturas de cada columna (sobre muelle)
%}

function [h_cols] = generate_cols_height(max_n_cnts,n_cols,c_height,c_under_dock)
    rng('shuffle')
    h_cols = c_height * randi([-c_under_dock,max_n_cnts],n_cols,1);
end

