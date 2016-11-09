function fImg = faceDetection(im)
%we use this piece of code to test the viola jones algorithm in matlab
%���ص���һ���ṹ�����飬�����face���Լ�¼�˷��ص�����

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



