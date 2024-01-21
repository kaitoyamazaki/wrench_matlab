% 四角形の頂点の定義

x_point1 = 5
x_point2 = 20

y_point1 = 30
y_point2 = 40
x = [-x_point1, -x_point2, -x_point2, x_point2, x_point2, x_point1, x_point1, x_point2, x_point2, -x_point2, -x_point2, -x_point1];
y = [y_point1, y_point1, y_point2, y_point2, y_point1, y_point1, -y_point1, -y_point1, -y_point2, -y_point2, -y_point1, -y_point1];

% 四角形の内部を塗りつぶす
figure;
object = fill(x, y, 'b'); % 'b'は青色を指定しています。任意の色に変更可能
hold on; % 現在の図にプロットを維持

% 円のパラメータ設定
theta = linspace(0, 2*pi, 100); % 円周上の100点を生成
radius1 = 5; % 最初の円の半径
radius2 = 5; % 2番目の円の半径

% 最初の円の中心座標
center_x1 = 10;
center_y1 = 25;

% 2番目の円の中心座標
center_x2 = -15;
center_y2 = 25;

% 円を描画
x_circle1 = radius1 * cos(theta) + center_x1;
y_circle1 = radius1 * sin(theta) + center_y1;
q1 = fill(x_circle1, y_circle1, 'g'); % 赤色で円の内部を塗りつぶす

x_circle2 = radius2 * cos(theta) + center_x2;
y_circle2 = radius2 * sin(theta) + center_y2;
q2 = fill(x_circle2, y_circle2, 'g'); % 緑色で円の内部を塗りつぶす

% 重心とする円のパラメータ
gravity_circle = 1;
x_g_circle = gravity_circle * cos(theta);
y_g_circle = gravity_circle * sin(theta);
g = fill(x_g_circle, y_g_circle, 'k');

% 接触点のパラメータ
cp1 = 1;
cp2 = 1;
cp3 = 1;

x_cp1 = 10
y_cp1 = 30

x_cp2 = 5
y_cp2 = 25

x_cp3 = -15
y_cp3 = 30

% 接触点を描画
x_cp1_circle1 = cp1 * cos(theta) + x_cp1;
y_cp1_circle1 = cp1 * sin(theta) + y_cp1;
contact_1 = fill(x_cp1_circle1, y_cp1_circle1, 'r'); % 赤色で円の内部を塗りつぶす

% 接触点を描画
x_cp2_circle2 = cp2 * cos(theta) + x_cp2;
y_cp2_circle2 = cp2 * sin(theta) + y_cp2;
contact_2 = fill(x_cp2_circle2, y_cp2_circle2, 'r'); % 赤色で円の内部を塗りつぶす

% 接触点を描画
x_cp3_circle3 = cp3 * cos(theta) + x_cp3;
y_cp3_circle3 = cp3 * sin(theta) + y_cp3;
contact_3 = fill(x_cp3_circle3, y_cp3_circle3, 'r'); % 赤色で円の内部を塗りつぶす

% 四角形と円1の重なりをチェック
[xi1, yi1] = polyxpoly(x, y, x_circle1, y_circle1);
if ~isempty(xi1)
    disp('四角形と円1は重なっています。');
    plot(xi1, yi1, 'r*'); % 交差点をプロット
else
    disp('四角形と円1は重なっていません。');
end

% 四角形と円2の重なりをチェック
[xi2, yi2] = polyxpoly(x, y, x_circle2, y_circle2);
if ~isempty(xi2)
    disp('四角形と円2は重なっています。');
    plot(xi2, yi2, 'r*'); % 交差点をプロット
else
    disp('四角形と円2は重なっていません。');
end


% 軸の設定
axis([-50 50 -50 50]); % x軸とy軸の範囲を-5から5に設定
axis equal; % x軸とy軸のスケールを同じにする
grid on; % グリッド線を表示
xlabel('X軸');
ylabel('Y軸');
title('Wrench空間 テスト');

