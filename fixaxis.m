function [tbpxy]=fixaxis(rad,tbpvec,lu,es,epi);
%FIXAXIS is to calculate for the coordinates of three 
%        stress axes in the projected area;
%
% Input: 
%      rad - the radius of the projection circle
%   tbpvec - the matrix consisted of three columns corr-
%            sponding to the T B and P axis, respectively;
%      lu - the control of the lower or upper semisphere
%           projection. lu=1 for upper semisphere; lu=-1
%           for the lower semisphere;
%      es - the control of the equal erea or sterographical
%           projection. es=1 for equal erea;es=-1 for strero-
%           graphical projection.
%Output:
%    tbpxy - the x-y coordinates of three axes after 
%            projection
%------------------------------------------------------------- 

tbpword=['T' 'B' 'P'];
for kaxis=1:3 
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
    cldraw(0.05*rad,[tbpxy(kaxis,1) tbpxy(kaxis,2)].*rad,0.7,[0.9 0.9 0.9],0,epi);
    if kaxis==3
       line([(tbpxy(kaxis,1)-0.02).*rad+epi(1) (tbpxy(kaxis,1)+0.02).*rad+epi(1)],...
            [(tbpxy(kaxis,2)).*rad+epi(2) (tbpxy(kaxis,2)).*rad+epi(2)],...
             'color','k','linewidth',1.5);
       line([(tbpxy(kaxis,1)).*rad+epi(1) (tbpxy(kaxis,1)).*rad+epi(1)],...
            [(tbpxy(kaxis,2)-0.02).*rad+epi(2) (tbpxy(kaxis,2)+0.02).*rad+epi(2)],...
             'color','k','linewidth',1.5);
    elseif kaxis==1
       cldraw(0.015*rad,[tbpxy(kaxis,1) tbpxy(kaxis,2)].*rad,0.7,[0.19 0.19 0.19],0,epi); 
    end
    text(tbpxy(kaxis,1).*rad+0.05+epi(1),tbpxy(kaxis,2).*rad+0.05+epi(2),tbpword(kaxis),...
        'fontsize',15,'color','k');
end
 
