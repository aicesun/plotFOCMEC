function dcplane(rad,tbpvec,lu,es,colorface,epi);
%-------------------------------------
axis equal
%========================PLANE I====================
%Calculate and determine the plane which lies between the 
%positive P and T axis. Here the sqrt(2)./2 is tho keep
% the norm of the vector(NODONE) equal to that of P and T
nodone=sqrt(2)./2.*(tbpvec(:,1)+tbpvec(:,3));
[trace1]=protrace(nodone,lu,es);
% linem(trace1(:,2).*rad+epi(2),trace1(:,1).*rad+epi(1),'color','k','linewidth',0.5);
%[stdprk1]=faultval(nodone,tbpvec);
%========================Plane II===================
%Calculate and determine the plane which lies between the 
%negative P and positive T axis. Here the sqrt(2)./2 is to
%keep the norm of the vector(NODONE) equal to that of P and T
nodtwo=sqrt(2)./2.*(tbpvec(:,1)-tbpvec(:,3));
[trace2]=protrace(nodtwo,lu,es); 

% linem(trace2(:,2).*rad+epi(2),trace2(:,1).*rad+epi(1),'color','k','linewidth',0.5); 
%[stdprk2]=faultval(nodtwo,tbpvec); 
%stdprk=[stdprk1;stdprk2];

%========fill the Tensor Area with red color=======
%Selecting the start point and end point of trace1 and trace2
a1x=trace1(1,1).*rad;a1y=trace1(1,2).*rad;
a2x=trace1(length(trace1),1).*rad;a2y=trace1(length(trace1),2).*rad;

b1x=trace2(1,1).*rad;b1y=trace2(1,2).*rad;
b2x=trace2(length(trace2),1).*rad;b2y=trace2(length(trace2),2).*rad;
hold on
for kx=1:3
    if lu==-1
       %The lower semisphere 
       if tbpvec(3,kx)<0,tbpvec(:,kx)=-tbpvec(:,kx);end
    elseif lu==1
       %The upper semisphere 
       if tbpvec(3,kx)>0,tbpvec(:,kx)=-tbpvec(:,kx);end
    end

    if es==1   %Equal erea projection
        tbpxy(kx,1)=tbpvec(2,kx).*sqrt...
         (2/((1+abs(tbpvec(3,kx))).^2+tbpvec(1,kx).^2+tbpvec(2,kx).^2));
        tbpxy(kx,2)=tbpvec(1,kx).*sqrt...
         (2/((1+abs(tbpvec(3,kx))).^2+tbpvec(1,kx).^2+tbpvec(2,kx).^2));
    elseif es==-1 % Sterographical projection
        tbpxy(kx,1)=tbpvec(2,kx)./(1+abs(tbpvec(3,kx)));
        tbpxy(kx,2)=tbpvec(1,kx)./(1+abs(tbpvec(3,kx)));
    end
end
%------separating the two traces into four segments by N-axis projection
%point in plate, there are linea1,linea2,lineb1,lineb2
bx=tbpxy(2,1).*rad;
by=tbpxy(2,2).*rad;% the coordinate of N-axis projection

mida=(trace1(:,1).*rad-bx).^2+(trace1(:,2).*rad-by).^2;
i=find(min((trace1(:,1).*rad-bx).^2+(trace1(:,2).*rad-by).^2)==mida);
linea1(:,1)=trace1(1:i,1).*rad+epi(1);
linea1(:,2)=trace1(1:i,2).*rad+epi(2);
linea2(:,1)=trace1(i:length(trace1),1).*rad+epi(1);
linea2(:,2)=trace1(i:length(trace1),2).*rad+epi(2);

midb=(trace2(:,1).*rad-bx).^2+(trace2(:,2).*rad-by).^2;
j=find(min((trace2(:,1).*rad-bx).^2+(trace2(:,2).*rad-by).^2)==midb);
lineb1(:,1)=trace2(1:j,1).*rad+epi(1);
lineb1(:,2)=trace2(1:j,2).*rad+epi(2);
lineb2(:,1)=trace2(j:length(trace2),1).*rad+epi(1);
lineb2(:,2)=trace2(j:length(trace2),2).*rad+epi(2);
%======================================
cxy=[0 0];    
x=rad.*cos([2.*pi:-pi/180:0]);
y=rad.*sin([2.*pi:-pi/180:0]);

%the position of the circle
x=x+ones(size(x)).*cxy(1); 
y=y+ones(size(y)).*cxy(2);
%Calculate the four/two points of intersection between the two traces with
%great circle
cira1=(x-trace1(1,1).*rad).^2+(y-trace1(1,2).*rad).^2;
i1=find(min((x-trace1(1,1).*rad).^2+(y-trace1(1,2).*rad).^2)==cira1);
cira2=(x-trace1(length(trace1),1).*rad).^2+(y-trace1(length(trace1),2).*rad).^2;
i2=find(min((x-trace1(length(trace1),1).*rad).^2+(y-trace1(length(trace1),2).*rad).^2)==cira2);


cirb1=(x-trace2(1,1).*rad).^2+(y-trace2(1,2).*rad).^2;
j1=find(min((x-trace2(1,1).*rad).^2+(y-trace2(1,2).*rad).^2)==cirb1);
cirb2=(x-trace2(length(trace2),1).*rad).^2+(y-trace2(length(trace2),2).*rad).^2;
j2=find(min((x-trace2(length(trace2),1).*rad).^2+(y-trace2(length(trace2),2).*rad).^2)==cirb2);

aaa=[2.*pi:-pi/180:0];
ai1=aaa(i1);% the arc of four points
ai2=aaa(i2);
aj1=aaa(j1);
aj2=aaa(j2);
%-----Calculate the arc around the first T area

if aj2<ai1 & ai1-aj2<pi
    sx1=rad.*cos([aj2:pi/180:ai1])+epi(1);
    sy1=rad.*sin([aj2:pi/180:ai1])+epi(2);
elseif aj2<ai1 & ai1-aj2>pi
    sx1=rad.*cos([aj2+2*pi:-pi/180:ai1])+epi(1);
    sy1=rad.*sin([aj2+2*pi:-pi/180:ai1])+epi(2);
elseif aj2>ai1 & aj2-ai1<pi
    sx1=rad.*cos([aj2:-1*pi/180:ai1])+epi(1);
    sy1=rad.*sin([aj2:-1*pi/180:ai1])+epi(2);
elseif aj2>ai1 & aj2-ai1>pi
    sx1=rad.*cos([aj2:pi/180:ai1+2*pi])+epi(1);
    sy1=rad.*sin([aj2:pi/180:ai1+2*pi])+epi(2);    
end
if aj2==ai2 & abs(abs(aj2-ai1)-pi)<0.001 & aj2>aj1
    sx1=rad.*cos([aj2:-pi/180:ai1])+epi(1);
    sy1=rad.*sin([aj2:-pi/180:ai1])+epi(2);
elseif aj2==ai2 & abs(abs(aj2-ai1)-pi)<0.001 & aj2<aj1
    sx1=rad.*cos([aj2:-pi/180:ai1-2*pi])+epi(1);
    sy1=rad.*sin([aj2:-pi/180:ai1-2*pi])+epi(2);
end    
if aj2==ai1
    fill([linea1(:,1)' lineb2(:,1)' ],[linea1(:,2)' lineb2(:,2)'],colorface,'edgecolor','non');
elseif aj2~=ai1
    fill([sx1 linea1(:,1)' lineb2(:,1)' ],[ sy1 linea1(:,2)' lineb2(:,2)'],colorface,'edgecolor','non');
end
%-----Calculate the arc around the second T area
if ai2<aj1 & aj1-ai2<pi
    sx2=rad.*cos([ai2:pi/180:aj1])+epi(1);
    sy2=rad.*sin([ai2:pi/180:aj1])+epi(2);
elseif ai2<aj1 & aj1-ai2>pi
    sx2=rad.*cos([ai2+2*pi:-pi/180:aj1])+epi(1);
    sy2=rad.*sin([ai2+2*pi:-pi/180:aj1])+epi(2);
elseif ai2>aj1 & ai2-aj1<pi
    sx2=rad.*cos([ai2:-pi/180:aj1])+epi(1);
    sy2=rad.*sin([ai2:-pi/180:aj1])+epi(2);
elseif ai2>ai1 & ai2-aj1>pi
    sx2=rad.*cos([ai2:pi/180:aj1+2*pi])+epi(1);
    sy2=rad.*sin([ai2:pi/180:aj1+2*pi])+epi(2);    
end
if aj2==ai2 & abs(abs(ai2-aj1)-pi)<0.001 & aj2>aj1
        sx2=rad.*cos([ai2:-pi/180:aj1-2*pi])+epi(1);
    sy2=rad.*sin([ai2:-pi/180:aj1-2*pi])+epi(2);
elseif aj2==ai2 & abs(abs(ai2-aj1)-pi)<0.001 & aj2<aj1
    sx2=rad.*cos([ai2:-pi/180:aj1])+epi(1);
    sy2=rad.*sin([ai2:-pi/180:aj1])+epi(2);
end    
if aj2==ai1
    fill([lineb1(:,1)' linea2(:,1)' ],[lineb1(:,2)' linea2(:,2)'],colorface,'edgecolor','non');
elseif aj2~=ai1
    fill([sx2 lineb1(:,1)' linea2(:,1)' ],[ sy2 lineb1(:,2)' linea2(:,2)'],colorface,'edgecolor','non');
end
%-------------------------------
hold on
fixaxis(rad,tbpvec,lu,es,epi);
