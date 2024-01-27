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

for i = 0:100
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

x1 = moment_f1(:, 1);
y1 = moment_f1(:, 2);
z1 = moment_f1(:, 3);

x2 = moment_f2(:, 1);
y2 = moment_f2(:, 2);
z2 = moment_f2(:, 3);

x3 = moment_f3(:, 1);
y3 = moment_f3(:, 2);
z3 = moment_f3(:, 3);

data = [x1, y1, z1];
data2 = [x2, y2, z2];

data_test = cat(1, data, data2)

x_test = data_test(:, 1);
y_test = data_test(:, 2);
z_test = data_test(:, 3);

size(data_test)


% 3次元プロット
figure;  % 新しい図を開始
plot3(x1, y1, z1, 'o-');  % 'o-' は点をプロットし、それらを線で結ぶことを意味します

hold on;

plot3(x2, y2, z2, 'o-');
plot3(x3, y3, z3, 'o-');

grid on;  % グリッドを表示
xlabel('X');  % x軸のラベル
ylabel('Y');  % y軸のラベル
zlabel('Z');  % z軸のラベル

xlim([-50, 50])
ylim([-50, 50])
zlim([-3, 3])
title('3D Plot of XYZ Data');  % タイトル

hold off;