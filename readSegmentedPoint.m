function p = readSegmentedPoint(fileName)
% read a segmented point-set from a file
% INPUT:
%   fileName: name of the file containing the point-set
% OUTPUT:
%   p: N * 4 matrix containing the point-set and the index to the segment
%      the point belong


fid = fopen(fileName,'r');

% read the first line, the number of points
dim = fscanf(fid, '%d', 1);

% read the points in a vector 
% p(1, i) is x coord of point i
% p(2, i) is y coord of point i
% p(3, i) is z coord of point i
% p(4, i) is the index of the continuous segment
p = fscanf(fid, '%f %f %f %f\n', [4 dim]);

p = p';

fclose(fid); 

end
