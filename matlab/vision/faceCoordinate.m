function [x,y] = faceCoordinate(im)
%XorY accept an string 'vertical' / 'horizontal'
%切图片的步骤放在外面，传进来的im默认为是切好的图片

%im = imread('test.png');
if ndims(im) == 3
    I = rgb2gray(im);
else
    I = im;
end

%%%%%%%先用最大类间方差分割图像%%%%%%%%%%
%%%参考论文：基于灰度积分投影的人眼定位   冯建强等  南京航空航天大学
level = graythresh(I);
I1 = im2bw(I,level);

y = returnIndice(I1, 'horizontal');
x = returnIndice(I1, 'vertical');

imshow(im);hold on;
plot(x,y,'Marker','o','Color','r');
hold off;

function indice = returnIndice(I1,XorY)
%
%
[hx, ly] = size(I1);

if isequal(XorY,'vertical')
   
   marrow = ones(hx, 1);

%%%%%%%%求航投影%%%%%%%%%
   for row = 1 : hx
     rFlag = 0;                  %记录行的像素点
        for col = 1 : ly
            if I1(row, col) == 0
                rFlag = rFlag + 1;  %记录像素点
            end
        end
        marrow(row, 1) = rFlag;     %记录投影点
   end
    
   len = length(marrow);
   x = 1:1:len;
   plot(x,marrow);
   
   minV = min( marrow );
   xAxis = find( marrow == minV );
   
   if length(xAxis) == 1
        indice = xAxis;
    else
        ik = floor(length(xAxis)/2);
        indice = xAxis(ik);
   end
    
elseif isequal(XorY,'horizontal')
    
    marcol = ones(1, ly);

    %%%%%%%%求列投影%%%%%%%%
    for col = 1 : ly
        cFlag = 0;                  %记录列的像素点
        for row = 1 : hx
            if I1(row, col) == 0
                cFlag = cFlag + 1;  %记录像素点
            end
        end
        marcol(1, col) = cFlag;     %记录投影点
    end
    
    len = length(marcol);
    x = 1:1:len;
    plot(x,marcol);
    minH = min(marcol);
    yAxis = find(marcol == minH);
    
    if length(yAxis) == 1
        indice = yAxis;
    else
        ik = floor(length(yAxis)/2);
        indice = yAxis(ik);
    end
end
    




