function [class] = Classifier(directory, start, finish)
%CLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

    vecs = ComputeDescriptor(directory, start, finish);
    
    eval(['load ', 'model',' means invcors aprioris']);
    
    class = Classify(vecs, 3, means, invcors, 5, aprioris)
end

