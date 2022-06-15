classdef Ship
    properties
        width {mustBeNumeric};
        max_n_cnts {mustBeNumeric}; %Max Amount of containers over dock
        n_cols {mustBeNumeric}; % Amount of containers columns
        higher_col {mustBeNumeric};
        index_higher_col {mustBeNumeric};
    end
    methods
        %Constructor
        function obj = Ship(width,n_cols,n_containers)
            obj.width = width;
            obj.max_n_cnts = n_containers;
            obj.n_cols = n_cols;
            obj.higher_col = 0;
            obj.index_higher_col = 0;
        end
        
        %Genera aleatoriamente las alturas de cada columnas sobre el muelle
        %Se toma como punto 0 el muelle.
        function [h_cols] = load(obj,cnt)
            rng('default')
            h_cols = cnt.height + (obj.max_n_cnts*cnt.height-cnt.height)*rand(obj.n_cols,1);
        end
        
        %Genera un array con los centros de cada columna de contenedores
        %Se toma como punto 0 donde esta en contacto puerto y barco. (0,0)
        function [centers] = allocate_centers(obj,step,delta)
            centers = [];
            for i=1:obj.n_cols
                centers(1,i)= 2*step*i+delta;
            end
        end
        
        function plot_containers(obj,h_cols)
            bar(1:obj.n_cols,h_cols);
        end
        
        function print(obj)
            fprintf("-----------Informacion sobre Barco---------------- \n");
            fprintf("Ancho: %f \n",obj.width);
            fprintf("Cantidad de columnas de contenedores: %f \n",obj.n_cols);
            fprintf("Maxima cantidad de contenedores sobre muelle: %f \n",obj.max_n_cnts);
            fprintf("Altura de maxima columna: %f \n",obj.higher_col);
            fprintf("Indice de columna con mayor altura: %f \n",obj.index_higher_col);
            fprintf("------------------------------------------------------\n");
        end
    end
end