%{
@ name find_cols_centers
@ description - En base al tamaño de cada contenedor y al (0,0) encuentra
donde se ubicarian los centro de cada columna
@ params {float} step - Ancho de un contenedor
@ params {float} delta - Indicaria un error a considerar (ya que los contenedores no se encuentran exactamente pegados)
@ params {int} n_cols - Cantidad de columnas del barco.
@ returns {array} centers - Contiene los centros de cada columna.
%}


function [centers] = find_cols_centers(step,delta,n_cols)
    centers = [];
    for i=1:n_cols
        centers(1,i)= 2*step*i+delta-step;
    end
end
