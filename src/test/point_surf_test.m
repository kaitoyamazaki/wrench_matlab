
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

for i = 0:10:999
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

point = [];

% m1とm2に囲まれた領域に点を生成する
for i = 1:length(m1)
    for j = 1:length(m2)
        % m1とm3の点間の距離を計算
        d = norm(m1(i,:) - m2(j,:));
        if d >= 0 % 点間の距離が1未満の場合に点を生成
            % 線分上の点を均等に生成
            t = linspace(0, 1, 3); % ここで生成する点の数を調整
            for k = t
                newPoint = (1-k)*m1(i,:) + k*m2(j,:);
                point = [point; newPoint];
            end
        end
    end
end

point_x = point(:,1);
point_y = point(:,2);
point_z = point(:,3);

point_x_mat = reshape(point_x, [], 5);
point_y_mat = reshape(point_y, [], 5);
point_z_mat = reshape(point_z, [], 5);

s1 = surf(point_x_mat, point_y_mat, point_z_mat, 'FaceAlpha', 0.25);
s1.FaceColor = 'r';
s1.EdgeColor = 'r';

hold on;

point = [];

% m1とm3に囲まれた領域に点を生成する
for i = 1:length(m1)
    for j = 1:length(m3)
        % m1とm3の点間の距離を計算
        d = norm(m1(i,:) - m3(j,:));
        if d >= 0 % 点間の距離が1未満の場合に点を生成
            % 線分上の点を均等に生成
            t = linspace(0, 1, 3); % ここで生成する点の数を調整
            for k = t
                newPoint = (1-k)*m1(i,:) + k*m3(j,:);
                point = [point; newPoint];
            end
        end
    end
end

point_x = point(:,1);
point_y = point(:,2);
point_z = point(:,3);

point_x_mat = reshape(point_x, [], 5);
point_y_mat = reshape(point_y, [], 5);
point_z_mat = reshape(point_z, [], 5);

s2 = surf(point_x_mat, point_y_mat, point_z_mat, 'FaceAlpha', 0.25);
s2.FaceColor = 'g';
s2.EdgeColor = 'g';
point = [];

% m2とm3に囲まれた領域に点を生成する
for i = 1:length(m2)
    for j = 1:length(m3)
        % m1とm3の点間の距離を計算
        d = norm(m2(i,:) - m3(j,:));
        if d >= 0 % 点間の距離が1未満の場合に点を生成
            % 線分上の点を均等に生成
            t = linspace(0, 1, 3); % ここで生成する点の数を調整
            for k = t
                newPoint = (1-k)*m2(i,:) + k*m3(j,:);
                point = [point; newPoint];
            end
        end
    end
end

point_x = point(:,1);
point_y = point(:,2);
point_z = point(:,3);

point_x_mat = reshape(point_x, [], 5);
point_y_mat = reshape(point_y, [], 5);
point_z_mat = reshape(point_z, [], 5);

s3 = surf(point_x_mat, point_y_mat, point_z_mat, 'FaceAlpha', 0.25);
s3.FaceColor = 'b';
s3.EdgeColor = 'b';


xlim([-1000 1000]);
ylim([-1000 1000]);
zlim([-10 10]);


hold off;