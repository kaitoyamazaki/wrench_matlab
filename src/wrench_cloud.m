clear;

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

for i = 0:1:100
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
m2 = moment_f3;

pointCloud = [];

% 2つの直線間の領域に点を生成
for i = 1:length(m1)
    for j = 1:length(m2)
        % m1とm2の点間の距離を計算
        d = norm(m1(i,:) - m2(j,:));
        if d >= 0 % 点間の距離が1未満の場合に点を生成
            % 線分上の点を均等に生成
            t = linspace(0, 1, 10); % ここで生成する点の数を調整
            for k = t
                newPoint = (1-k)*m1(i,:) + k*m2(j,:);
                pointCloud = [pointCloud; newPoint];
            end
        end
    end
end

% 点群データをプロット
plot3(pointCloud(:,1), pointCloud(:,2), pointCloud(:,3), ".");
%shp = alphaShape(pointCloud(:,1), pointCloud(:,2), pointCloud(:,3), 0.000001)
%plot(shp)

% グラフの設定
xlabel('x');
ylabel('y');
zlabel('z');
title('Generated Point Cloud');
grid on;
axis equal;