function fImg = faceDetection(im)
%we use this piece of code to test the viola jones algorithm in matlab
%返回的是一个结构体数组，里面的face属性记录了返回的人脸

faceDetector = vision.CascadeObjectDetector;
bbox = step(faceDetector,im);

[hbox,wbox] = size(bbox);
%fImg = 0;
for i = 1 : hbox
    vec = bbox(i,:);
    x = vec(1);
    y = vec(2);
    w = vec(3);
    h = vec(4);
    
    fImg = im(y:y+h-1,x:x+w-1);
end



