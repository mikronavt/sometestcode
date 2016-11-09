function featureMat = computeFaceFeature( imstream, size )
%a lot of programming will need us to do 
%����Ҫ����ʵ���Ǹ������еķ���
%���ȣ����Ƕ�ÿһ�����״̬��ÿһ�������г�ȡ30��ͼƬ���������ǵ�������
%Ȼ���25��ͼƬ����������ƽ������������Ȼ��õ�����ֵ������ÿһ����������һ�����룬һ��������30����
%
%
%

%imstream��ָ����ͬһ���˵�30��ͼƬ���������ζ����ǽ��д�������ÿ��ͼƬ�������㣬�������ǵ�����ֵ��
%�������Ȱ�imstream��������Ȼ���ŵ�������ȥ��
%h = size(imstream,1);
%assert(h == 30, 'the num of im is not enougth');

for i1 = 1 : 30                           %  h
    tmpIm = imstream(i1,:);
    hh = size.h;
    wh = size.w;
    im = reshape(tmpIm,hh,wh);
    %%%%�ȼ������%%%%
    imface = faceDetection( im );
    tmpA = double(imface);
    %[hf,wf] = size(tmpA);
    %im = double(im);
    %function [nose,eye,eyebrow,mouth,point] = featureInOneFace( im )
    [nose,eye,eyebrow,mouth,point] = featureInOneFace( imface );
    
    %now we get those points, then we need to perform the feature vector
    %calculation
    %we need to get the pointVec,which is corespond to the pic we define
    
    %�������pointVec�Ǹ��ṹ�忩
    %%%%%%%üë%%%%%
    pointVec(1).x = eyebrow(1).x; pointVec(1).y = eyebrow(1).y; pointVec(2).x = eyebrow(2).x; pointVec(2).y = eyebrow(2).y; 
    
    pointVec(3).x = eyebrow(3).x; pointVec(3).y = eyebrow(3).y; pointVec(4).x = eyebrow(4).x; pointVec(4).y = eyebrow(4).y; 
    %%%%%%�۾�%%%%%%
    pointVec(5).x = eye(1).x1; pointVec(5).y = eye(1).y1; pointVec(6).x = eye(1).x2; pointVec(6).y = eye(1).y2;
    
    pointVec(7).x = eye(1).x3; pointVec(7).y = eye(1).y3; pointVec(8).x = eye(1).x4; pointVec(8).y = eye(1).y4;
    
    pointVec(9).x = eye(2).x1; pointVec(9).y = eye(2).y1; pointVec(10).x = eye(2).x2; pointVec(10).y = eye(2).y2;
    
    pointVec(11).x = eye(2).x3; pointVec(11).y = eye(2).y3; pointVec(12).x = eye(2).x4; pointVec(12).y = eye(2).y4;
    %%%%%%����%%%%%%
    pointVec(13).x = nose.x; pointVec(13).y = nose.y;
    %%%%%%���%%%%%%
    pointVec(14).x = mouth.x1; pointVec(14).y = mouth.y1; pointVec(15).x = mouth.x2; pointVec(15).y = mouth.y2;
    
    pointVec(16).x = mouth.x3; pointVec(16).y = mouth.y3; pointVec(17).x = mouth.x4; pointVec(17).y = mouth.y4;
    %%%%%%���%%%%%%
    pointVec(18).x = mouth.x4; pointVec(18).y = mouth.y4+3;
    
    featureMat(i1,:) = prepareVec(pointVec);
    
    %%%%%%%�ѵ�����������¶Բ���%%%%%%%%
    
    imshow(imface);hold on;
    plot(point.x,point.y,'Marker','.','color','g');
    hold off;
end

%%
function rowVec = prepareVec(pointVec)
%
%�ú���������Ƭ�Ķ��巵��һ������10��Ԫ�ص��������������ļ���

fVec1  = abs( pointVec(5).x - pointVec(6).x );
fVec2  = abs( pointVec(11).y - pointVec(12).y );
fVec3  = abs( pointVec(1).x - pointVec(2).x );
fVec4  = abs( pointVec(3).y - pointVec(4).y );
fVec5  = abs( pointVec(3).y - pointVec(9).y );
fVec6  = abs( pointVec(13).y - pointVec(14).y );
fVec7  = abs( pointVec(10).y - pointVec(15).y );
fVec8  = abs( pointVec(14).x - pointVec(15).x );
fVec9  = abs( pointVec(16).y - pointVec(17).y );
fVec10 = abs( pointVec(13).y - pointVec(18).y );

rowVec = [fVec1 fVec2 fVec3 fVec4 fVec5 fVec6 fVec7 fVec8 fVec9 fVec10];

sumAll = sum(rowVec);
average = sumAll / 10;

rowVec = rowVec / average;