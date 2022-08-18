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

%% Comienzo de generacion de la trayectoria dependiendo de la situacion
%% Comienzo de generacion de la trayectoria dependiendo de la situacion
%slope=atan(VH_MAX_/VT_MAX_); %pendiente
slope=atan(1.5/4); %pendiente
% Definimos el punto de inicio (p1) en el muelle con coordenadas x,y
p0=[-20,0];

% Generamos un numero aleatorio que nos dice a que numero de columna debemos llevar el contenedor. Definimos asi p6.

% Indice de columna objetivo
index_goal=4;

% Coordenada (x,y) de columna objetivo
p7=[cols_centers(index_goal),cols_height(index_goal)+C_HEIGHT];

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
p5 = [p7(1),max+2*C_HEIGHT];
p6 = [p7(1),p7(2)+(p5(2)-p7(2))*0.7];
p4 = [p7(1) - 13,H_SAFE];
p3 = [-5,H_SAFE];
p2 = [p0(1),H_SAFE - 12];
p1 = [p0(1),10];


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
end %endif

%% ############################################
% ########### PLOT SIMULATION GRAPH ###########
% #############################################

% Plot for index_goal = 9
% plot(xl_to_dock_unloading.data, yl_to_dock_unloading.data);

% Plot for index_goal = 7
plot(xl_sim.data, yl_sim.data);
plot(xl_sim_c_4.data,yl_sim_c_4.data);

%end % end function




