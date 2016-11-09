function createTrainingExamples()
%
%�������ΪNN����ѵ������
%�������ǽ�ÿ��������ѡ30��������ÿ���������ȡ30��ͼƬ��Ȼ��ÿ������ת����imstream����ʽ��������

savepath = 'E:\project_data\training_example\';
mkdir(savepath);

level1 = 'E:\feedtum\';
D1 = dir(level1);
len1 = length(D1);
k = 1;

for i1 = 3 : len1
    level2 = [level1 D1(i1).name '\'];              %ĳһ�������Ŀ¼
    D2 = dir(level2);
    len2 = length(D2);
    assert(len2 > 30,'the sample is not enough!');
    savethere = [savepath D1(i1).name '\'];
    mkdir(savethere)
    count = 1;
    for i2 = 3 : 32
       level3 = [level2 D2(i2).name '\'];           %����ĳһ��������Ŀ¼�����Կ�ʼ
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
       for i3 = 1 : 30                  %�Դ˿�ʼѭ���Ķ���ͼƬ��ת����������Ȼ���ɾ��󡣴浽��Ӧ�ı���Ŀ¼��
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
       clear ans writedown imMat imgSize;                   %���imMat
    end
    
end

