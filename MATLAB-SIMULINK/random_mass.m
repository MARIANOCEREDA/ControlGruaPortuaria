%{
@ name random_mass
@ description - Genera una masa aleatoria para agregar al contenedor entre
los valores minimos y maximos de carga preestablecidos
@ params {min,max} - carga minima y maxima posibles respectivamente
@ returns {container_mass} - masa del contenedor (no incluye spreader)
%}

function container_mass = random_mass(min,max)
    container_mass = min+rand(1,1)*(max-min);
end