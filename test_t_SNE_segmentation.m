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
idx = randi(size(p,1), 5000, 1);
X = p(idx, 1:6);

% t-SNE parameters
no_dims = 2;
initial_dims = 6;
perplexity = 30;

mappedX = tsne(X, [], no_dims, initial_dims, perplexity);
figure, scatter(mappedX(:,1), mappedX(:,2))


% Perform DBSCAN on the mapped points
k = 10;
Eps = 5.0;
class = fdbscan(mappedX, k, Eps);
Ncl = max(class);
figure;clf;hold on;
for ct = 1:Ncl
    plot(mappedX(class==ct,1),mappedX(class==ct,2),'.');
end
plot(mappedX(class==0,1),mappedX(class==0,2),'k.');
axis equal;
hold off;


% in 3D
figure;clf;hold on;
for ct = 1:Ncl
    plot3(X(class==ct,1),X(class==ct,2),X(class==ct,3),'.');
end
plot3(X(class==0,1),X(class==0,2),X(class==0,3),'k.');
hold off;
