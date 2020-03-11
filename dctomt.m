function [mom]=dctomt(faultp);
%---------------------------------------------------
%function [mom]=dctomt(faultp);
%DCTOMT is to calculate for the moment tensor from 
%          the fault parameter
%
% Input:
%  faultp - one set of the fault parameters like
%           [strike dip rake];
%Output:
%   mom - the moment tensor coorresponding to the 
%         input parameter like [Mxx Mxy Mxz; Myx
%         Myy Myz;Mzx Mzy Mzz];
%
%-------------------------------------------------------------
 
%Transform from degree to radius
 rfault=faultp.*pi./180;
 
%Prepare for the calculation of the moment tensor corresponding
%the fault parameters
 u(1)= cos(rfault(3)).*cos(rfault(1))...
      +cos(rfault(2)).*sin(rfault(3)).*sin(rfault(1));
 u(2)= cos(rfault(3)).*sin(rfault(1))...
      -cos(rfault(2)).*sin(rfault(3)).*cos(rfault(1));
 u(3)=-sin(rfault(3)).*sin(rfault(2));
 v(1)=-sin(rfault(2)).*sin(rfault(1));
 v(2)= sin(rfault(2)).*cos(rfault(1));
 v(3)=-cos(rfault(2));

%Calculate the moment tensor on the basis of the above preparation	
 for ki=1:3
     for kj=1:3
        mom(kj,ki)=u(ki).*v(kj)+u(kj).*v(ki);
     end
 end
%==================End=============================================
