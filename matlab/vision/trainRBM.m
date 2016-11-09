function trainRBM()
%
%
%

%----the place we save NN
savepath = 'E:\project_data\NN\';

%%%%%%input data%%%%%%
datapath = 'E:\project_data\feature_data\';
%这里我们打算吧特征向量都读出来，然后组装成一个大矩阵，然后输入NN
D1 = dir(datapath);
len1 = length(D1);
for i1 = 3:len1
    level2 = [datapath D1(i1).name '\'];
    D2 = dir([level2 '*.mat']);
    len2 = length(D2);
    
    name1 = [level2 D2(1).name];
    name2 = [level2 D2(2).name];
        load(name1);
        load(name2);
        if i1 == 3
            train_x = dValue;
            train_y = emotionMat;
        else
            train_x = [train_x;dValue];
            train_y = [train_y;emotionMat];
        end
        clear ans a dValue emotionalMat;
    
end
[train_x,mu,sigma] = zscore(train_x);
%------train a 24hidden unit RBM 
rand('state',0);
dbn.sizes = [24 17];
opts.numepochs = 4;
opts.batchsize = 10;
opts.momentum = 0;
opts.alpha = 1;
dbn = dbnsetup(dbn, train_x, opts);
dbn = dbntrain(dbn, train_x, opts);

%unfold dbn to nn
nn = dbnunfoldtonn(dbn, 10);
nn.activation_function = 'sigm';

%train nn
opts.numepochs =  4;
opts.batchsize = 10;
nn = nntrain(nn, train_x, train_y, opts);

save('dbn.mat','nn');