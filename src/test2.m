% データの定義
l1 = [0 0 0; 0 1 0.01; 0 2 0.02; 0 3 0.03; 0 4 0.04; 0 5 0.05];
l2 = [0 0 0; -1 0 0.025; -2 0 0.05; -3 0 0.075; -4 0 0.1; -5 0 0.125];
l3 = [0 0 0; 0 1 -0.015; 0 2 -0.03; 0 3 -0.045; 0 4 -0.06; 0 5 -0.075];

% 方向ベクトルを計算
v1 = l1(2,:) - l1(1,:);
v2 = l2(2,:) - l2(1,:);
v3 = l3(2,:) - l3(1,:);

% 各平面の法線ベクトルを計算
normal1 = cross(v1, v2);
normal2 = cross(v1, v3);
normal3 = cross(v2, v3);

% 各平面の方程式のD成分を計算
D1 = -dot(normal1, l1(1,:));
D2 = -dot(normal2, l1(1,:));
D3 = -dot(normal3, l2(1,:));

% 3Dプロット
figure;
[x, y] = meshgrid(-5:0.5:5, -5:0.5:5); % プロットする範囲を定義

% l1とl2の平面
z1 = (-normal1(1)*x - normal1(2)*y - D1) / normal1(3);
surf(x, y, z1, 'FaceAlpha', 0.5, 'FaceColor', 'r');

hold on;

% l1とl3の平面
z2 = (-normal2(1)*x - normal2(2)*y - D2) / normal2(3);
surf(x, y, z2, 'FaceAlpha', 0.5, 'FaceColor', 'g');

% l2とl3の平面
z3 = (-normal3(1)*x - normal3(2)*y - D3) / normal3(3);
surf(x, y, z3, 'FaceAlpha', 0.5, 'FaceColor', 'b');

% 各直線をプロット
plot3(l1(:,1), l1(:,2), l1(:,3), 'k', 'LineWidth', 2); % l1を黒線でプロット
plot3(l2(:,1), l2(:,2), l2(:,3), 'k', 'LineWidth', 2); % l2を黒線でプロット
plot3(l3(:,1), l3(:,2), l3(:,3), 'k', 'LineWidth', 2); % l3を黒線でプロット

xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;

%% l1とl2の平面を少し上にずらす
%z1 = (-normal1(1)*x - normal1(2)*y - D1) / normal1(3) + 0.01; % 少し上にずらす

%% l1とl3の平面をそのまま
%z2 = (-normal2(1)*x - normal2(2)*y - D2) / normal2(3);

%% l2とl3の平面を少し下にずらす
%z3 = (-normal3(1)*x - normal3(2)*y - D3) / normal3(3) - 0.01; % 少し下にずらす

%% ...