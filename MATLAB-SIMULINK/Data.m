
%% #####################################
% ######## DATOS CONTAINER Y BARCO ####
% ######################w###############
% ###############
dt=1/50;
C_HEIGHT = 2.89;
C_WIDTH = 2.5; 
S_WIDTH = 45.0;
%N_COLS = round(S_WIDTH/C_WIDTH); % Cantidad de columnas del barco
N_COLS = 9;
MAX_C_OVER_DOCK= 9; % Cantidad maxima de containers sobre nivel del muelle
MAX_C_UNDER_DOCK = 4; % cantidad de containers por debajo del nivel del muelle [metros]
delta = 0.0; 
%cols_height = generate_cols_height(MAX_C_OVER_DOCK,N_COLS,C_HEIGHT,MAX_C_UNDER_DOCK);
% cols_centers = find_cols_centers(C_WIDTH/2,delta,N_COLS);
cols_centers = [5,10,15,20,25,30,35,40,45];
% cols_height = [30,34,19,30,35,30,30,23,23];
cols_height = [20,26,19,8,26,20,26,23,23];
plot_containers(cols_height,cols_centers);
%% ##########################################
% ######## Trolley translation ##############
% ###########################################
% - X limits[m]
xmin = -30;
xmax = 50;
% - Speed limits[m/s]
VT_MAX=4; %[m/s]
VH_MAX=1.5; %[m/s]
% - Aceleration limits[m/s2]
ddxmin = -1;
ddxmax = 1;
% - Trolley mass[kg]
mt = 50000.0;
% - Wheel primitive radius[m]
Rw = 0.5;
% Intertia of wheels (slow shaft)[kg.m2]
Jw = 2.0;
% Reduction value
rt = 15.0;
% Interia of motor + break [kg.m2]
Jm = 10.0;
% - Trolley friction [Nms]
bt = 0.0;
% - Equivalent rotation friction (motor + wheel): (bw + bm/r^2)
beq_rot = 30.0;
% Equivalent Mechanical friction motor +wheel + trolley [Nm/(rad/s)]
beqt = bt + (beq_rot*rt^2)/(Rw^2);
% - Equivalent mass of motor + trolley [kg.m2]
Meqt = mt + (Jw+Jm*rt^2)/(Rw^2); 
%% ##########################################
% ############# Load Hoisting ###############
% ###########################################
% - Y limits[m]
ymin = -20;
ymax = 40;
% - Speed limits[m/s]
dymin = -1.5;
dymax = 1.5;
% - Aceleration limits[m/s2]
ddymin = -1;
ddymax = 1;
% - Still beam [m]
YSB = 15.0;
% - Wire rope traction stiffness[N/m]
Kw = 1800000.0;
% - Drum radius[m]
Rd = 0.75;
% - Internal friction of wire [kN/(m/s)];
bw = 30000.0; %Sgun proyecto cordobes
% - Fixed starting point (initial condition of integrator)
xt0 = -20;
% - Primitive radius of drum[kh.m2]
Jd = 8.0;
% - Reduction
rth = 30.0;
% - Interia of motor + break [kg.m2]
Jmh = 30.0;
% - Equivalent Mechanical friction [Nm/(rad/s)]
beqh = 18.0;
bh = 0;
beqhd = bh + ((beqh*(rth^2))/(Rd^2));
% - Mass of point between wire and drum
Mh = 0;
% - Equivalent mass of motor + break + drum
Meqh = Mh + (Jmh*rth^2 + Jd)/Rd^2;
% - Mechanical friction of drum (to be defined)
% bd = 
% - Mechanical friction of hoisting motor (to de defined)
% bmh = 
% - Vertical stiffnes (rigidez) [kN/m]
Kcy = 1.3e6; %1.3e8 segun PDF, 1.3e6 segun crodobes
% - Vertical friction [kN/(m/s)]
bcy = 500.0; %1000 segund PDF , 500 SEGUN CORDOBES
% - Horizontal friction [kN/(m/s)]
bcx = 1000.0;
% - Gravity
g = 9.80665;
% - Spreader mass [kg]
sp_mass = 15000.0;
% - Fixed height of trolley and hoisting system [m]
yt0 = 45.0;
% yl0 = 0;
% lh0 = yt0 - (sp_mass * g) / Kw;
yl0 = C_HEIGHT + 5; %COndicion inicial carga
l0 = yt0 - yl0;
lh0 = yt0 - C_HEIGHT - 5 + 2*(sp_mass * g) / Kw; %COndicion inicial cable
% - Minimum container mass[kg] -> Empty container
min_m = 2000.0;
% - Maximum container mass[kg]
max_m = 50000.0;
% - Maximun charge mass [kg]
ml_max=max_m+sp_mass;
% - Random mass
%cont_mass = random_mass(min_m,max_m);
cont_mass = max_m;
%% ####################################
% ######### Trolley PID Gains #########
% #####################################
% - nt
nt = 2.5;
% - wpos
w_post = 10*beqt/Meqt;
% - Ksat[]
Ksat = Meqt*nt*w_post^2;
% - bat[]
bat = Meqt*nt*w_post;
% - Ksia[]
Ksiat = Meqt*w_post^3;
%% ####################################
% ######### Hoisting PID Gains ########
% #####################################
% - nh
nh = 2.5;
% - wpos
w_posh = 10*beqhd/Meqh;
% - Ksat[]
Ksah = Meqh*nh*w_posh^2;
% - bat[]
bah = Meqh*nh*w_posh;
% - Ksia[]
Ksiah = Meqh*w_posh^3;
%% #############################
% #### FRECUENCIAS MOD TORQUE ##
% #############################
w_mt_i = 1000;
w_mt_h = 1000;
%% #########################################
% ######## GANANCIAS PD BALANCEO ##########3
% ##########################################
[Kp,Kd] = PD_balanceo(mt, 65000, Meqt);



