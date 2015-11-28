function L = L_mat(K, P)
Z = zeros(3,3);
L = [K, P; 
     P' Z];
return;