function objRect = featureDetection(im,objname)
%这个函数接受图像矩阵，和要检测的目标的名称来返回目标的方框
%

%im = imread('0001.bmp');

classifierpath = 'E:\project\pic\';

if ~ischar(objname)
    disp('objname is not right!');
    return;
end

[h,w] = size( im );
%---记录人脸图片的尺寸，方便还原-----
fsize.h = h;fsize.w = w;

switch objname
    %眼的情况，我们只取上半个脸，然后由于是图像上部，坐标直接可用
    case 'eye'
        leyeDetector = vision.CascadeObjectDetector( 'LeftEye' );
        reyeDetector = vision.CascadeObjectDetector( 'RightEye' );
               
        imfaceU = im( 1:floor( h/2 ) + 10, : );
        leftbox = step( leyeDetector,imfaceU );
        rightbox = step( reyeDetector,imfaceU );
        
        objRect1 = returnVec( fsize,leftbox );
        objRect2 = returnVec( fsize,rightbox );
        a1 = length(objRect1);
        a2 = length(objRect2);
        if a1 <= 1 & a2 <=1
            if ~isfield(objRect1,'x') & ~isfield(objRect2,'x')
                fprintf('no eye detected!');
            else
                disp('single eye detected!');
            end
        end
        if a1 == 2
            objRect = objRect1;
        elseif a2 == 2
            objRect = objRect2;
        elseif a1 > 2 | a2 > 2 
            if a1 > 2
                objRect = objRect1;
            elseif a2 > 2
                objRect = objRect2;
            end
        elseif a1 == 1 & a2 == 1
            if isfield(objRect1,'x') & isfield(objRect2,'x')
                objRect(1) = objRect1;
                objRect(2) = objRect2;
            end
        end
        
    %嘴的情况，我们只去图像下部，然后由于是图像下部，坐标要加回偏置
    case 'mouth'
        mouthDetector = vision.CascadeObjectDetector( 'Mouth' );
        %[h,w] = size( im );
        imfaceD = im( floor( h/2 )+1:end, : );
        mouthbox = step( mouthDetector,imfaceD );
        objRect = returnVec( fsize,mouthbox, 'down' );
        
    %鼻子好像检出率挺高，我们就直接使用整张人脸
    case 'nose'
        noseDetector = vision.CascadeObjectDetector( 'Nose' );
        nosebox = step( noseDetector,im );
        objRect1 = returnVec( fsize,nosebox );
        if length(objRect1) > 1
            objRect = objRect1(1);
        else
            objRect = objRect1;
        end
        
    %眉毛，自己训练的分类器，效果不行，我们用图像中部，并在之后用人眼的坐标做判断，加强限制
    case 'eyebrow'
        eyebrowDetector = vision.CascadeObjectDetector( [classifierpath 'eyebrow.xml'] );
        %[h,w] = size( im );
        imfaceM = im( 20:floor( h/2 ), : );
        eyebrowbox = step( eyebrowDetector,imfaceM );
        objRect = returnVec(fsize,eyebrowbox,'middle');
        
end
    


%------------------------------
function rectVect = returnVec( fsize,rectbox,position )

num = nargin;
if num == 2
    [h,w] = size(rectbox);
    if w~=4
        disp('well say something!');
    end
    
    rectVect = struct;
    for i = 1 : min(h,2)
        tmpRect = rectbox(i,:);
        rectVect(i).x = tmpRect(1);
        rectVect(i).y = tmpRect(2);
        rectVect(i).w = tmpRect(3);
        rectVect(i).h = tmpRect(4);
    end
elseif strcmp(position,'middle')
    [h,w] = size(rectbox);
    rectVect = struct;
    for i = 1 : h
        tmpRect = rectbox(i,:);
        rectVect(i).x = tmpRect(1);
        rectVect(i).y = tmpRect(2) + 20;
        rectVect(i).w = tmpRect(3);
        rectVect(i).h = tmpRect(4);
    end
        
elseif strcmp(position,'down');
    %assert(position == 'down','the position is wrong!');
    h = size(rectbox,1);
    rectVect = struct;
    %for i = 1 : h
        tmpRect = rectbox(1,:);
        rectVect.x = tmpRect(1);
        rectVect.y = tmpRect(2) + floor( fsize.h/2 );
        rectVect.w = tmpRect(3);
        rectVect.h = tmpRect(4);
    %end
end



%imshow(im);hold on;
%rectangle('Position',[lefteye.x lefteye.y lefteye.w lefteye.h]);
%rectangle('Position',[righteye.x,righteye.y,righteye.w,righteye.h]);
