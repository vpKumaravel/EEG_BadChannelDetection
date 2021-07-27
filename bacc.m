% This function computes the balanced accuracy
% Authors: Michele Brugnara, Velu Prabhakar Kumaravel
%
% Inputs: 
%        target_bin - a label vector of zeros and ones for binary
%        classification (positive class = 1, negative class = 0)
%        predicted  - the predicted index numbers (positive class)
% Example: bacc = bacc([0,1,1,0],[2,3])

function bacc = bacc(target_bin,predicted)
    predicted_bin = zeros(1,length(target_bin));
    predicted_bin(predicted) = 1;

    TP = predicted_bin & target_bin;
    FP = predicted_bin - TP;
    FN = target_bin - TP;
    TN  = not(target_bin | predicted_bin);

    TP = sum(TP);
    FP = sum(FP);
    FN = sum(FN);
    TN = sum(TN);

    bacc = 0.5*((TP/(TP+FN))+(TN/(TN+FP)));

    if(TP == 0 && FN == 0)
        bacc = TN/(TN+FP);
    end
end

