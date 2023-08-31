function points = drawWave(Input,f_s,f_d)
%drawWave la ham ve do thi tu input
% f_s la tan so lay mau (Hz)
% f_d la do dai cua frame (s)
% ham return ma tran de ve do thi cho ma tran input
numberSample = floor(f_d * f_s);
points = 0;
for i = 1 : length(Input)
    vitri = length(points);
    points(vitri : vitri + numberSample) = Input(i);
end