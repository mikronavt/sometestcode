function objRect = featureDetection(im,objname)
%�����������ͼ����󣬺�Ҫ����Ŀ�������������Ŀ��ķ���
%

%im = imread('0001.bmp');

classifierpath = 'E:\project\pic\';

if ~ischar(objname)
    disp('objname is not right!');
    return;
end

[h,w] = size( im );
%---��¼����ͼƬ�ĳߴ磬���㻹ԭ-----
fsize.h = h;fsize.w = w;

switch objname
    %�۵����������ֻȡ�ϰ������Ȼ��������ͼ���ϲ�������ֱ�ӿ���
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
        
    %������������ֻȥͼ���²���Ȼ��������ͼ���²�������Ҫ�ӻ�ƫ��
    case 'mouth'
        mouthDetector = vision.CascadeObjectDetector( 'Mouth' );
        %[h,w] = size( im );
        imfaceD = im( floor( h/2 )+1:end, : );
        mouthbox = step( mouthDetector,imfaceD );
        objRect = returnVec( fsize,mouthbox, 'down' );
        
    %���Ӻ�������ͦ�ߣ����Ǿ�ֱ��ʹ����������
    case 'nose'
        noseDetector = vision.CascadeObjectDetector( 'Nose' );
        nosebox = step( noseDetector,im );
        objRect1 = returnVec( fsize,nosebox );
        if length(objRect1) > 1
            objRect = objRect1(1);
        else
            objRect = objRect1;
        end
        
    %üë���Լ�ѵ���ķ�������Ч�����У�������ͼ���в�������֮�������۵��������жϣ���ǿ����
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
