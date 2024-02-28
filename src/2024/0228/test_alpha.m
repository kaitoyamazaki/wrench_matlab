clear;

f1 = [0 1 0];

angle_deg = 20;
angle_rad = deg2rad(angle_deg);

Rz = [cos(angle_rad) -sin(angle_rad) 0;
      sin(angle_rad) cos(angle_rad) 0;
      0 0 1];


f1_1 = Rz * f1';

disp(f1_1);