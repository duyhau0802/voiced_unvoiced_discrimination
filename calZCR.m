function [zcr]= calZCR(frames)
% ham calZCR tinh so lan cat qua truc hoanh cua tin hieu
% tham so : frames : mang chua cac khung cua tin hieu
% ham tra ve mang zrc luu tru zcr cua moi frames
    [numberFrame,numberSample] = size(frames);
    for i=1:numberFrame
        x=frames(i,:);
        zcr(i)=0 ;
        for j=1:numberSample-1
            if(x(j)*x(j+1) <0)
                zcr(i) = zcr(i)+1;
            end
        end
    end
    zcr = zcr ./ max(zcr);
end