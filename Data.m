
%% ##########################################
% ######## Trolley translation ##############
% ###########################################
% - X limits[m]
xmin = -30;
xmax = 50;
% - Speed limits[m/s]
dxmin = -4;
dxmax = 4;
% - Aceleration limits[m/s2]
ddxmin = -1;
ddxmax = 1;
% - Trolley mass[kg]
mc = 5000;
% - Wheel primitive radius[m]
Rw = 0.5;
% Intertia of wheels (slow shaft)[kg.m2]
Jw = 2.0;
% Reduction value
rt = 15/1;
% Interia of motor + break [kg.m2]
Jm = 10;
% Mechanical friction [Nm/(rad/s)]
beq = 30;
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
% - Wire rope traction stiffness[kN/m]
Kw = 1800;
% - Internal friction of wire [kN/(m/s)];
bw = 30;
% - Primitive radius of drum[kh.m2]
Jd = 8.0;
% - Reduction
rth = 30/1;
% - Interia of motor + break [kg.m2]
Jmh = 30;
% - Mechanical friction [Nm/(rad/s)]
beqh = 18;
% - Mechanical friction of drum (to be defined)
% bd = 
% - Mechanical friction of hoisting motor (to de defined)
% bmh = 


