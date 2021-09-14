% Depedency: STAT toolbox for KDTreeSearcher and rangesearch

function [class]=fdbscan(xy,k,Eps)
%class(i) = 0 when point i is an outlier
%           1...65534 when part of a cluster (core or border)

class = zeros(size(xy,1),1,'uint16');
cluster = 1;

tree = KDTreeSearcher(xy);

%first classify every point as undefined (0)
%outliers will be classified as 1
while any(class==0)
    idx = find(class==0,1,'first'); %get an undefined point

    idxs = rangesearch(tree, xy(idx,:), Eps);
    idxs = idxs{1};
    
    if length(idxs)>(k+1) %core point
        cluster = cluster+1;
        class(idx)=cluster;
        idxs(class(idxs)>1)=[]; %no need to redo already allocated points
        class = expandcluster(xy,tree,class,Eps,k,idxs,cluster);
    else %outlier or border point, classify as outlier for now
        class(idx)=1;
    end
end
class = class-1; %(outliers were 1, now 0)
end

function [class] = expandcluster(xy,tree,class,Eps,k,idxs,cluster)
%check all idxs. If enough neighbors are within limits, expand with it.
%else add the borderpoint    
if isempty(idxs),return;end
class(idxs)=cluster; %add the unallocated and outliers to the cluster

for ct = 1:length(idxs) %first one is self
    if class(idxs(ct))>1&&class(idxs(ct))~=cluster %already in another cluster
        continue;
    end
    
    idxs2 = rangesearch(tree, xy(idxs(ct),:), Eps);
    idxs2 = idxs2{1};
    
    if length(idxs2)>(k+1) %core point
        idxs2(class(idxs2)>1)=[]; %no need to redo already allocated points (including self)
        class = expandcluster(xy,tree,class,Eps,k,idxs2,cluster);
    else %idxs(ct) is a border point
    end
end
end
