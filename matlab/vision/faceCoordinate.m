function [x,y] = faceCoordinate(im)
%XorY accept an string 'vertical' / 'horizontal'
%��ͼƬ�Ĳ���������棬��������imĬ��Ϊ���кõ�ͼƬ

%im = imread('test.png');
if ndims(im) == 3
    I = rgb2gray(im);
else
    I = im;
end

%%%%%%%���������䷽��ָ�ͼ��%%%%%%%%%%
%%%�ο����ģ����ڻҶȻ���ͶӰ�����۶�λ   �뽨ǿ��  �Ͼ����պ����ѧ
level = graythresh(I);
I1 = im2bw(I,level);

y = returnIndice(I1, 'horizontal');
x = returnIndice(I1, 'vertical');

imshow(im);hold on;
plot(x,y,'Marker','o','Color','r');
hold off;

function indice = returnIndice(I1,XorY)
%
%
[hx, ly] = size(I1);

if isequal(XorY,'vertical')
   
   marrow = ones(hx, 1);

%%%%%%%%��ͶӰ%%%%%%%%%
   for row = 1 : hx
     rFlag = 0;                  %��¼�е����ص�
        for col = 1 : ly
            if I1(row, col) == 0
                rFlag = rFlag + 1;  %��¼���ص�
            end
        end
        marrow(row, 1) = rFlag;     %��¼ͶӰ��
   end
    
   len = length(marrow);
   x = 1:1:len;
   plot(x,marrow);
   
   minV = min( marrow );
   xAxis = find( marrow == minV );
   
   if length(xAxis) == 1
        indice = xAxis;
    else
        ik = floor(length(xAxis)/2);
        indice = xAxis(ik);
   end
    
elseif isequal(XorY,'horizontal')
    
    marcol = ones(1, ly);

    %%%%%%%%����ͶӰ%%%%%%%%
    for col = 1 : ly
        cFlag = 0;                  %��¼�е����ص�
        for row = 1 : hx
            if I1(row, col) == 0
                cFlag = cFlag + 1;  %��¼���ص�
            end
        end
        marcol(1, col) = cFlag;     %��¼ͶӰ��
    end
    
    len = length(marcol);
    x = 1:1:len;
    plot(x,marcol);
    minH = min(marcol);
    yAxis = find(marcol == minH);
    
    if length(yAxis) == 1
        indice = yAxis;
    else
        ik = floor(length(yAxis)/2);
        indice = yAxis(ik);
    end
end
    




