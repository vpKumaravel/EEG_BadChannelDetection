% This function computes the balanced accuracy
% Author: Michele Brugnara 
% Inputs: 
%        target_bin - a label vector of zeros and ones for binary
%        classification (positive class = 1, negative class = 0)
%        predicted  - the predicted index numbers (positive class)
% Example: f1 = f1score([0,1,1,0],[2,3]); % F1-Score = 1.0

function f1 = f1score(target_bin,predicted)

    predicted_bin = zeros(1,length(target_bin));
    predicted_bin(predicted) = 1;

    TP = predicted_bin & target_bin;
    FP = predicted_bin - TP;
    FN = target_bin - TP;

    TP = sum(TP);
    FP = sum(FP);
    FN = sum(FN);

    f1 = 2*TP/(2*TP+FP+FN);

end