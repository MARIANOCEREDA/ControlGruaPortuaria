%function [] = generateTrajectory(init,weight,to_where)
init = 1;
weight = 23562;
to_where = 'to_ship';
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
    
    ship.index_higher_col = find(cols_height==ship.higher_col);
    
    
    %Generar array que contiene los centros de cada columna respecto al
    %muelle
    delta = 0; %Gap que representa la distancia lateral entre contendores
    cols_centers = ship.allocate_centers(container.width/2,delta);
    disp(cols_centers)
    
    ship.plot_containers(cols_height,cols_centers);
    ship.print();
end

%% Comienzo de generacion de la trayectoria dependiendo de la situacion
vt_max=4;%[m/s]
vh_max=1.5;%[m/s]
slope=atan(vh_max/vt_max);

switch (to_where)
    case 'to_dock'
    
    case 'to_ship'  
        
        p1=[-20,0];
        index_goal=randi([1,n_cols],1,1);
        p6=[cols_centers(index_goal),cols_height(index_goal)];
        left_cols=cols_height(1:index_goal);
        max=0;
        for i=1:index_goal
            if left_cols(i)>=max

                if left_cols(i)>max
                    imax_left=i;
                    max=left_cols(i);
                else
                    imax_rigth=i;
                    max=left_cols(i);
                end
            end
        end
       % calculo de p3 y p2
       h_safe=max+2*c_height;
       x_safe=cols_centers(imax_left)-c_width;
       p3=[x_safe,h_safe];
       p2=[-20, p3(2)-tan(slope)*(p3(1)-p1(1))];
       e=0;
       next_index=imax_left-1;
       hold on
       while next_index>0
           y23=p3(2)-tan(slope)*(p3(1)-cols_centers(next_index));
           if y23<cols_height(next_index)+2*c_height  
                e=e+1;
                p3=[x_safe-e*c_width,h_safe];
                p2=[-20, p3(2)-tan(slope)*(p3(1)-p1(1))];
                next_index=imax_left;
                disp('true')
                plot([p2(1) p3(1)],[p2(2) p3(2)],'r')
           end
           next_index=next_index-1;
       end
       plot([p2(1) p3(1)],[p2(2) p3(2)],'r')
       
       % calculo de p4 y p5

       x_safe=cols_centers(imax_rigth)+c_width;
       p4=[x_safe,h_safe];
       p5=[p6(1), p4(2)+tan(slope)*(p4(1)-p6(1))];
       e=0;
       next_index=imax_rigth+1;
       hold on
       while next_index<=index_goal
           y45=p4(2)+tan(slope)*(p4(1)-cols_centers(next_index));
           if y45<cols_height(next_index)+2*c_height  
                e=e+1;
                p4=[x_safe+e*c_width,h_safe];
                p5=[p6(1), p4(2)+tan(slope)*(p4(1)-p6(1))];
                next_index=imax_rigth;
                disp('true2')
                plot([p4(1) p5(1)],[p4(2) p5(2)],'r')
           end
           next_index=next_index+1;
       end
       plot([p4(1) p5(1)],[p4(2) p5(2)],'r')
       
    end
%end




