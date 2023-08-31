function [rmse] = calRMSE(bienChuan, bienThucHien)
% ham calRMSE tinh Root mean squared error - sai so cua ket qua thuc hien
% so vs ket qua chuan
% tham so : bienChuan : mang chua cac bien chuan 
                % bienThucHien : mang chua cac bien cua ket qua thuc hien
mse=0;
count=0;
 for i=1 : length(bienChuan);
     for j=1 : length(bienThucHien);
         if  (abs(bienChuan(i)-bienThucHien(j)<0.1))
             mse = mse + bienChuan(i)-bienThucHien(j);
             count = count + 1;
         end
     end
 end
        mse = mse^2/count;
        rmse = sqrt(sum(mse));
end