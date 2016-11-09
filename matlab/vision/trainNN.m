function NN = trainNN(featureMats)
%
%
%

[featureMats, Mu, sigma] = zscore(featureMats);

rand('state', 0);

nn = nnsetup([10 9 7]);

nn.activation_function = 'sigm';
nn.learningRate = 0.1;
opts.numepochs = 1;
opts.batchsize = 10;

nn = nntrain(nn, train_x, train_y, opts);




