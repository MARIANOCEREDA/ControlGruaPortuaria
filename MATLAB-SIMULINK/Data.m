
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
mt = 50000;
% - Wheel primitive radius[m]
Rw = 0.5;
% Intertia of wheels (slow shaft)[kg.m2]
Jw = 2.0;
% Reduction value
rt = 15;
% Interia of motor + break [kg.m2]
Jm = 10;
% - Trolley friction [Nms]
bt = 0;
% - Equivalent rotation friction (motor + wheel): (bw + bm/r^2)
beq_rot = 30;
% Equivalent Mechanical friction motor +wheel + trolley [Nm/(rad/s)]
beqt = bt + (beq_rot*rt^2)/(Rw^2);
% - Equivalent mass of motor + trolley [kg.m2]
Meqt=mt+(Jw+Jm*rt^2)/(Rw^2); 
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
% - Fixed height of trolley and hoisting system [m]
yt0 = 45;
% - Still beam [m]
YSB = 15;
% - Wire rope traction stiffness[N/m]
Kw = 1800e3;
% - Drum radius[m]
Rd = 0.75;
% - Internal friction of wire [kN/(m/s)];
bw = 30;
% - Primitive radius of drum[kh.m2]
Jd = 8.0;
% - Reduction
rth = 30/1;
% - Interia of motor + break [kg.m2]
Jmh = 30;
% - Equivalent Mechanical friction [Nm/(rad/s)]
beqh = 18;
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
Kcy = 1.3e8;
% - Vertical friction [kN/(m/s)]
bcy = 1000;
% - Horizontal friction [kN/(m/s)]
bcx = 1000;
% - Gravity
g = 9.80665;
% - Spreader mass [kg]
sp_mass = 1500;
% - Minimum container mass[kg]
min_m = 200;
% - Maximum container mass[kg]
max_m = 50000;
% - Random mass
cont_mass = random_mass(min_m,max_m);

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
w_posh = 10*beqh/Meqh;
% - Ksat[]
Ksah = Meqh*nh*w_posh^2;
% - bat[]
bah = Meqh*nh*w_posh;
% - Ksia[]
Ksiah = Meqh*w_posh^3;
