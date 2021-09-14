clear; close all; clc;

rng(20190531);

% read input data
fid = fopen('./test_model.xyz', 'r');
p = fscanf(fid, '%f %f %f %f %f %f', [6 Inf]);
size(p)
fclose(fid);

p = p';
size(p)

% random sub-sampling
idx = randi(size(p,1), 25000, 1);
X = p(idx, 1:3);
%X = p(:, 1:3);


% Perform DBSCAN on the mapped points
k = 10;
Eps = 1.0;
class = fdbscan(X, k, Eps);
Ncl = max(class);
fprintf('Number of clusters: %d\n', Ncl);
figure;clf;hold on;
for ct = 1:Ncl
    plot3(X(class==ct,1),X(class==ct,2),X(class==ct,3),'.');
end
plot3(X(class==0,1),X(class==0,2),X(class==0,3),'k.');
title('DBSCAN on point coordinates only');
axis equal;
hold off;


% DBSCAN with normal
%X = p(idx, 1:3);
normals = p(idx, 4:6);
k = 10;
X_eps = 1.0;
normal_eps = 0.1;
class = fdbscan_with_normals(X, normals, k, X_eps, normal_eps);
Ncl = max(class);
fprintf('Number of clusters: %d\n', Ncl);
figure;clf;hold on;
for ct = 1:Ncl
    plot3(X(class==ct,1),X(class==ct,2),X(class==ct,3),'.');
end
plot3(X(class==0,1),X(class==0,2),X(class==0,3),'k.');
title('DBSCAN using normals to cull neighbors');
axis equal;
hold off;
