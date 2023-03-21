% 6 trabajadores, 12 tareas
array [1..6,1..12] of var 0..1: Assign ;

% Desafío 1: Modelo que asegure que al menos 2 trabajadores estén asignados a cada tarea

constraint forall(j in 1..12)(sum(i in 1..6)(Assign[i,j]) >= 2) ;

% Desafío 2: No existe un trabajador asignado a más de 5 tareas

constraint forall(i in 1..6)(sum(j in 1..12)(Assign[i,j]) <= 5) ;

% Desafío 3: Ciertos pares no pueden ser asignados a la misma tarea
% bad_pair[w1,w2] = 1 means that workers w1 and w2 cannot be assigned to the same task.

array [1..6,1..6] of 0..1: bad_pair =
[|0,1,0,1,0,0
|1,0,0,0,1,0
|1,0,0,1,0,0
|0,0,1,0,1,0
|0,0,1,0,0,0
|0,0,0,1,0,0 |] ;

constraint forall(job in 1..12)(forall(w1,w2 in 1..6 where bad_pair[w1,w2] == 1)(Assign[w1,job] + Assign[w2,job] < 2)) ;