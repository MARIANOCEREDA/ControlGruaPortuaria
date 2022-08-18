%function [p0,p1,p2,p3,p4,p5,p6,p7,VH_MAX,VT_MAX] = generate_trajectory(weight,to_where,cycle_type,cols_height,cols_centers)

weight = 23562;
where = 'to_ship';
cycle_type = 'single';
plt_traj = "true";
operation_mode = 'loading';

%% Defincion de los parametros iniciales previo a comenzar el trayecto


% Velocidades maximas a alcanzar por carro e izaje
VT_MAX=4; %[m/s]
VH_MAX=1.5; %[m/s]
YSB=15;

% Definimos dimensiones de un contendor maritimo [metros]
C_HEIGHT = 2.89;
C_WIDTH = 2.5;
c_weight = weight;

% Definimos dimensiones del barco (ship) [metros]
S_WIDTH = 45;
N_COLS = round(S_WIDTH/C_WIDTH); % Cantidad de columnas del barco
MAX_C_OVER_DOCK= 9; % Cantidad maxima de containers sobre nivel del muelle
MAX_C_UNDER_DOCK = 4; % cantidad de containers por debajo del nivel del muelle [metros]

% Generamos de forma aleatoria columnas con diferentes alturas.
%cols_height = generate_cols_height(MAX_C_OVER_DOCK,N_COLS,C_HEIGHT,MAX_C_UNDER_DOCK);

%Generamos array que contiene los centros de cada columna respecto al
%muelle (punto 0,0)
%delta = 0; 
%cols_centers = find_cols_centers(C_WIDTH/2,delta,N_COLS);
    

%% Comienzo de generacion de la trayectoria dependiendo de la situacion
slope=atan(VH_MAX/(VT_MAX*0.6)); %pendiente
% Definimos el punto de inicio (p1) en el muelle con coordenadas x,y
p0=[-20,0];

% Indice de columna objetivo
index_goal=9;

% Coordenada (x,y) de columna objetivo
p7=[cols_centers(index_goal),cols_height(index_goal)];

% Generamos un vector que solo contenga las columnas a la izquierda del punto objetivo. Son los unicos puntos que importan.
left_cols=cols_height(1:index_goal);

% Buscamos los de las columnas de mayor altura , tanto la que se encuentra mas a la izquierda como la que se encuentra mas a la
% derecha.
max=0;
imax_left=0;
imax_right=0;
for i=1:index_goal
    if left_cols(i)>=max
        imax_right=i;
        if left_cols(i)>max
            imax_left=i;
        end
    max=left_cols(i);
    end
end

%% Calculo de p3 y p2

% Definimos la altura de seguridad que me definira la coord y de p3.
% Se considera la altura de 2 contenedores para seguridad
H_SAFE=max+4*C_HEIGHT;

% Definimos el x de seguridad, que define la coord. x de p3
% Se considera el ancho de un contenedor para seguridad
x_safe=cols_centers(imax_left)-C_WIDTH;

% Primer valor de p3, sin verificacion aun.
p3=[x_safe,H_SAFE];

% Definimos p2 usando trigonometria.
p2=[-20, p3(2)-tan(slope)*(p3(1)-p0(1))];

% Bucle que verifica que la trayectoria de p3 a p2 no con otra columna. Si esto ocurre, modificamos el valor de p3
% y por ende de p2.
e=0;
next_index=imax_left-1;
while next_index>0

   % y23 indica el valor de la recta que une p2 con p3 en el punto
   % central de cada columna.
   y23=p3(2)-tan(slope)*(p3(1)-cols_centers(next_index));

   % Verificamos que no haya colision entre la recta que une p2
   % con p3 (mas una distancia de seguridad) y la columna.
   if y23<cols_height(next_index)+2*C_HEIGHT

        % Si hay colision, entonces debemos actualizar p3 y por
        % ende, p2. Para actualizar p3 se corre un ancho a la
        % izquierda el punto x de p3.
        e=e+1;
        p3=[x_safe-e*C_WIDTH,H_SAFE];
        p2=[-20, p3(2)-tan(slope)*(p3(1)-p0(1))];
        next_index=imax_left;
   end
   next_index=next_index-1;
end


%%  Calculo de p4 y p5

% Si el contenedor tiene que ir a la primer columna, o tiene que ir
% a un maximo el p4 y p5 en x seran igual al p6 x. En altura seran
%la altura de seguridad
if (index_goal ==1 || max==left_cols(index_goal))
    p4=[p7(1),H_SAFE];
    p5=p4;

else
    % Definimos el x de seguridad, que define la coord. x de p3
    % Se considera el ancho de un contenedor para seguridad
    x_safe=cols_centers(imax_right)+C_WIDTH;

    % Primer valor de p4, sin verificacion aun.
    p4=[x_safe,H_SAFE];

    % Definimos p5 usando trigonometria.
    p5=[p7(1), p4(2)+tan(slope)*(p4(1)-p7(1))];
    % Bucle que verifica que la trayectoria de p4 a p5 no con otra
    % columna. Si esto ocurre, modificamos el valor de p4
    % y por ende de p5.
    e=0;
    next_index=imax_right+1;
    while next_index<=index_goal

       % y45 indica el valor de la recta que une p4 con p5 en el punto
       % central de cada columna.
       y45=p4(2)+tan(slope)*(p4(1)-cols_centers(next_index));

       % Verificamos que no haya colision entre la recta que une p4
       % con p5 (mas una distancia de seguridad) y la columna.
       if y45<cols_height(next_index)+2*C_HEIGHT

            % Si hay colision, entonces debemos actualizar p4 y por
            % ende, p5. Para actualizar p4 se corre un ancho a la
            % derecha el punto x de p4.
            e=e+1;
            p4=[x_safe+e*C_WIDTH,H_SAFE];
            p5=[p7(1), p4(2)+tan(slope)*(p4(1)-p7(1))];
            next_index=imax_right;
       end
       next_index=next_index+1;
    end
end

p1 = [p0(1),(p2(2)-p0(2))/2];
p6 = [p7(1),(p5(2)-p7(2))/2+p7(2)];

%{
switch(to_where)    
    case 'to_ship' 
    % Puntos donde comienzan cambios de direccion / velocidad para TO SHIP
    p1122 = [ p1(1) + (p2(1) - p1(1))*route_percent_1,p1(2) + (p2(2) - p1(2))*route_percent_1];
    p2233 = [ -break_point_y/slope + p3(1),p3(2)-break_point_y];
    p3344 = [ p4(1)-break_point_x/2,p4(2)];
    p4455 = [ p5(1) - 3.5*break_point_x,3.5*break_point_x*slope + p5(2)];
    p5566 = [ p5(1) + (p6(1) - p5(1))*route_percent_1,p5(2) + (p6(2) - p5(2))*route_percent_1];
    
    case 'to_dock'       
    % En este caso se invierten los puntos, el p1 sera aleatorio y el p6
    % será un punto fijo en (-20,0). Primero guardamos los puntos en puntos
    % auxiliares y luego se actualizan.
    p0d=p0;
    p1d=p1;
    p2d=p2;
    p3d=p3;
    p4d=p4;
    p5d=p5;
    p6d=p6;
    p7d=p7;
    p7=p7d;
    p6=p1d;
    p5=p2d;
    p4=p3d;
    p3=p4d;
    p2=p5d;
    p1=p6d;
    p0=p0d;
    
    % Puntos donde comienzan cambios de direccion / velocidad para TO DOCK
    p1122 = [ p1(1) + (p2(1) - p1(1))*route_percent_1,p1(2) + (p2(2) - p1(2))*route_percent_1];
    p2233 = [ -break_point_y/slope + p3(1),p3(2)-break_point_y];
    p3344 = [ p4(1)-break_point_x/2,p4(2)];
    p4455 = [ p5(1) - 3.5*break_point_x,3.5*break_point_x*slope + p5(2)];
    p5566 = [ p5(1) + (p6(1) - p5(1))*route_percent_1,p5(2) + (p6(2) - p5(2))*route_percent_1];
    
   
end % end switch
%}



%% Decision de puntos de viraje según estado del barco
% Puntos de viraje para velocidad media

break_point_y_MAX = ((VH_MAX/2)^2)/(2*(ddymax));
break_point_x_MAX = ((VT_MAX/2)^2)/(2*(ddxmax));

% Puntos de viraje para velocidad maxima
break_point_y = ((VH_MAX)^2)/(2*(ddymax));
break_point_x = ((VT_MAX)^2)/(2*(ddxmax));

route_percent_1 = 0.8;

p00 = p0;
p11 = p1;
p22 = p2;
p33 = p3;
p44 = p4;
p55 = p5;
p66 = p6;
p77 = p7;

%% Definimos puntos guia cuando falte el 10% para llegar al siguiente punto
% para que en ese punto comience a bajar la velocidad de a poco
switch(where)    
    case "to_ship"
        switch(operation_mode)
            case "loading"
                % Puntos de viraje para velocidad maxima
                break_point_y = ((VH_MAX)^2)/(2*1);
                break_point_x = ((VT_MAX)^2)/(2*1);
                route_percent_1 = 0.65; % 0.9
                p1122 = [ p1(1) + (p2(1) - p1(1))*route_percent_1,p1(2) + (p2(2) - p1(2))*route_percent_1];
                p2233 = [ -2*break_point_y/slope + p3(1),p3(2)-1.5*break_point_y/slope];
                p3344 = [ p3(1) + (p4(1) - p3(1))*route_percent_1,p3(2) + (p4(2) - p3(2))*route_percent_1 ];
                p4455 = [ p5(1) - 1.6*break_point_x,1.6*break_point_x*slope + p5(2)];
                p5566 = [ p5(1) + (p6(1) - p5(1))*route_percent_1,p5(2) + (p6(2) - p5(2))*route_percent_1];
                disp("to ship loading");
            case "unloading"
                break_point_y = ((VH_MAX)^2)/(2*1);
                break_point_x = ((VT_MAX)^2)/(2*1);
                route_percent_1 = 0.8;
                p1122 = [ p1(1) + (p2(1) - p1(1))*route_percent_1,p1(2) + (p2(2) - p1(2))*route_percent_1*1.2];
                p2233 = [ -1.5*break_point_x + p3(1),p3(2)-1.5*break_point_x];
                p3344 = [ p3(1) + (p4(1) - p3(1))*route_percent_1,p3(2) + (p4(2) - p3(2))*route_percent_1 ];
                p4455 = [ p5(1) - 2*break_point_x,2*break_point_x*slope + p5(2)];
                p5566 = [ p5(1) + (p6(1) - p5(1))*route_percent_1*2,p5(2) + (p6(2) - p5(2))*route_percent_1*2];
                disp("to ship unloading");
        end
       
    case "to_dock"
        switch(operation_mode)
            case "loading"
                % Puntos de viraje para velocidad maxima
                break_point_y = ((VH_MAX)^2)/(2*1);
                break_point_x = ((VT_MAX)^2)/(2*1);
                route_percent_1 = 0.6;
                p1122 = [ p1(1) + (p2(1) - p1(1))*route_percent_1,p1(2) + (p2(2) - p1(2))*route_percent_1];
                p5566 = [ p6(1) + (p5(1) - p6(1))*route_percent_1,p6(2) + (p5(2) - p6(2))*route_percent_1]; %p65
                p4455 = [ break_point_y/slope + p4(1),p4(2)-break_point_y ]; %p54
                p3344 = [ p4(1) + (p3(1) - p4(1))*route_percent_1,p4(2) + (p3(2) - p4(2))*route_percent_1]; %p43
                p2233 = [ p2(1) + 2*break_point_x,2*break_point_x*slope + p2(2) ]; %p32
            
            case "unloading"
                break_point_y = ((VH_MAX/1.6666)^2)/(2*1);
                break_point_x = ((VT_MAX/1.6666)^2)/(2*1);
                route_percent_1 = 0.6;
                p1122 = [ p1(1) + (p2(1) - p1(1))*route_percent_1,p1(2) + (p2(2) - p1(2))*route_percent_1];
                p5566 = [ p6(1) + (p5(1) - p6(1))*route_percent_1,p6(2) + (p5(2) - p6(2))*route_percent_1]; %p65
                p4455 = [ break_point_y/slope + p4(1),p4(2)-break_point_y ]; %p54
                p3344 = [ p4(1) + (p3(1) - p4(1))*route_percent_1,p4(2) + (p3(2) - p4(2))*route_percent_1]; %p43
                p2233 = [ p2(1) + 3.5*break_point_x,3.5*break_point_x*slope + p2(2) ]; %p32
                
        end
        
end

yc0xt = cols_height;

hold on
grid on
if (plt_traj == "true")
    plot_containers(cols_height,cols_centers);
    plot(p0(1),p0(2),'ko')
    plot(p1(1),p1(2),'ko')
    plot([p2(1) p3(1)],[p2(2) p3(2)],'r')
    plot([p2(1) p3(1)],[p2(2) p3(2)],'ko')
    plot(p6(1),p6(2),'ko')
    plot(p7(1),p7(2),'bo')
    plot([p4(1) p5(1)],[p4(2) p5(2)],'r')
    plot([p4(1) p5(1)],[p4(2) p5(2)],'ko')
    plot(p1122(1),p1122(2),'b*')
    plot(p2233(1),p2233(2),'bo')
    plot(p3344(1),p3344(2),'bx')
    plot(p4455(1),p4455(2),'b.')
    plot(p5566(1),p5566(2),'bs')
end %endif

%% ############################################
% ########### PLOT SIMULATION GRAPH ###########
% #############################################

% Plot for index_goal = 9
% plot(xl_to_dock_unloading.data, yl_to_dock_unloading.data);

% Plot for index_goal = 7
plot(xl_sim.data, yl_sim.data);

%end % end function




