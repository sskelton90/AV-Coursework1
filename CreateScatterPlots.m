N = 23; %Sets of data
M = 2; %Size of feature vectors

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

clearvars x y colors;

x = [];
y = [];
colors = [];

for i=1:N,
    x(i) = vecs(i,1);
    y(i) = vecs(i,2);
    
    if isequal(classes(i), 1),
        colors(i) = 1;
    elseif isequal(classes(i), 2),
        colors(i) = 34;
    else
        colors(i) = 58;
    end
end

scatter(x', y', 20, colors');