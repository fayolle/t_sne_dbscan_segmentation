function plotISegment(p, i, j, map)
% plot the jth segment from a segmented point-set
% INPUT: 
%   p: segmented point-set; columns 1:3 correspond to point coordinates
%       column 4 corresponds to the label; size is N x 4
%   j: index to the segment to be plotted
%   i: index of the point in p


max_index = max(p(:,4));
if (j > max_index)
  error('This index does not exist');
end

idx = (p(:,4) == i);

% map = jet(max_index);

marker = '.';

plot3(p(idx,1), p(idx,2), p(idx,3), marker, 'color', map(j, :), 'markerfacecolor', map(j, :));

axis equal;

end
