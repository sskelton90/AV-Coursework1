function [] = TrainSystem()
%TRAINSYSTEM Summary of this function goes here
%   Detailed explanation goes here

    vecs = zeros(22, 5);
    vecs(1,:) = ComputeDescriptor('1-1', 54, 70);
    vecs(2,:) = ComputeDescriptor('1-2', 111, 128);
    vecs(3,:) = ComputeDescriptor('1-3', 167, 186);
    vecs(4,:) = ComputeDescriptor('1-4', 223, 240);
    vecs(5,:) = ComputeDescriptor('1-5', 279, 295);
    vecs(6,:) = ComputeDescriptor('1-6', 334, 350);
    vecs(7,:) = ComputeDescriptor('1-7', 391, 409);
    vecs(8,:) = ComputeDescriptor('1-8', 449, 468);
    vecs(9,:) = ComputeDescriptor('1-9', 506, 524);
    vecs(10,:) = ComputeDescriptor('2-1', 590, 607);
    vecs(11,:) = ComputeDescriptor('2-2', 645, 664);
    vecs(12,:) = ComputeDescriptor('2-3', 703, 727);
    vecs(13,:) = ComputeDescriptor('2-4', 773, 792);
    vecs(14,:) = ComputeDescriptor('2-5', 829, 849);
    vecs(15,:) = ComputeDescriptor('2-6', 885, 908);
    vecs(16,:) = ComputeDescriptor('3-1', 1019, 1034);
    vecs(17,:) = ComputeDescriptor('3-2', 1070, 1086);
    vecs(18,:) = ComputeDescriptor('3-3', 1123, 1140);
    vecs(19,:) = ComputeDescriptor('3-4', 1174, 1191);
    vecs(20,:) = ComputeDescriptor('3-5', 1226, 1242);
    vecs(21,:) = ComputeDescriptor('3-6', 1279, 1295);
    vecs(22,:) = ComputeDescriptor('3-7', 1567, 1586);
%     vecs(22,:) = ComputeDescriptor('3-8', 1622, 1639);
%     vecs(23,:) = ComputeDescriptor('3-9', 1676, 1694);
    
    
    f = fopen('train/labels');
    t = textscan(f, '%s\t%d', 22);
    
    classes = t{1,2};
    
    [means, invcors, aprioris] = BuildModel(5, vecs, 22, 3, classes);
    
    % save training data        
    eval(['save ', 'model',' means invcors aprioris']);
end

