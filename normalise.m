function g = normalise(f,T)
% ham normalise dung de chuan hoa ham f 
% tham so : f = ham dau vao, T = Threshold
% return ham g nam trong khoang 0 - 1 vs T la truc hoanh
    for i=1 : length(f)
        if(f(i) >=T)
            g(i) = (f(i)-T)/(max(f)-T);
        else
            g(i) = (f(i)-T)/(T-min(f));
        end
    end
end

