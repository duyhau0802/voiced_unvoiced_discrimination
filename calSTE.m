function [ste]= calSTE(frames)
% ham calSTE : tinh nang luong moi khung 
% tham so : frames : mang chua cac khung cua tin hieu
% ham tra ve mang ste luu tru nang luong cua moi frames
   ste = zeros(1,size(frames,1));
    for i=1: size(frames,1)
        ste(i)= sum(frames(i,:).^2);
    end
    ste = ste ./ max(ste);
end