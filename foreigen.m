function [tbpvec,tbpval]=foreigen(mom);
%------------------------------------------------------------
%function [tbpvec,tbpval]=foreigen(mom);
%
%FOREIGEN is to calculate the coordinates of the three axes
%            and the principle moment:M1,M2 and M3
%
%input:
%   mom - the moment mentor in the form of [Mxx Mxy Mxz; Myx
%         Myy Myz;Mzx Mzy Mzz];
%
%output:
%   tbpvec - the coordinates of the three axes in order of
%            T,B and P(the first column(x,y,z)' is for T axis)
%   tbpval - the principle element of the moment tensor   
%-------------------------------------------------

% Calculate the eigenvalue(EIGVAL) and the eigenvector(EIGVEC)
% of the moment tensor
[eigvec,eigval]=eig(mom);

%Extract the eigenvalues which originally are the diagnal ones
 
eigval=diag(eigval);

if length(eigval)~=3,
   disp('Bad moment tensor');
end
%Investigate for which eigenvalue is the maximum, which, because,
%determine the T axis theoretically, which eigenvalue is the 
% minimum, which determine the P axis, and which eigenvalueis the
% middle one, which determine the B axis
ott=1:3;
tval=find(eigval==max(eigval));
pval=find(eigval==min(eigval));

if length(tval)==2,
   temtb=tval;
   disp('Bad moment tensor t=b');
   tval=temtb(1);
   bval=temtb(2);
elseif length(pval)==2;
   tempb=pval;
   disp('Bad moment tensor p=b');
   pval=tempb(1);
   bval=tempb(2);
elseif length(tval)==3
    tem=tval;
    disp('Bad moment tensor p=b=t');
    tval=tem(1);
    bval=tem(2);
    pval=tem(3);
else
   bval=find(ott~=pval&ott~=tval);
end
 
%Separate the coordinates of T,B and P axis, with the order
%of x,y and z
taxis=eigvec(:,tval);
baxis=eigvec(:,bval);
paxis=eigvec(:,pval);

%Only for output
tbpvec=[taxis baxis paxis];
tbpval=[eigval(tval) eigval(bval) eigval(pval)];
