%function [] = generateTrajectory(init,weight,to_where)
init = 1;
weight = 23562;
to_where = 'to_dock';
%% Defincion de los parametros iniciales previo a comenzar el trayecto

if init
    % Dimensiones de un contendor maritimo [metros]
    c_height = 2.89;
    c_weight = weight;
    c_width = 2.438;
    
    % Creamos el objeto contenedor
    container = Container(c_height,c_weight,c_width);
    
    %Dimensiones del barco (ship) [metros]
    s_width = 45;
    n_cols = round(s_width/c_width); % Cantidad de columnas del barco
    max_n_cnts = 10; % Cantidad maxima de containers (altura sobre muelle)
    
    %Creamos el objeto barco
    ship = Ship(s_width,n_cols,max_n_cnts);
    cols_height = ship.load(container);
    disp(cols_height)
    ship.higher_col = max(cols_height);
    ship.index_higher_col = find(cols_height==ship.higher_col);
    ship.plot_containers(cols_height);
    
    %Generar array que contiene los centros de cada columna respecto al
    %muelle
    delta = 0.1; %Gap que representa la distancia lateral entre contendores
    cols_centers = ship.allocate_centers(container.width/2,delta);
    disp(cols_centers)
    ship.print();
end

%% Comienzo de generacion de la trayectoria dependiendo de la situacion

switch (to_where)
    case 'to_dock'
    case 'to_ship'
end
%end




