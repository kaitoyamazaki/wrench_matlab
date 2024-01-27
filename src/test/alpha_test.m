[x1, y1, z1] = sphere(24);
x1 = x1(:);
y1 = y1(:);
z1 = z1(:);
x2 = x1+5;
P = [x1 y1 z1; x2 y1 z1];
P = unique(P,'rows');
P(:,3) = 0;

test_cloud = pointCloud(P);

pcshow(test_cloud);

%plot3(P(:,1), P(:,2), P(:,3), '.');

%shp = alphaShape(P);
%plot(shp)