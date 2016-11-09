clc;
clear;
close all;

%шкала "времени"
maxTime = 50;

time = 1:1:maxTime;

%формирование первой траектории

vx1 = ones(size(time));
vy1 = ones(size(time)) * 0.7;

x1 = zeros(size(time));
y1 = zeros(size(time));

x1(1) = 3;
y1(1) = 0;

for i = 2 : maxTime
    x1(i) = x1(i - 1) + vx1(i - 1);
    y1(i) = y1(i - 1) + vy1(i - 1);
end



%формирование второй траектории

vx2 = ones(size(time));
vy2 = ones(size(time)) * 0.3;

x2 = zeros(size(time));
y2 = zeros(size(time));

x2(1) = 1;
y2(1) = 5;

for i = 2 : maxTime
    x2(i) = x2(i - 1) + vx2(i - 1);
    y2(i) = y2(i - 1) + vy2(i - 1);
end



plot([x1' x2'], [y1' y2'])


%симуляция данных радара


%5 объектов на каждое измерение
countOfMeasurments = 5;

xMeasurments = zeros(maxTime, countOfMeasurments);
yMeasurments = zeros(maxTime, countOfMeasurments);

vxMeasurments = zeros(maxTime, countOfMeasurments);
vyMeasurments = zeros(maxTime, countOfMeasurments);

randomObjectDistance = 10;
randomObjectVelocity = 2;

for i = 1 : maxTime
    firstTargetMeasure = floor(rand * 4);
    secondTargetMeasure = floor(rand * 4) + 3;
    
    for j = 1: countOfMeasurments
        if j == firstTargetMeasure
            xMeasurments(i, j) = x1(i);
            yMeasurments(i, j) = y1(i);
            vxMeasurments(i, j) = vx1(i);
            vyMeasurments(i, j) = vy1(i);
        elseif j == secondTargetMeasure
            xMeasurments(i, j) = x2(i);
            yMeasurments(i, j) = y2(i);
            vxMeasurments(i, j) = vx2(i);
            vyMeasurments(i, j) = vy2(i);
        else
            xMeasurments(i,j) = normrnd((x1(i) + x2(i))/2, randomObjectDistance);
            yMeasurments(i,j) = normrnd((y1(i) + y2(i))/2, randomObjectDistance);
            vxMeasurments(i,j) = normrnd((vx1(i) + vx2(i))/2, randomObjectVelocity);
            vyMeasurments(i,j) = normrnd((vy1(i) + vy2(i))/2, randomObjectVelocity);
        end
    end
        
    
%     xMeasurments(i,2) = x2(i);
%     yMeasurments(i, 2) = y2(i);
%     
%     xMeasurments(i,3) = normrnd(x1(i), randomObjectDistance);
%     xMeasurments(i,4) = normrnd(x1(i), randomObjectDistance);
%     xMeasurments(i,5) = normrnd(x1(i), randomObjectDistance);
%     
%     yMeasurments(i,3) = normrnd(y1(i), randomObjectDistance);
%     yMeasurments(i,4) = normrnd(y1(i), randomObjectDistance);
%     yMeasurments(i,5) = normrnd(y1(i), randomObjectDistance);
    
end

figure

plot(xMeasurments, yMeasurments, 'o');

