function [tracep]=protrace(nodone,lu,es);
%-------------------------------------------------------------
%PROTRACE is to calculate for the parameters of the trace which
%            are projected on the horizental area;
%
% Input:
%  nodone - the vector which control one of the nodes, which, 
%           actually, is the interline of the T-P plane and 
%            that nodal;
%      lu - the control of the lower or upper semisphere
%           projection. lu=1 for upper semisphere; lu=-1
%           for the lower semisphere;
%      es - the control of the equal erea or sterographical
%           projection. es=1 for equal erea;es=-1 for strero-
%           graphical projection.
%Output:
%  tracep - the trace parameters of one nodal dtermined by the
%           input vector
%------------------------------------------------------------- 
%Determine a vector(V) which lies both in the nodal and in the
%x-y plane,which, in fact,the crossline of the surface and
% the plane
v(1)=-nodone(2)./sqrt(nodone(1).^2+nodone(2).^2);
v(2)= nodone(1)./sqrt(nodone(1).^2+nodone(2).^2);
v(3)=0;

%Determine a vector(U) which is vertical to the plane
%controlled by the vector(NODONE) and the vector(V)
u(1)=-v(2).*nodone(3);
u(2)= v(1).*nodone(3);
u(3)=nodone(1).*v(2)-nodone(2).*v(1);

%------------------------------------
if lu==-1
   %For the lower semisphere projection
   if u(3)<0,u=-u;end
elseif lu==1
   %For the upper semisphere projection
   if u(3)>0,u=-u;end
end
 
 
%Divide a 180 degree into 180 segments
stepdeg=[0:pi./360:pi];
cstep=cos(stepdeg);
sstep=sin(stepdeg);
	 
%Calculate the coordinates of each point on the outside
% of the plane         
for m=1:3
    everyp(m,:)=cstep.*v(m)+sstep.*u(m);
end

if es==1
   %Equal area projection 
   zx=everyp(2,:).*sqrt(2./((1+abs(everyp(3,:))).^2+everyp(1,:).^2+everyp(2,:).^2));
   zy=everyp(1,:).*sqrt(2./((1+abs(everyp(3,:))).^2+everyp(1,:).^2+everyp(2,:).^2));
elseif es==-1
   %Sterographical projection
   zx=everyp(2,:)./(1+abs(everyp(3,:)));
   zy=everyp(1,:)./(1+abs(everyp(3,:)));
end
tracep=[zx' zy'];
%-----------------------end------------------------------------
