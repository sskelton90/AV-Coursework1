function [class] = Classifier(directory, start, finish)
%CLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

    v = ComputeDescriptor(directory, start, finish);
    
    eval(['load ', 'model',' means invcors aprioris']);
    
    class = Classify(v, 3, means, invcors, 7, aprioris);
end

