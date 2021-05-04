function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
%{
d1 = zeros(size(P1(:,1)));
d2 = zeros(size(P1(:,1)));

%line in P2
x1 = P2(1,1); y1 = P2(1,2);
x2 = P2(2,1); y2 = P2(2,2);

for j = 1:length(P1(:,1))
    x = P1(j,1);
    y = P1(j,2);
    d1(j) = (x-x1) * (y2-y1) - (y-y1) * (x2-x1);
end

%line in P1
x1 = P1(1,1); y1 = P1(1,2);
x2 = P1(2,1); y2 = P1(2,2);

for j = 1:length(P1(:,1))
    x = P2(j,1);
    y = P2(j,2);
    d2(j) = (x-x1) * (y2-y1) - (y-y1) * (x2-x1);
end

if(((d1(3)<0)&&(d2(2)>0)&&(d2(3)>0)&&(d2(2)>0) || (d1(3)>0)&&(d2(1)<0)&&(d2(2)<0)&&(d2(3)<0)) )
    flag = false;
else
    if(((d1(3)>0)&&(d2(2)>0)&&(d2(3)>0)&&(d2(2)>0) || (d1(3)<0)&&(d2(1)<0)&&(d2(2)<0)&&(d2(3)<0)))
        if((sum(P1(3,1)>P2(:,1))==3 || sum(P1(3,1)<P2(:,1))==3) || (sum(P1(3,2)>P2(:,2))==3 || sum(P1(3,2)<P2(:,2))==3))
            flag = false;
        end
    else
        flag = true;
    end
%}

%[xi,yi] = polyxpoly(P1(:,1),P1(:,2),P2(:,1),P2(:,2),'unique');



flag = false;
for i = 1:3
    %check every line with respect to point
    d1 = inside(P1(i,1),P1(i,2),P2(1,1),P2(1,2),P2(2,1),P2(2,2));
    d2 = inside(P1(i,1),P1(i,2),P2(2,1),P2(2,2),P2(3,1),P2(3,2));
    d3 = inside(P1(i,1),P1(i,2),P2(3,1),P2(3,2),P2(1,1),P2(1,2));
    % if all left then it is intersects or overlap
    if(d1<= 0 && d2<=0 && d3<=0)
        flag = true;
    end
end

for i = 1:3
    d1 = inside(P2(i,1),P2(i,2),P1(1,1),P1(1,2),P1(2,1),P1(2,2));
    d2 = inside(P2(i,1),P2(i,2),P1(2,1),P1(2,2),P1(3,1),P1(3,2));
    d3 = inside(P2(i,1),P2(i,2),P1(3,1),P1(3,2),P1(1,1),P1(1,2));
    % if 1st check large triangle then it will correct in 2nd trinagle
    % checking
    if(d1<= 0 && d2<=0 && d3<=0)
        flag = true;
    end
end

    
% *******************************************************************
end
function d = inside(x,y,x1,y1,x2,y2)
d = (x-x1) * (y2-y1) - (y-y1) * (x2-x1);
end