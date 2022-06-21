%{
@ name plot_containers
@ description - Plotea un histograma que simula los contenedores dentro del
barco.
@ params {array} h_cols - altura de cada columna de contenedores (altura sobre muellee)
@ params {array} centers - contiene los centros de cada una de las columnas
con respecto al origen
%}


function [] = plot_containers(h_cols,centers)
    bar(centers,h_cols);
end