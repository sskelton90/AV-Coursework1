N = 23; %Sets of data
M = 2; %Size of feature vectors
index = 3; %Which piece of data in each label to classify/test

clearvars training_data training_classes;

if exist('f') == 0,
    f = fopen('train/labels');
    t = textscan(f, '%s\t%d', N);

    classes = t{1,2}';

    data = cell(N, 3);
    data(1,:) = {'1-1', 54, 70};
    data(2,:) = {'1-2', 111, 128};
    data(3,:) = {'1-3', 167, 186};
    data(4,:) = {'1-4', 223, 240};
    data(5,:) = {'1-5', 279, 295};
    data(6,:) = {'1-6', 334, 350};
    data(7,:) = {'1-7', 391, 409};
    data(8,:) = {'1-8', 449, 468};
    data(9,:) = {'1-9', 506, 524};
    data(10,:) = {'2-1', 590, 607};
    data(11,:) = {'2-3', 703, 727};
    data(12,:) = {'2-4', 773, 792};
    data(13,:) = {'2-5', 829, 849};
    data(14,:) = {'2-6', 885, 908};
    data(15,:) = {'3-1', 1019, 1034};
    data(16,:) = {'3-2', 1070, 1086};
    data(17,:) = {'3-3', 1123, 1140};
    data(18,:) = {'3-4', 1174, 1191};
    data(19,:) = {'3-5', 1226, 1242};
    data(20,:) = {'3-6', 1279, 1295};
    data(21,:) = {'3-7', 1567, 1586};
    data(22,:) = {'3-8', 1622, 1639};
    data(23,:) = {'3-9', 1676, 1694};
    
    %generate feature vectors
    vecs = zeros(N, M);
    
    for i=1:N,
        vecs(i,:) = ComputeDescriptor(data{i,1}, data{i,2}, data{i,3});
    end
end


%Create 3 sets of data for each label
class_data1 = [];
class_data2 = [];
class_data3 = [];
for i=1:N,
    if isequal(classes(i), 1),
        class_data1(end+1,:) = vecs(i,:);
    elseif isequal(classes(i), 2),
        class_data2(end+1,:) = vecs(i,:);
    elseif isequal(classes(i), 3),
        class_data3(end+1,:) = vecs(i,:);
    end
end

size1 = size(class_data1);
size2 = size(class_data2);
size3 = size(class_data3);

%Create arrays of training data and test data
clearvars temp_index; %If index is higher than number of data for a label, test the last set of data for that label
if index > size1(1),
    temp_index = size1(1);
else
    temp_index = index;
end

training_data = zeros(N-3, M);
classify_data = zeros(3, M);
counter = 1;

for i=1:size1(1),
    if i == temp_index,
        classify_data(1,:) = class_data1(i,:,:);
        continue;
    end
    training_data(counter,:) = class_data1(i,:,:);
    counter = counter+1;
end

clearvars temp_index;
if index > size2(1),
    temp_index = size2(1);
else
    temp_index = index;
end

for i=1:size2(1),
    if i == temp_index,
        classify_data(2,:) = class_data2(i,:,:);
        continue;
    end
    training_data(counter,:) = class_data2(i,:,:);
    counter = counter+1;
end

clearvars temp_index;
if index > size3(1),
    temp_index = size3(1);
else
    temp_index = index;
end

for i=1:size3(1),
    if i == temp_index,
        classify_data(3,:) = class_data3(i,:,:);
        continue;
    end
    training_data(counter,:) = class_data3(i,:,:);
    counter = counter+1;
end

%Create training data, excluding one data of each label
%training_data = [class_data1(1:end-1,:,:); class_data2(1:end-1,:,:); class_data3(1:end-1,:,:)];
s = size(training_data);


%Create corresponding labels array and descriptors array
if exist('training_classes') == 0,
    for i=1:s(1),
        if i < size1(1),
            training_classes(i) = 1;
        elseif i < ((size1(1)-1) + size2(1)),
            training_classes(i) = 2;
        else,
            training_classes(i) = 3;
        end
    end
end

training_classes = training_classes'; %Transpose to one dimensional array

[means, invcors, aprioris] = BuildModel(M, training_data, s(1), 3, training_classes);


%Classify on last pieces of data
class1 = Classify(classify_data(1), 3, means, invcors, M, aprioris);
class2 = Classify(classify_data(2), 3, means, invcors, M, aprioris);
class3 = Classify(classify_data(3), 3, means, invcors, M, aprioris);