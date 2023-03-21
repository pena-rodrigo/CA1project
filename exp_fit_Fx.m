function [ fitbaseline, coeff]=exp_fit_Fx(v,FS)
    %% fits an expoential to estimate the photobleaching
    start_of_stimulation=1*FS; % starts at 1second 
    end_of_stimulation= 2*FS; % ends at 2second after trial start
    v1=v;
%     v1([  start_of_stimulation:end_of_stimulation])= mean([ v([start_of_stimulation-20:start_of_stimulation end_of_stimulation:end_of_stimulation+20])]);
%     v1 = mean(v);
    F = @(x,xdata)x(1)+x(2)*exp(- xdata./x(3));%+ x(3)*exp(- xdata./x(4))  ;
    x0 = [mean(v1) 40 1.5   ] ;
    OPTIONS = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt');
    t = (1:length(v))./FS;
    tsel=1:length(t);
    xunc = lsqcurvefit(F, x0, t(tsel)', v1(tsel),[],[],OPTIONS);
    fitbaseline=xunc(1)+xunc(2)*exp(-t./xunc(3));
    coeff=xunc;
% figure,plot(t,fit_baseline)
%       hold on,plot(t,v)
