N = 23; %Sets of data

f = fopen('train/labels');
t = textscan(f, '%s\t%d', N);

classes = t{1,2}';

data = cell(N, 4);
data(1,:) = {'1-1', 54, 70, 0};
data(2,:) = {'1-2', 111, 128, 0};
data(3,:) = {'1-3', 167, 186, 0};
data(4,:) = {'1-4', 223, 240, 0};
data(5,:) = {'1-5', 279, 295, 0};
data(6,:) = {'1-6', 334, 350, 0};
data(7,:) = {'1-7', 391, 409, 0};
data(8,:) = {'1-8', 449, 468, 0};
data(9,:) = {'1-9', 506, 524, 0};
data(10,:) = {'2-1', 590, 607, 0};
data(11,:) = {'2-3', 703, 727, 0};
data(12,:) = {'2-4', 773, 792, 0};
data(13,:) = {'2-5', 829, 849, 0};
data(14,:) = {'2-6', 885, 908, 0};
data(15,:) = {'3-1', 1019, 1034, 0};
data(16,:) = {'3-2', 1070, 1086, 0};
data(17,:) = {'3-3', 1123, 1140, 0};
data(18,:) = {'3-4', 1174, 1191, 0};
data(19,:) = {'3-5', 1226, 1242, 0};
data(20,:) = {'3-6', 1279, 1295, 0};
data(21,:) = {'3-7', 1567, 1586, 0};
data(22,:) = {'3-8', 1622, 1639, 0};
data(23,:) = {'3-9', 1676, 1694, 0};

%Merge test data with class labels
for i=1:N,
    data(i,4) = {classes(i)};
end


%Create 3 sets of data for each label
class_data1 = {};
class_data2 = {};
class_data3 = {};
for i=1:N,
    if isequal(data(i,4), {1}),
        class_data1(end+1,:) = data(i,:);
    elseif isequal(data(i,4), {2}),
        class_data2(end+1,:) = data(i,:);
    elseif isequal(data(i,4), {3}),
        class_data3(end+1,:) = data(i,:);
    end
end


%train on 7 pieces of data, and classify on last
size = size(class_data1)
entries = size(1)
for i=1,entries-1:
    %run trainsystem
end
