function [rad]=cldraw(rad,cxy,wth,col,cont,epi);
%-----------------------------------------------------------------
% CLDRAW is to draw a circle
% input:
%   rad - the radius of the circle
%   cxy - the position of center
%   wth - the width of line;
%   col - the color used to drawing
%  cont - the control for the word
%         0 for off; 1 for on
%output:
%   rad - the radius
%-----------------------------------------------------------------

axis equal

% Calculate the trace coordinates
 
x=rad.*cos([0:pi/720:2.*pi])+epi(1);
y=rad.*sin([0:pi/720:2.*pi])+epi(2);

%the position of the circle
x=x+ones(size(x)).*cxy(1); 
y=y+ones(size(y)).*cxy(2);

%draw a circle

line(x,y,'linewidth',wth,'color','k');
fill(x,y,col,'edgecolor','k');
%----------------------end--------------------------------




