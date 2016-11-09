function stateVec = emotionState(stateString)
%
%accept either a string or a number and convert to the opponent form
%

if ischar(stateString)
    switch stateString
        case 'anger'
            stateVec = [0 0 0 0 0 0 1];
        case 'disgust'
            stateVec = [0 0 0 0 0 1 0];
        case 'fear'
            stateVec = [0 0 0 0 1 0 0];
        case 'happy'
            stateVec = [0 0 0 1 0 0 0];
        case 'neutral'
            stateVec = [0 0 1 0 0 0 0];
        case 'sadness'
            stateVec = [0 1 0 0 0 0 0];
        case 'surprise'
            stateVec = [1 0 0 0 0 0 0];
        otherwise
            printf('you input wrong state');
    end
elseif isnumeric(stateString)
    [Val,Idx] = sort(stateString,'descend');
    k = Idx(1);
    switch k
        case 7
            stateVec = 'surprise';
        case 6
            stateVec = 'sadness';
        case 5
            stateVec = 'neutral';
        case 4
            stateVec = 'happy';
        case 3
            stateVec = 'fear';
        case 2
            stateVec = 'disgust';
        case 1
            stateVec = 'anger';
    end
    
end