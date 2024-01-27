% 力の成分
f1 = [0 1 0];
f2 = [-1 0 0];
f3 = [0 1 0];

% 位置ベクトル
l1 = [0.01 0.025 0];
l2 = [0.005 0.025 0];
l3 = [-0.015 0.03 0];

% モーメントの値を格納する箇所
moment_f1 = [];
moment_f2 = [];
moment_f3 = [];

for i = 0:99
    edit_f1 = i * f1;
    edit_f2 = i * f2;
    edit_f3 = i * f3;

    now_moment1 = cross(l1, edit_f1);
    now_moment2 = cross(l2, edit_f2);
    now_moment3 = cross(l3, edit_f3);

    wrench_f1 = [edit_f1(1) edit_f1(2) now_moment1(3)];
    wrench_f2 = [edit_f2(1) edit_f2(2) now_moment2(3)];
    wrench_f3 = [edit_f3(1) edit_f3(2) now_moment3(3)];

    moment_f1 = [moment_f1; wrench_f1];
    moment_f2 = [moment_f2; wrench_f2];
    moment_f3 = [moment_f3; wrench_f3];

end

x1 = moment_f1(:,1);

x1_mat = reshape(x1, [],5);

y1 = moment_f1(:,2);
y1_mat = reshape(y1, [],5);

z1 = moment_f1(:,3);
z1_mat = reshape(z1, [],5);

surf(x1_mat, y1_mat, z1_mat);

hold on;

x2 = moment_f2(:,1);

x2_mat = reshape(x2, [],5);

y2 = moment_f2(:,2);
y2_mat = reshape(y2, [],5);

z2 = moment_f2(:,3);
z2_mat = reshape(z2, [],5);

surf(x2_mat, y2_mat, z2_mat);

x3 = moment_f3(:,1);

x3_mat = reshape(x3, [],5);

y3 = moment_f3(:,3);
y3_mat = reshape(y3, [],5);

z3 = moment_f3(:,3);
z3_mat = reshape(z3, [],5);

surf(x3_mat, y3_mat, z3_mat);

hold off;