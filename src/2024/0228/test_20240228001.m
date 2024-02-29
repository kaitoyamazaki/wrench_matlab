clear;

% 力の成分
f1 = [0 1 0];
f2 = [-1 0 0];
f3 = [0 1 0];

alpha = 20;
alpha = deg2rad(alpha);
beta = -20;
beta = deg2rad(beta);

Rz1 = [cos(alpha) -sin(alpha) 0;
      sin(alpha) cos(alpha) 0;
      0 0 1];

Rz2 = [cos(beta) -sin(beta) 0;
      sin(beta) cos(beta) 0;
      0 0 1];

f1_1 = Rz1 * f1';
f1_2 = Rz2 * f1';

f2_1 = Rz1 * f2';
f2_2 = Rz2 * f2';

f3_1 = Rz1 * f3';
f3_2 = Rz2 * f3';

% 位置ベクトル
l1 = [0.01 0.025 0];
l2 = [0.005 0.025 0];
l3 = [-0.015 0.03 0];

% モーメントの値を格納する箇所
moment_f1_1 = [];
moment_f1_2 = [];
moment_f2_1 = [];
moment_f2_2 = [];
moment_f3_1 = [];
moment_f3_2 = [];


for i = 0:0.005:1
    edit_f1_1 = i * f1_1;
    edit_f1_2 = i * f1_2;
    edit_f2_1 = i * f2_1;
    edit_f2_2 = i * f2_2;
    edit_f3_1 = i * f3_1;
    edit_f3_2 = i * f3_2;

    now_moment1_1 = cross(l1, edit_f1_1);
    now_moment1_2 = cross(l1, edit_f1_2);
    now_moment2_1 = cross(l2, edit_f2_1);
    now_moment2_2 = cross(l2, edit_f2_2);
    now_moment3_1 = cross(l3, edit_f3_1);
    now_moment3_2 = cross(l3, edit_f3_2);

    wrench_f1_1 = [edit_f1_1(1) edit_f1_1(2) now_moment1_1(3)];
    wrench_f1_2 = [edit_f1_2(1) edit_f1_2(2) now_moment1_2(3)];
    wrench_f2_1 = [edit_f2_1(1) edit_f2_1(2) now_moment2_1(3)];
    wrench_f2_2 = [edit_f2_2(1) edit_f2_2(2) now_moment2_2(3)];
    wrench_f3_1 = [edit_f3_1(1) edit_f3_1(2) now_moment3_1(3)];
    wrench_f3_2 = [edit_f3_2(1) edit_f3_2(2) now_moment3_2(3)];

    moment_f1_1 = [moment_f1_1; wrench_f1_1];
    moment_f1_2 = [moment_f1_2; wrench_f1_2];
    moment_f2_1 = [moment_f2_1; wrench_f2_1];
    moment_f2_2 = [moment_f2_2; wrench_f2_2];
    moment_f3_1 = [moment_f3_1; wrench_f3_1];
    moment_f3_2 = [moment_f3_2; wrench_f3_2];

end

m1_1 = moment_f1_1;
m1_2 = moment_f1_2;
m2_1 = moment_f2_1;
m2_2 = moment_f2_2;
m3_1 = moment_f3_1;
m3_2 = moment_f3_2;


point1 = [];
point2 = [];
point3 = [];

hold on;

for i = 1:length(m1_1)
    % m1とm3の点間の距離を計算
    d = norm(m1_1(i,:) - m1_2(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m1_1(i,:) + k*m1_2(i,:);
            point1 = [point1; newPoint];
        end
    end
end

point1_x = reshape(point1(:, 1), [], 5);
point1_y = reshape(point1(:, 2), [], 5);
point1_z = reshape(point1(:, 3), [], 5);

s1 = surf(point1_x, point1_y, point1_z, 'FaceColor', 'b', 'EdgeColor', 'none','FaceAlpha', 0.25);

for i = 1:length(m2_1)
    % m1とm3の点間の距離を計算
    d = norm(m2_1(i,:) - m2_2(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m2_1(i,:) + k*m2_2(i,:);
            point2 = [point2; newPoint];
        end
    end
end

point2_x = reshape(point2(:, 1), [], 5);
point2_y = reshape(point2(:, 2), [], 5);
point2_z = reshape(point2(:, 3), [], 5);

s2 = surf(point2_x, point2_y, point2_z, 'FaceColor', 'b', 'EdgeColor', 'none','FaceAlpha', 0.25);

for i = 1:length(m3_1)
    % m1とm3の点間の距離を計算
    d = norm(m3_1(i,:) - m3_2(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m3_1(i,:) + k*m3_2(i,:);
            point3 = [point3; newPoint];
        end
    end
end

point3_x = reshape(point3(:, 1), [], 5);
point3_y = reshape(point3(:, 2), [], 5);
point3_z = reshape(point3(:, 3), [], 5);

s3 = surf(point3_x, point3_y, point3_z, 'FaceColor', 'b', 'EdgeColor', 'none','FaceAlpha', 0.25);

point4 = [];
point5 = [];
point6 = [];

for i = 1:length(m1_1)
    % m1とm3の点間の距離を計算
    d = norm(m1_1(i,:) - m2_2(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m1_1(i,:) + k*m2_2(i,:);
            point4 = [point4; newPoint];
        end
    end
end

point4_x = reshape(point4(:, 1), [], 5);
point4_y = reshape(point4(:, 2), [], 5);
point4_z = reshape(point4(:, 3), [], 5);

s1 = surf(point4_x, point4_y, point4_z, 'FaceColor', 'b', 'EdgeColor', 'none','FaceAlpha', 0.25);

for i = 1:length(m2_1)
    % m1とm3の点間の距離を計算
    d = norm(m2_1(i,:) - m3_1(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m2_1(i,:) + k*m3_1(i,:);
            point5 = [point5; newPoint];
        end
    end
end

point5_x = reshape(point5(:, 1), [], 5);
point5_y = reshape(point5(:, 2), [], 5);
point5_z = reshape(point5(:, 3), [], 5);

s2 = surf(point5_x, point5_y, point5_z, 'FaceColor', 'b', 'EdgeColor', 'none','FaceAlpha', 0.25);

for i = 1:length(m3_2)
    % m1とm3の点間の距離を計算
    d = norm(m3_2(i,:) - m1_2(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m3_2(i,:) + k*m1_2(i,:);
            point6 = [point6; newPoint];
        end
    end
end

point6_x = reshape(point6(:, 1), [], 5);
point6_y = reshape(point6(:, 2), [], 5);
point6_z = reshape(point6(:, 3), [], 5);

s3 = surf(point6_x, point6_y, point6_z, 'FaceColor', 'b', 'EdgeColor', 'none','FaceAlpha', 0.25);


vertex = [];
vertex2 = [];

vertex = [vertex; moment_f1_1(1, :)];
vertex = [vertex; moment_f1_1(end, :)];
plot3(vertex(:, 1), vertex(:, 2), vertex(:, 3), 'k', 'LineWidth', 3);

vertex = [];
vertex = [vertex; moment_f1_2(1, :)];
vertex = [vertex; moment_f1_2(end, :)];
plot3(vertex(:, 1), vertex(:, 2), vertex(:, 3), 'k', 'LineWidth', 3);

vertex = [];
vertex = [vertex; moment_f2_1(1, :)];
vertex = [vertex; moment_f2_1(end, :)];
plot3(vertex(:, 1), vertex(:, 2), vertex(:, 3), 'k', 'LineWidth', 3);

vertex = [];
vertex = [vertex; moment_f2_2(1, :)];
vertex = [vertex; moment_f2_2(end, :)];
plot3(vertex(:, 1), vertex(:, 2), vertex(:, 3), 'k', 'LineWidth', 3);

vertex = [];
vertex = [vertex; moment_f3_1(1, :)];
vertex = [vertex; moment_f3_1(end, :)];
plot3(vertex(:, 1), vertex(:, 2), vertex(:, 3), 'k', 'LineWidth', 3);

vertex = [];
vertex = [vertex; moment_f3_2(1, :)];
vertex = [vertex; moment_f3_2(end, :)];
plot3(vertex(:, 1), vertex(:, 2), vertex(:, 3), 'k', 'LineWidth', 3);

vertex2 = [vertex2; moment_f1_2(end, :)];
vertex2 = [vertex2; moment_f1_1(end, :)];
vertex2 = [vertex2; moment_f2_2(end, :)];
vertex2 = [vertex2; moment_f2_1(end, :)];
vertex2 = [vertex2; moment_f3_1(end, :)];
vertex2 = [vertex2; moment_f3_2(end, :)];
vertex2 = [vertex2; moment_f1_2(end, :)];

%plot3(vertex2(:, 1), vertex2(:, 2), vertex2(:, 3), 'k', 'LineWidth', 3);

% X軸
line([min(get(gca, 'XLim')) max(get(gca, 'XLim'))], [0 0], [0 0], 'Color', 'red', 'LineWidth', 2);

% Y軸
line([0 0], [min(get(gca, 'YLim')) max(get(gca, 'YLim'))], [0 0], 'Color', 'green', 'LineWidth', 2);

% Z軸
line([0 0], [0 0], [min(get(gca, 'ZLim')) max(get(gca, 'ZLim'))], 'Color', 'blue', 'LineWidth', 2);

view(-120, -120);