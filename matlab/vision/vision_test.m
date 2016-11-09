% see http://www.codeforge.com/article/243480 for examples

clc;
clear all;
close all;

image_fname = 'face100.jpg';
I = imread(image_fname); % read an image from disk
imshow(I);


countOfFaces = 2;
i = 0;
while countOfFaces > 1	
	faceDetector = vision.CascadeObjectDetector;
	faceDetector.MergeThreshold = i;
	

	faceBBox = step(faceDetector,I);
	countOfFaces = size(faceBBox,1);
    i = i + 1;

end
		


for i = 1:size(faceBBox,1)
   rectangle('Position',faceBBox(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','r');
end


i = 0;
countOfPairEyes = 2;
while countOfPairEyes > 1
	eyesDetector = vision.CascadeObjectDetector('EyePairBig');
	eyesDetector.MergeThreshold = i;

	eyesBBox = step(eyesDetector, I);
	countOfPairEyes = size(eyesBBox, 1);
	i = i + 1;
end	


for i = 1:size(eyesBBox,1)
   rectangle('Position',eyesBBox(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','b');
end

i = 0;
countOfNoses = 2;
while countOfNoses > 1
	noseDetector = vision.CascadeObjectDetector('Nose');
	noseDetector.MergeThreshold = i;

	noseBBox = step(noseDetector, I);
	countOfNoses = size(noseBBox, 1);
	i = i + 1;
end

for i = 1:size(noseBBox,1)
   rectangle('Position',noseBBox(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','y');
end


i = 0;
countOfMouths = 2;
while countOfMouths > 1

	mouthDetector = vision.CascadeObjectDetector('Mouth');
	mouthDetector.MergeThreshold = i;

	mouthBBox = step(mouthDetector, I);
	countOfMouths = size(mouthBBox, 1);
	i = i + 1;
end

for i = 1:size(mouthBBox,1)
   rectangle('Position',mouthBBox(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','g');
end

i = 0;
countOfLeftEyes = 4;
while countOfLeftEyes > 2
	leftEyeDetector = vision.CascadeObjectDetector('LeftEyeCART');
	leftEyeDetector.MergeThreshold = i;

	leftEyeBBox = step(leftEyeDetector, I);
	countOfLeftEyes = size(leftEyeBBox, 1)
	i = i + 1;
end;

if countOfLeftEyes == 2
	if leftEyeBBox(1, 1) > leftEyeBBox(2,1)
		leftEyeBBox = leftEyeBBox(1, :);
	else 
		leftEyeBBox = leftEyeBBox(2, :);
	end
end 

for i = 1:size(leftEyeBBox,1)
   rectangle('Position',leftEyeBBox(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','black');
end

i = 0;
countOfRightEyes = 3;
while countOfRightEyes > 2
	rightEyeDetector = vision.CascadeObjectDetector('RightEyeCART');
	rightEyeDetector.MergeThreshold = i;

	rightEyeBBox = step(rightEyeDetector, I);
	countOfRightEyes = size(rightEyeBBox, 1);
	i = i + 1;
end;

if countOfRightEyes == 2
	if rightEyeBBox(1, 1) < rightEyeBBox(2,1)
		rightEyeBBox = rightEyeBBox(1, :);
	else 
		rightEyeBBox = rightEyeBBox(2, :);
	end
end 

for i = 1:size(rightEyeBBox,1)
   rectangle('Position',rightEyeBBox(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','w');
end



verticalSymmetryCenter = noseBBox(1, 1) + noseBBox(1, 3)/2;

hold on
plot([verticalSymmetryCenter verticalSymmetryCenter], [0 500]);

horizontalCenter = mouthBBox(1, 2) + mouthBBox(1, 4)/3;

hold on
plot([0 500], [horizontalCenter horizontalCenter]);

leftEyeCenter = zeros(1, 2);
leftEyeCenter(1) = leftEyeBBox(1,1) + leftEyeBBox(1,3)/2;
leftEyeCenter(2) = leftEyeBBox(1,2) + leftEyeBBox(1,4)*3/5;

rightEyeCenter = zeros(1, 2);
rightEyeCenter(1) = rightEyeBBox(1,1) + rightEyeBBox(1,3)/2;
rightEyeCenter(2) = rightEyeBBox(1,2) + rightEyeBBox(1,4)*3/5;

hold on
plot(leftEyeCenter(1), leftEyeCenter(2), 'o');
plot(rightEyeCenter(1), rightEyeCenter(2),'o');

newScaleLength = (((rightEyeCenter(1) - leftEyeCenter(1))^2 + (rightEyeCenter(2) - leftEyeCenter(2))^2)^0.5)/50

% %crop faces and convert it to gray
% for i = 1:size(BB,1)
% J= imcrop(videoFrame,BB(i,:));
% I=rgb2gray(imresize(J,[292,376]));
% %save cropped faces in folder
% filename = ['G:\matlab_installed\bin\database\' num2str(i+k*(size(BB,1))) '.jpg'];
%   imwrite(I,filename);
% end
