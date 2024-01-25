% 修正されたm1データと仮のm2データ
m1 = [0 0 0; 0 1 0.010; 0 2 0.020; 0 3 0.030; 0 4 0.040; 0 5 0.050; 0 6 0.060; 0 7 0.070; 0 8 0.080; 0 9 0.090; 0 10 0.100];
m1 = moment_f1;
m2 = [0 0 0; 0 1 0.020; 0 2 0.040; 0 3 0.060; 0 4 0.080; 0 5 0.100; 0 6 0.120; 0 7 0.140; 0 8 0.160; 0 9 0.180; 0 10 0.200];
m2 = moment_f3;
% 点群データを保存する配列を初期化
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
plot3(pointCloud(:,1), pointCloud(:,2), pointCloud(:,3), 'k.');

% グラフの設定
xlabel('x');
ylabel('y');
zlabel('z');
title('Generated Point Cloud');
grid on;
axis equal;

% 点群データをファイルに保存
save('pointCloudData.mat', 'pointCloud');
