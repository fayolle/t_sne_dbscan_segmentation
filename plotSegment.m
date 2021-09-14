function j=plotSegment(p, threshold)
% plot all segmented point-sets in the point-set p
% INPUT: 
% p: segmented point-set; size n x 4
%   p(1..3): point-set (x,y,z)
%   p(4): label
% 
% N.B.: CALL plotISegment(p,i) that displays the i-th segment of p

clf;

if (nargin > 1)
    THRESHOLD = threshold;
else
    THRESHOLD = 50;
end

for i=1:max(p(:,4))
    idx(:,i) = p(:,4)==i;
    sum_idx(i) = sum(idx(:,i));
end

idx2 = sum_idx > THRESHOLD;
map = jet(sum(idx2));
colormap(map);

j = 1;
for i=1:max(p(:,4))
    if (sum_idx(i) > THRESHOLD)
        hold on;
        plotISegment(p, i, j, map);
        hold off;
        j = j + 1;
    end
end

colorbar;

end
