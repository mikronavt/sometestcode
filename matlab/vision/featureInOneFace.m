function [nose,eye,eyebrow,mouth,point] = featureInOneFace( im )
%
%
%function objRect = featureDetection(im,objname)
%我们调用这个函数依次得到各个部位的特征点，然后得到全部20个特征点向量

%先算鼻子
noseRect = featureDetection( im,'nose' );
[h1,w1] = size( noseRect );
if h1 ~= 1
    fprintf( 'multiple nose detected!' );
elseif ~isfield(noseRect,'w')
    fprintf( 'no nose detected!' );
end

%disp(floor( noseRect.w / 2 ));
nose.x = noseRect.x + floor( noseRect.w / 2 );
nose.y = noseRect.y + floor( noseRect.h / 2 );

%再算眼睛，眼睛有两个rect，要返回八个点!!!!
%我们把这八个点存到一个结构体数组中去，嘿嘿
eyeRect = featureDetection( im, 'eye' );
h2 = length(eyeRect);
if h2 ~= 2
    fprintf( 'number of eye detection is not correct! need to handle this !' );
else
    for i2 = 1 : h2
        %每个结构体中存4个值，嘿嘿
        eye(i2).x1 = eyeRect(i2).x;
        eye(i2).y1 = eyeRect(i2).y + floor( eyeRect(i2).h /2 );
        
        eye(i2).x2 = eyeRect(i2).x + eyeRect(i2).w;
        eye(i2).y2 = eyeRect(i2).y + floor( eyeRect(i2).h / 2 );
        
        eye(i2).x3 = eyeRect(i2).x + floor( eyeRect(i2).w / 2 );
        eye(i2).y3 = eyeRect(i2).y;
        
        eye(i2).x4 = eyeRect(i2).x + floor( eyeRect(i2).w / 2 );
        eye(i2).y4 = eyeRect(i2).y + eyeRect(i2).h / 2;
    end
end


%再算嘴巴
%嘴巴返回四个点，这四个点
mouthRect = featureDetection( im, 'mouth');
[h3,w3] = size( mouthRect );
assert( h3 == 1, 'multiple mouth detected!' );
mouth.x1 = mouthRect.x;
mouth.y1 = mouthRect.y + floor( mouthRect.h / 2 );

mouth.x2 = mouthRect.x + mouthRect.w;
mouth.y2 = mouthRect.y + floor( mouthRect.h / 2 );

mouth.x3 = mouthRect.x + floor( mouthRect.w / 2 );
mouth.y3 = mouthRect.y;

mouth.x4 = mouthRect.x + floor( mouthRect.w / 2 );
mouth.y4 = mouthRect.y + mouthRect.h;


%最后算眉毛
%1为left, 2为right
eyebrowRect = featureDetection( im, 'eyebrow' );
[h4,w4] = size( eyebrowRect );
if ~isfield(eyebrowRect,'x')
    eyebrow(1).x = eye(1).x1;
    eyebrow(1).y = eye(1).y1 - 9;

    eyebrow(2).x = eye(1).x2;
    eyebrow(2).y = eye(1).y2 - 9;

    eyebrow(3).x = eye(2).x1;
    eyebrow(3).y = eye(2).y1 - 9;

    eyebrow(4).x = eye(2).x2;
    eyebrow(4).y = eye(2).y2 - 9;
else
    if h4 == 1
        eyebrow(1).x = eyebrowRect.x + 4;
        eyebrow(1).y = eyebrowRect.y + min(floor( eyebrowRect.h / 2 ),4);

        eyebrow(2).x = eyebrowRect.x + floor( eyebrowRect.w / 2 ) - 5;
        eyebrow(2).y = eyebrowRect.y + min(floor( eyebrowRect.h / 2 ),4);

        eyebrow(3).x = eyebrowRect.x + floor( eyebrowRect.w / 2 ) + 5;
        eyebrow(3).y = eyebrowRect.y + min(floor( eyebrowRect.h / 2 ),4);

        eyebrow(4).x = eyebrowRect.x + eyebrowRect.w - 4;
        eyebrow(4).y = eyebrowRect.y + min(floor( eyebrowRect.h / 2 ),4);
    
    elseif h4 == 2
        browBox(1) = eyebrowRect(1, :);         %分别取出两个框
        browBox(2) = eyebrowRect(2, :);

        eyebrow(1).x = browBox(1).x;
        eyebrow(1).y = browBox(1).y + floor( browBox(1).h / 2 );

        eyebrow(2).x = browBox(1).x + floor( browBox(1).w / 2 );
        eyebrow(2).y = browBox(1).y + floor( browBox(1).h / 2 );

        eyebrow(3).x = browBox(2).x + floor( browBox(2).w / 2 );
        eyebrow(3).y = browBox(2).y + floor( browBox(2).h / 2 );

        eyebrow(4).x = browBox(2).x + browBox(2).w;
        eyebrow(4).y = browBox(2).y + floor( browBox(2).h / 2 );

    end
end

point.x = [nose.x,eye(1).x1,eye(1).x2,eye(1).x3,eye(1).x4,eye(2).x1,eye(2).x2,eye(2).x3,eye(2).x4,mouth.x1,mouth.x2,mouth.x3,mouth.x4,eyebrow(1).x,eyebrow(2).x,eyebrow(3).x,eyebrow(4).x];
point.y = [nose.y,eye(1).y1,eye(1).y2,eye(1).y3,eye(1).y4,eye(2).y1,eye(2).y2,eye(2).y3,eye(2).y4,mouth.y1,mouth.y2,mouth.y3,mouth.y4,eyebrow(1).y,eyebrow(2).y,eyebrow(3).y,eyebrow(4).y];
