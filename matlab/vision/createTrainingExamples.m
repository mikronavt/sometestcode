function createTrainingExamples()
%
%这个函数为NN创建训练数据
%即，我们将每个表情挑选30个样本，每个样本里抽取30张图片，然后将每个样本转化成imstream的形式储存起来

savepath = 'E:\project_data\training_example\';
mkdir(savepath);

level1 = 'E:\feedtum\';
D1 = dir(level1);
len1 = length(D1);
k = 1;

for i1 = 3 : len1
    level2 = [level1 D1(i1).name '\'];              %某一个表情的目录
    D2 = dir(level2);
    len2 = length(D2);
    assert(len2 > 30,'the sample is not enough!');
    savethere = [savepath D1(i1).name '\'];
    mkdir(savethere)
    count = 1;
    for i2 = 3 : 32
       level3 = [level2 D2(i2).name '\'];           %进入某一个样本的目录，可以开始
       D3 = dir([level3 '*.jpg']);
       len3 = length(D3);
      if len3 > 30
          disp('the pic in this ');
          disp(level3);
      else
          continue;
      end
    
       name = sprintf('%03d',count);
       count = count + 1;
       %imMat = zeros(30,40000);
       for i3 = 1 : 30                  %自此开始循环的读入图片，转成行向量，然后变成矩阵。存到对应的表情目录下
           im = imread([level3 D3(i3).name]);
           im = rgb2gray(im);
           [h3,w3] = size(im);
           if k == 1                    %the key of control
               imgSize.h = h3;
               imgSize.w = w3;
               k = k + 1;
           end
           imseg = reshape(im,1,h3*w3);
           imMat(i3,:) = imseg;
       end
       % save(FILENAME,VARIABLES) stores only the specified variables.
       k = 1;
       savename = [savethere name '.mat'];
       writedown.mat = imMat;
       writedown.size = imgSize;
       save(savename,'writedown');
       clear ans writedown imMat imgSize;                   %清空imMat
    end
    
end

