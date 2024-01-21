% 四角形の頂点の定義
x_square = [-x_point1, -x_point2, -x_point2, x_point2, x_point2, x_point1, x_point1, x_point2, x_point2, -x_point2, -x_point2, -x_point1];
y_square = [y_point1, y_point1, y_point2, y_point2, y_point1, y_point1, -y_point1, -y_point1, -y_point2, -y_point2, -y_point1, -y_point1];

% 円のパラメータ設定と描画
theta = linspace(0, 2*pi, 100);
circles = [15, 10, 5; -15, 10, 5]';  % 各円の中心座標と半径

% 四角形と円の衝突・接触判定
for i = 1:size(circles, 2)
    x_circle = circles(1, i) + circles(3, i) * cos(theta);
    y_circle = circles(2, i) + circles(3, i) * sin(theta);
    fill(x_circle, y_circle, 'g'); % 円を描画

    % 衝突・接触判定
    [col, tou] = checkCollisionAndTouching(x_square, y_square, circles(1, i), circles(2, i), circles(3, i));
    fprintf('円 %d は四角形と%s。\n', i, col && ~tou && "衝突しています" || tou && "接しています" || "どちらでもありません");
end

% 四角形の描画
fill(x_square, y_square, 'b');

% 軸の設定
axis([-50 50 -50 50]);
axis equal;
grid on;
xlabel('X軸');
ylabel('Y軸');
title('Wrench空間 テスト');

function dist = pointToLineDistance(point, line_start, line_end)
    % 点と線分との最短距離を計算する関数
    line_vec = line_end - line_start;
    point_vec = point - line_start;
    line_len2 = sum(line_vec.^2);
    t = max(0, min(1, dot(point_vec, line_vec) / line_len2));
    projection = line_start + t * line_vec;
    dist = norm(point - projection);
end

function [collision, touching] = checkCollisionAndTouching(x_square, y_square, x_circle, y_circle, radius)
    % 初期化
    collision = false;
    touching = false;
    
    % 四角形の各辺に対して処理
    for i = 1:length(x_square)-1
        line_start = [x_square(i), y_square(i)];
        line_end = [x_square(i+1), y_square(i+1)];
        dist = pointToLineDistance([x_circle, y_circle], line_start, line_end);
        
        % 衝突判定
        if dist < radius
            collision = true;
        % 接触判定
        elseif abs(dist - radius) < 1e-10
            touching = true;
        end
    end
    
    % 四角形の頂点が円内にあるかチェック
    if any(pdist2([x_circle, y_circle], [x_square; y_square]') < radius)
        collision = true;
    end
    
    % 円の中心が四角形内にあるかチェック
    if inpolygon(x_circle, y_circle, x_square, y_square)
        collision = true;
    end
end