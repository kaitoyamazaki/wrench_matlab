clear;

addpath('../0229', '-end');

% 力の成分
f1 = [0 1 0];
f2 = [-1 0 0];
f3 = [0 1 0];

% 位置ベクトル
l1 = [0.0075 0.03 0];
l2 = [0.005 0.0275 0];
l3 = [-0.0125 0.03 0];

moment_f1 = [];
moment_f2 = [];
moment_f3 = [];

for i = 0:0.005:1
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

m1 = moment_f1;
m2 = moment_f2;
m3 = moment_f3;


point1 = [];
point2 = [];
point3 = [];

hold on;

for i = 1:length(m1)
    % m1とm3の点間の距離を計算
    d = norm(m1(i,:) - m2(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m1(i,:) + k*m2(i,:);
            point1 = [point1; newPoint];
        end
    end
end

point1_x = reshape(point1(:, 1), [], 5);
point1_y = reshape(point1(:, 2), [], 5);
point1_z = reshape(point1(:, 3), [], 5);

s1 = surf(point1_x, point1_y, point1_z, 'FaceColor', 'b', 'EdgeColor', 'none','FaceAlpha', 0.25);

for i = 1:length(m2)
    % m1とm3の点間の距離を計算
    d = norm(m2(i,:) - m3(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m2(i,:) + k*m3(i,:);
            point2 = [point2; newPoint];
        end
    end
end

point2_x = reshape(point2(:, 1), [], 5);
point2_y = reshape(point2(:, 2), [], 5);
point2_z = reshape(point2(:, 3), [], 5);

s2 = surf(point2_x, point2_y, point2_z, 'FaceColor', 'b', 'EdgeColor', 'none','FaceAlpha', 0.25);

for i = 1:length(m3)
    % m1とm3の点間の距離を計算
    d = norm(m3(i,:) - m1(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m3(i,:) + k*m1(i,:);
            point3 = [point3; newPoint];
        end
    end
end

point3_x = reshape(point3(:, 1), [], 5);
point3_y = reshape(point3(:, 2), [], 5);
point3_z = reshape(point3(:, 3), [], 5);

s3 = surf(point3_x, point3_y, point3_z, 'FaceColor', 'b', 'EdgeColor', 'none','FaceAlpha', 0.25);

vertex = [];

vertex = [vertex; moment_f1(1, :)];
vertex = [vertex; moment_f1(end, :)];
plot3(vertex(:, 1), vertex(:, 2), vertex(:, 3), 'k', 'LineWidth', 3);

vertex = [];
vertex = [vertex; moment_f2(1, :)];
vertex = [vertex; moment_f2(end, :)];
plot3(vertex(:, 1), vertex(:, 2), vertex(:, 3), 'k', 'LineWidth', 3);

vertex = [];
vertex = [vertex; moment_f3(1, :)];
vertex = [vertex; moment_f3(end, :)];
plot3(vertex(:, 1), vertex(:, 2), vertex(:, 3), 'k', 'LineWidth', 3);

xlim([-1 1]);
ylim([-1 1]);
zlim([-0.03 0.03]);

% X軸
line([min(get(gca, 'XLim')) max(get(gca, 'XLim'))], [0 0], [0 0], 'Color', 'red', 'LineWidth', 2);

% Y軸
line([0 0], [min(get(gca, 'YLim')) max(get(gca, 'YLim'))], [0 0], 'Color', 'green', 'LineWidth', 2);

% Z軸
line([0 0], [0 0], [min(get(gca, 'ZLim')) max(get(gca, 'ZLim'))], 'Color', 'blue', 'LineWidth', 2);

view(45, 45);