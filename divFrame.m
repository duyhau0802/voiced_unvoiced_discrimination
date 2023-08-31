function [frames] = divFrame(data,fs,f_d) 
% ham divFrame chia tin hieu data thanh cac frame
% data = tin hieu vao
% fs = tan so lay mau
% f_d = do dai thoi gian moi khung (s)
% ham tra ve ma tran gom i frame x j sample trong frame do 
    numberSample = f_d * fs;
    numberFrame= floor(length(data)/ numberSample);
    for i=1: numberFrame
        for j=1: numberSample
            frames(i,j)= data(numberSample*(i-1)+j);
        end
    end
end