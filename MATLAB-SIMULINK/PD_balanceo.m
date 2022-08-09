function [Kp,Kd] = PD_balanceo(mt, ml, Meqt)
%G = tf([-(mt+ml) 0],[(Meqt+ml)*lh 0 Meqt]);
Kd = zeros(1,60);
Kp = zeros(1,60);
for lh=1:60
    g=9.81;
    mod = abs(sqrt(complex(-(Meqt*g)/((Meqt+ml)*lh))));
    w_pos = mod*10;
    mEq = -(Meqt+ml)*abs(lh)/(mt+ml);
    nb = 3;
    Kd(lh) = mEq*nb*w_pos;
    Kp(lh) = mEq*nb*(w_pos^2);
end
%Kd=(-((Meqt*g)/(w_pos^2))+((Meqt+ml)*lh))/(ml+mt);
%Kp=2*w_pos*(-lh*((Meqt+ml)/(ml+mt))+Kd);
end
