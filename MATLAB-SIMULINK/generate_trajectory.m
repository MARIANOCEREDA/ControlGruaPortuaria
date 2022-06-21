function [] = generate_trajectory(init,weight,to_where,cycle_type)

init = 1;
weight = 23562;
to_where = 'to_dock';
cycle_type = 'single';
plt_traj = "true";
%% Defincion de los parametros iniciales previo a comenzar el trayecto

if init
    % Definimos dimensiones de un contendor maritimo [metros]
    c_height = 2.89;
    c_weight = weight;
    c_width = 2.438;
    
    % Creamos el objeto contenedor
    % container = Container(c_height,c_weight,c_width);
    
    % Definimos dimensiones del barco (ship) [metros]
    s_width = 45;
    n_cols = round(s_width/c_width); % Cantidad de columnas del barco
    max_n_cnts = 10; % Cantidad maxima de containers (altura sobre muelle)
    
    % Generamos de forma aleatoria columnas con diferentes alturas.
    cols_height = generate_cols_height(max_n_cnts,n_cols,c_height);
    
    %Generamos array que contiene los centros de cada columna respecto almuelle
    delta = 0; 
    cols_centers = find_cols_centers(c_width/2,delta,n_cols);
    
end

%% Comienzo de generacion de la trayectoria dependiendo de la situacion
vt_max=4; %[m/s]
vh_max=1.5; %[m/s]
slope=atan(vh_max/vt_max); %pendiente

% Definimos el punto de inicio (p1) en el muelle con coordenadas x,y
p1=[-20,0];

% Generamos un numero aleatorio que nos dice a que numero de columna debemos llevar el contenedor. Definimos asi p6.
index_goal=randi([1,n_cols],1,1);
%index_goal=1;
p6=[cols_centers(index_goal),cols_height(index_goal)];

% Generamos un vector que solo contenga las columnas a la izquierda del punto objetivo. Son los unicos puntos que importan.
left_cols=cols_height(1:index_goal);

% Buscamos los de las columnas de mayor altura , tanto la que se encuentra mas a la izquierda como la que se encuentra mas a la
% derecha.
max=0;
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
h_safe=max+2*c_height;

% Definimos el x de seguridad, que define la coord. x de p3
% Se considera el ancho de un contenedor para seguridad
x_safe=cols_centers(imax_left)-c_width;

% Primer valor de p3, sin verificacion aun.
p3=[x_safe,h_safe];

% Definimos p2 usando trigonometria.
p2=[-20, p3(2)-tan(slope)*(p3(1)-p1(1))];

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
   if y23<cols_height(next_index)+2*c_height

        % Si hay colision, entonces debemos actualizar p3 y por
        % ende, p2. Para actualizar p3 se corre un ancho a la
        % izquierda el punto x de p3.
        e=e+1;
        p3=[x_safe-e*c_width,h_safe];
        p2=[-20, p3(2)-tan(slope)*(p3(1)-p1(1))];
        next_index=imax_left;
   end
   next_index=next_index-1;
end


%%  Calculo de p4 y p5

% Si el contenedor tiene que ir a la primer columna, o tiene que ir
% a un maximo el p4 y p5 en x seran igual al p6 x. En altura seran
%la altura de seguridad
if (index_goal ==1 || max==left_cols(index_goal))
p4=[p6(1), h_safe];
p5=p4;

else
% Definimos el x de seguridad, que define la coord. x de p3
% Se considera el ancho de un contenedor para seguridad
x_safe=cols_centers(imax_right)+c_width;

% Primer valor de p4, sin verificacion aun.
p4=[x_safe,h_safe];

% Definimos p5 usando trigonometria.
p5=[p6(1), p4(2)+tan(slope)*(p4(1)-p6(1))];
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
   if y45<cols_height(next_index)+2*c_height

        % Si hay colision, entonces debemos actualizar p4 y por
        % ende, p5. Para actualizar p4 se corre un ancho a la
        % derecha el punto x de p4.
        e=e+1;
        p4=[x_safe+e*c_width,h_safe];
        p5=[p6(1), p4(2)+tan(slope)*(p4(1)-p6(1))];
        next_index=imax_right;
   end
   next_index=next_index+1;
end
end


switch(to_where)    
    case 'to_ship' 
    % En este caso los puntos seran como se calcularon.
    
    case 'to_dock'       
    % En este caso se invierten los puntos, el p1 sera aleatorio y el p6
    % será un punto fijo en (-20,0). Primero guardamos los puntos en puntos
    % auxiliares y luego se actualizan.
    p1d=p1;
    p2d=p2;
    p3d=p3;
    p4d=p4;
    p5d=p5;
    p6d=p6;
    p6=p1d;
    p5=p2d;
    p4=p3d;
    p3=p4d;
    p2=p5d;
    p1=p6d;
   
end % end switch

%% Plot del perfil de trayectoria obtenido
hold on
if (plt_traj == "true")
    plot_containers(cols_height,cols_centers);
    plot(p1(1),p1(2),'ko')
    plot([p2(1) p3(1)],[p2(2) p3(2)],'r')
    plot([p2(1) p3(1)],[p2(2) p3(2)],'ko')
    plot(p6(1),p6(2),'bo')
    plot([p4(1) p5(1)],[p4(2) p5(2)],'r')
    plot([p4(1) p5(1)],[p4(2) p5(2)],'ko')
end %endif

end % end function




