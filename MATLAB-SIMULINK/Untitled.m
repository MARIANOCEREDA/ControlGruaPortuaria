function prueba_trayectoria_circular

vymax = 1.5;
vxmax = 4;
time = 0:0.001:4;
j=1;
posx = zeros(length(time));
posy = zeros(length(time));
slope = 1.5/4;
b = 29.46;
vx = 0;
for t=0:0.001:4
    posy(j)= 23.5 + vymax*t;
    vx = vx + 1*t;
    posx(j)= -20 + (1/2)*1*t^2;
    if vx>=vxmax
        posx(j)= -19.59 + vxmax*t;
    end
    j = j+1;
end

j=1;

trajx = zeros(31);
trajy = zeros(31);
for x=-20:1:10
    trajx(j)= x;
    trajy(j)= slope*x + 37;
    j = j+1;
end

hold on
plot(posx,posy);
plot(trajx,trajy);


end