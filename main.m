clear all ;close all;

fd = 0.02;
T_ste=0;
T_zcr=0;  

for i=1:4
    if i==1
        [data,fs] = audioread('studio_F2.wav');
        frames=divFrame(data,fs,fd);
        ste = calSTE( frames);
        zcr = calZCR( frames);
        std_F2V= [78:125];
        std_F2U= [1:77];
       b=ste(std_F2V);
       d=ste(std_F2U);
        T_ste = findThreshold(b,d);
        T_zcr = findThreshold(zcr(std_F2V),zcr(std_F2U)); 
    end
end
%T_zcr = T_zcr/4;
%T_ste = T_ste/4;
% --- Ket thuc tim Threshold

% --- Thu nghiem voi file kiem thu
for c=1:4
    if c==1
        show_Figure=figure('Name','File studio_F1') ;
        [data,fs] = audioread('studio_F1.wav');    
        point= [0.68 1.10 1.13 1.22 1.27 1.65 1.70 1.76 1.79 1.86 1.92 2.15];
    end
    if c==2
        show_Figure=figure('Name','File studio_M1') ;
        [data,fs] = audioread('studio_M1.wav');
        point =[0.94 1.26 1.33 1.59 1.66 1.70 1.82 2.06]; 
    end
    if c==3
        show_Figure=figure('Name','File phone_F1') ;
        [data,fs] = audioread('phone_F1.wav');
        point =[0.53 1.14 1.21 1.35 1.45 1.60 1.83 2.20 2.28 2.35 2.40 2.52 2.66 2.73 ];
    end
    if c==4
        show_Figure=figure('Name','File phone_M1') ;
        [data,fs] = audioread('phone_M1.wav');
        point =[0.46 1.39 1.50 1.69 1.79 2.78 2.86 2.93 3.10 3.29 3.45 3.52];
     end
%  ------------------------------------------------------------------------
    frames=divFrame(data,fs,fd);
    ste = calSTE(frames);
    zcr = calZCR(frames);
    
    %DO THI KET QUA CHUAN
    subplot(5,1,3);
    time = length(data)/fs;
    t = linspace(0, time ,length(data));
    plot(t,data,'linewidth',1);
    title('DO THI KET QUA CHUAN');
    for i=1:length(point)
         x = [point(i) point(i)];
         y = [-1 1];
         line(x,y,'Color','r','LineStyle','-.','linewidth',1);
    end
    
    for i=1:2:length(point)
        text((point(i+1)-0.03),0.8,'v','Color','m','linewidth',4); % viet v vào khoang voice
        text(point(i)-0.02,-0.7,'u','Color','g','linewidth',4); % viet u vào khoang unvoice
    end
    
    legend('Signal','Result')
% -------------------------------------------------------------------------    
    %DO THI SO SANH THUC HIEN VS KET QUA CHUAN
    subplot(5,1,5);
    time = length(data)/fs;
    t = linspace(0, time ,length(data));
    plot(t,data,'linewidth',1); 
    title('DO THI SO SANH THUC HIEN VS KET QUA CHUAN ');
    xlabel('Thoi gian(s)');  
    for i=1:length(point)
     x = [point(i) point(i)];
     y = [-1 1];
     line(x,y,'Color','r','LineStyle','-.','linewidth',1);
     end
% --------------------------------------------------------------------------    
    %tim nguong cua ste = mot nua tong nang luong trung binh
    ste_norm = normalise(ste,T_ste);
    zcr_norm = normalise(zcr,T_zcr);
    T = findThreshold(ste_norm,zcr_norm);
    vu = calVU(ste_norm,zcr_norm,T);
    vu= filterVU(vu);
    line_vu=[]; %danh dau nhung diem chuyen tu huu am sang vo am
    index=1;
    for i=1:length(vu)-1
        if(vu(i)==0 && vu(i+1)==1 || vu(i)==1 && vu(i+1)==0)
            line_vu(index)=i*fd; %luu hoanh do cua nhung diem chuyen tiep
            index=index+1;
        end
    end
    hold on;
    for i=1:length(line_vu)
      a = [line_vu(i) line_vu(i)];
      y = [-1 1];
      line(a,y,'Color','b','linestyle','-','linewidth',1);
    end
    for i=1:2:length(line_vu)
        text((line_vu(i+1) -line_vu(i))/2+line_vu(i)-0.01,0.8,'v','Color','r');
        text(line_vu(i)-0.03,-0.7,'u','Color','g');
    end
    legend('Phan doan thuc hien','Phan doan chuan');
% ---------------------------------------------------------------------
    %tinh RMSE
    rmse(c)=calRMSE(point,line_vu);
% ---------------------------------------------------------------------
    %DO THI KET QUA THUC HIEN
    subplot(5,1,4);
    time = length(data)/fs;
    t = linspace(0, time ,length(data));
    plot(t,data,'linewidth',1); 
    title('DO THI KET QUA THUC HIEN');
    hold on;
   
    for i=1:length(line_vu)
     a = [line_vu(i) line_vu(i)];
     y = [-1 1];
     line(a,y,'Color','b','LineStyle','-','linewidth',1);
    end
    for i=1:2:length(line_vu)
        text((line_vu(i+1)-0.03),0.8,'v','Color','m');
        text((line_vu(i)-0.03),-0.7,'u','Color','g');
    end 
    legend('Signal','Result')
%--------------------------------------------------------------------------   
   %Ve do thi STE
    subplot(6,2,1);
    plot(t, data);
    title('DO THI STE');
    hold on;
    time1 = length(drawWave(ste_norm,fs,fd))/fs;
    t1 = linspace(0, time1 ,length(drawWave(ste_norm,fs,fd)));
    hold on;
    plot(t1,drawWave(ste_norm,fs,fd),'r');
% -------------------------------------------------------------------------    
    % Ve do thi ZCR
    subplot(6,2,2);
    plot(t, data);
    title('DO THI ZCR');
    hold on;
    time1 = length(drawWave(ste_norm,fs,fd))/fs;
    t1 = linspace(0, time1 ,length(drawWave(ste_norm,fs,fd)));
    hold on;
    plot(t1,drawWave(zcr_norm,fs,fd),'b');
% -------------------------------------------------------------------------
%     Do thi STE va ZCR
    subplot(5,1,2);
    plot(t, data,'linewidth',1);
    title('DO THI KET HOP GIUA STE VA ZCR');
    hold on;
    time1 = length(drawWave(ste_norm,fs,fd))/fs;
    t1 = linspace(0, time1 ,length(drawWave(ste_norm,fs,fd)));
    hold on;
    plot(t1,drawWave(ste_norm,fs,fd),'r','LineWidth',1);
    hold on;
    plot(t1,drawWave(zcr_norm,fs,fd),'-b','LineWidth',1);
    legend('ZCR','STE');
    
end