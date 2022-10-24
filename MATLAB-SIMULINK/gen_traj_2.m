% function [p00,p11,p22,p33,p44,p55,p66,p77] = generate_trajectory_2 (ml_,VH_MAX_,VT_MAX_,to_where_,loading_,cols_height_,cols_centers_,mode,index_)

where = "to_ship";
plt_traj = "true";
cycle_type = "single";
operation_mode = "loading";
index_ = 5;
cols_centers_ = [5,10,15,20,25,30,35,40,45];
cols_height_ = [20,26,19,8,26,20,26,23,23];

%% Renombramiento de variables 

% Definimos dimensiones de un contendor maritimo [metros]
C_HEIGHT = 2.89;
C_WIDTH = 2.438;

% Definimos dimensiones del barco (ship) [metros]
N_COLS = 9; % Cantidad de columnas del barco
MAX_C_OVER_DOCK= 9; % Cantidad maxima de containers sobre nivel del muelle

%% Comienzo de generacion de la trayectoria dependiendo de la situacion

slope=atan(1.5/4); %pendiente
% Definimos el punto de inicio (p1) en el muelle con coordenadas x,y
p00=[-20,C_HEIGHT];

% Generamos un numero aleatorio que nos dice a que numero de columna debemos llevar el contenedor. Definimos asi p6.

% Indice de columna objetivo
index_goal=index_;

% Coordenada (x,y) de columna objetivo
p77=[cols_centers_(index_goal),cols_height_(index_goal)+C_HEIGHT];

% Generamos un vector que solo contenga las columnas a la izquierda del punto objetivo. Son los unicos puntos que importan.
left_cols=cols_height_(1:index_goal);

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
H_SAFE=max+2*C_HEIGHT;
H_AUTO = 5;
% Se considera la altura de 2 contenedores para seguridad
%H_SAFE=max+4*C_HEIGHT;

p55 = [p77(1),H_SAFE];         %previous --> max+2*C_HEIGHT instof  H_SAFE
p66 = [p77(1),p77(2)+(p55(2)-p77(2))*0.7]; 
p44 = [p77(1) - 13,H_SAFE];
p33 = [-5,H_SAFE];
p22 = [p00(1),H_SAFE-12];
p11 = [p00(1),10];


switch(where)    
    case "to_ship"
        switch(operation_mode)
            case "loading"
                % Puntos de viraje para velocidad maxima               
                 % Puntos de viraje para velocidad maxima               
                 p55 = [p77(1),max+2*C_HEIGHT];
                 %p66 = [p77(1),p77(2)+(p55(2)-p77(2))*0.7];
                 p66 = [p77(1),p77(2)+1];
                 p44 = [p77(1) - 13.2,H_SAFE];
                 p33 = [-5,H_SAFE];
                 
                 if index_goal == 1
                     p44 = [-10,H_SAFE];
                     p33 = [-10,H_SAFE];
                 end
                 
                 if index_goal == 2
                     p44 = [-2,H_SAFE];
                     p33 = [-5,H_SAFE];
                 end
                 
                 p22 = [p00(1),H_SAFE-2*C_HEIGHT];
                 p11 = [p00(1),H_AUTO];
                 
                 
            case "unloading"
                p55 = [p77(1),max+2*C_HEIGHT];
                p66 = [p77(1),p77(2)+(p55(2)-p77(2))*0.7];
                p44 = [p77(1) - 13.2,H_SAFE];
                p33 = [-5,H_SAFE];
                
                 if index_goal == 1
                     p44 = [-10,H_SAFE];
                     p33 = [-10,H_SAFE];
                 end
                
                p22 = [p00(1),max];
                p11 = [p00(1),H_AUTO];
        end
       
              
    case "to_dock"
        switch(operation_mode)
            case "loading"
                p55 = [p77(1),max];
                p66 = [p77(1),p77(2)+(p55(2)-p77(2))*0.7]; %p7(2)+(p5(2)-p77(2))*0.7
                p44 = [p77(1)-2,H_SAFE];
                p33 = [-5,H_SAFE];
                
                if index_goal == 1  || index_goal == 2
                    p55 = [p77(1),H_SAFE];
                    p44 = [p77(1),H_SAFE];
                    p33 = [-4,H_SAFE];
                end
                
                
                p22 = [p00(1),H_SAFE];
                p11 = [p00(1),H_AUTO];

            case "unloading"
                p55 = [p77(1),max];
                p66 = [p77(1),p77(2)+(p55(2)-p77(2))*0.7];
                p44 = [p77(1) - 13.2,H_SAFE];
                p33 = [-5,H_SAFE];
                p22 = [p00(1),H_SAFE];
                p11 = [p00(1),10];    
                disp("to dock loading");
               
        end
        
end

hold on
plot_containers(cols_height,cols_centers);
plot(p00(1),p00(2),"o")
plot(p11(1),p11(2),"o")
plot(p22(1),p22(2),"o")
plot(p33(1),p33(2),"o")
plot(p44(1),p44(2),"o")
plot(p55(1),p55(2),"o")
plot(p66(1),p66(2),"o")
plot(p77(1),p77(2),"o")


%end % end function
