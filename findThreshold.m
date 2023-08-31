function T = findThreshold(f,g)
    % thuat toan tim nguong dua tren tim kiem nhi phan va cong thuc 2.8
    % sach CS425
    % tham so : f (mang chua cac frame unvoice), g(mang chua cac frame voice)
    % return nguong T
    % Buoc 1: f, g
    % Buoc 2
    if max(f)< max(g)
        T_max = max(g);
    else T_max = max(f);
    end
    if min(f) < min(g)
        T_min = min(f);
    else T_min = min(g);
    end
    % Buoc 3
    T = 0.5*(T_min+T_max);
    % Buoc 4
    i = length(find(f<T)); % so luong phan tu nho hon T cua f
    p = length(find(g>T)); % so luong phan tu lon hon T cua g
    % Buoc 5
    j = -1; 
    q = -1; 
    % Buoc 6 + Buoc 7
    N_f = length(f);      % so luong phan tu nf cu
    N_g = length(g);    % so luong phan tu ng cu
    while (i~=j || p~=q)
        % so sanh ti le phan tu bi mat voi nguong T cua f() va g()
        if sum(f(f>T)-T)/N_f - sum(T-g(g<T))/N_g > 0 
            T_min = T;
        else T_max = T; 
        end
    % Buoc 8
        T = 0.5*(T_min+T_max);
    % Buoc 9
        j = i; 
        q = p;
    % Buoc 10
        i = sum(f<T);
        p = sum(g>T);
    end
end
