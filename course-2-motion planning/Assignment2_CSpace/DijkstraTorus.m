function route = DijkstraTorus (input_map, start_coords, dest_coords)
% Run Dijkstra's algorithm on a grid.
% Inputs : 
%   input_map : a logical array where the freespace cells are false or 0 and
%      the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%       respectively, the first entry is the row and the second the column.
% Output :
%   route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route.

% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

cmap = [1 1 1; ...
        0 0 0; ...
        1 0 0; ...
        0 0 1; ...
        0 1 0; ...
        1 1 0];

colormap(cmap);

%Add these lines of code before

input_map(:, 181) = [];
input_map(181, :) = [];

[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);


map(~input_map) = 1;  % Mark free cells
map(input_map)  = 2;  % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

map(19720)=6;
% Initialize distance array
distances = Inf(nrows,ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows,ncols);

distances(start_node) = 0;

% Main Loop
while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
    %image(1.5, 1.5, map);
    %grid on;
    %axis image;
    %drawnow;
    
    % Find the node with the minimum distance
    [min_dist, current] = min(distances(:));
    
    if ((current == dest_node) || isinf(min_dist))
        break;
    end
    
    % Update map
    map(current) = 3;         % mark current node as visited
    distances(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distances), current);
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
   
    %%% All of your code should be between the two lines of stars. 
    % *******************************************************************
    x = 0;
    y = 0;
    %up
    if(i>1 && i<=nrows)
        x = i-1;
        y = j;
        update(x,y,min_dist+1,current)
    end
    
    %It is a torus so the last cell is become the 1st cell
    if i==1
        x = nrows;
        y = j;
        update (x,y,min_dist+1,current);
    end
    
    %down
    if(i>=1 && i<nrows)
        x = i+1;
        y = j;
        update(x,y,min_dist+1,current)
    end
    
    if i==nrows
        x = 1;
        y = j;
        update (x,y,min_dist+1,current);
    end
    
    %left
    if(j>1 && j<=ncols)
        x = i;
        y = j-1;
        update(x,y,min_dist+1,current)
    end
    
    if j==1
        x = i;
        y = ncols;
        update (x,y,min_dist+1,current);
    end

    %right
    if(j>=1 && j<ncols)
        x = i;
        y = j+1;
        update(x,y,min_dist+1,current)
    end
    
    if j== ncols
        x = i;
        y = 1;
        update (x,y,min_dist+1,current);
    end
   

    % *******************************************************************
end

if (isinf(distances(dest_node)))
    route = [];
else
    route = [dest_node];
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end
end

    function update (i,j,d,p)
        if ( (map(i,j) ~= 2) && (map(i,j) ~= 3) && (map(i,j) ~= 5) && (distances(i,j) > d) )
            distances(i,j) = d;
            map(i,j) = 4;
            parent(i,j) = p;
        end
    end

end