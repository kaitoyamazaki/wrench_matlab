% 媒介変数を利用した平面の方程式の導出・利用検証
clear;

addpath('.', '-end');



% 力の成分
f1 = [0 1 0];
f2 = [-1 0 0];
f3 = [0 1 0];

% 位置ベクトル
l1 = [0.0075 0.03 0];
l2 = [0.005 0.0275 0];
l3 = [-0.0125 0.03 0];

m1 = [];
m2 = [];
m3 = [];

for i = 0:1
    edit_f1 = i * f1;
    edit_f2 = i * f2;
    edit_f3 = i * f3;

    now_moment1 = cross(l1, edit_f1);
    now_moment2 = cross(l2, edit_f2);
    now_moment3 = cross(l3, edit_f3);

    wrench_f1 = [edit_f1(1) edit_f1(2) now_moment1(3)];
    wrench_f2 = [edit_f2(1) edit_f2(2) now_moment2(3)];
    wrench_f3 = [edit_f3(1) edit_f3(2) now_moment3(3)];

    m1 = [m1; wrench_f1];
    m2 = [m2; wrench_f2];
    m3 = [m3; wrench_f3];
end

moment_point1 = m1(end, :);
moment_point2 = m2(end, :);
moment_point3 = m3(end, :);

plane1_coefficient = cross(moment_point1, moment_point2);
plane2_coefficient = cross(moment_point2, moment_point3);
plane3_coefficient = cross(moment_point3, moment_point1);


expected_number_of_rows = 100000;

points = zeros(expected_number_of_rows, 3);
count = 1;

for lamda = 0:0.01:1
    for mu = 0:0.01:1

        point = lamda * moment_point1 + mu * moment_point2;

        if abs(plane1_coefficient(1) * point(1) + plane1_coefficient(2) * point(2) + plane1_coefficient(3) * point(3)) < 1e-10
            points(count, :) = point;
            count = count + 1;
        end
    end
end

points = points(1:count-1, :);

shp = alphaShape(points(:,1), points(:,2), points(:,3));
% プロット初期化
figure;

plot(shp);
title('Convex Hull of the points on the plane');

hold on;

quiver3(0, 0, 0, moment_point1(1), moment_point1(2), moment_point1(3), 'r');
quiver3(0, 0, 0, moment_point2(1), moment_point2(2), moment_point2(3), 'r');
hold off;

% 軸ラベル
xlabel('x');
ylabel('y');
zlabel('z');

% 表示範囲の設定
axis equal;
xlim([-1, 1]);
ylim([-1, 1]);
zlim([-0.03, 0.03]);

% グリッド表示
grid on;

%title('Random points on the plane');

%quiver3(0, 0, 0, moment_point1(1), moment_point1(2), moment_point1(3), 'r');
%quiver3(0, 0, 0, moment_point2(1), moment_point2(2), moment_point2(3), 'r');

%% 軸ラベル
%xlabel('x');
%ylabel('y');
%zlabel('z');

%% 表示範囲の設定
%axis equal;
%xlim([-1, 1]);
%ylim([-1, 1]);
%zlim([-0.03, 0.03]);

%plot3(plane1(:,1), plane1(:,2), plane1(:,3), '.', 'Color', 'b');

%% グリッド表示
%grid on;
%hold off;