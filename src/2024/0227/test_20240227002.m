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

point = [];

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

for i = 1:length(m1)
    % m1とm3の点間の距離を計算
    d = norm(m1(i,:) - m2(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m1(i,:) + k*m2(i,:);
            point = [point; newPoint];
        end
    end
end

for i = 1:length(m1)
    % m1とm3の点間の距離を計算
    d = norm(m1(i,:) - m3(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m1(i,:) + k*m3(i,:);
            point = [point; newPoint];
        end
    end
end

for i = 1:length(m2)
    % m1とm3の点間の距離を計算
    d = norm(m2(i,:) - m3(i,:));
    if d >= 0 % 点間の距離が1未満の場合に点を生成
        % 線分上の点を均等に生成
        t = linspace(0, 1, 100); % ここで生成する点の数を調整
        for k = t
            newPoint = (1-k)*m2(i,:) + k*m3(i,:);
            point = [point; newPoint];
        end
    end
end

plot3(point(:,1), point(:,2), point(:,3), '.');
%shp = alphaShape(point(:,1), point(:, 2), point(:, 3), 0.2);
%plot(shp)