function M=getWatershedMask( I, varargin )
%GETWATERSHEDMASK Uses the fast veta watershed approach to segment the
%nuclei of an image.
% I - image file
% arg1 - normalize image (default true)
% arg2 - min scale
% arg 3 - max scale


%addpath(genpath('nuclei_seg/veta_watershed'));
%addpath(genpath('nuclei_seg/GeneralLoG'));
%addpath(genpath('nuclei_seg/staining_normalization'));

[w,h,~]=size(I);


if nargin > 1
   normalize=varargin{1};
else
   normalize=true;
end

if nargin > 2
   minScale=varargin{2};
   maxScale=varargin{3};
else
    minScale=14;
    maxScale=20;
end

if normalize
    %[normI,H,E] = normalizeStaining(I,220,0.06);
    %I=I(:,:,1);
    %[Mean_his ,H,EE] = space_RB_short(I,[],10);
    % [H,E] = ColorSepCimalab(I)
 %   I=rgb2lab(I);
 %   I = I(:,:,1);
 %  I = ((I-min(I(:)))/(max(I(:))-min(I(:))))*255;
 %   I=uint8(I);
    
    
    I=I(:,:,1);
end

p.scales=[8:2:14];
[nuclei, ~] = nucleiSegmentationV2(I,p);
M=zeros(w,h);

for k = 1:length(nuclei)
    nuc=nuclei{k};
    numPix=length(nuc);
    for ind=1:numPix
        M(nuc(ind,1),nuc(ind,2))=255;
    end
end

M = imfill(M,'holes');

end
