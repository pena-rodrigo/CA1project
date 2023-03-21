%addpath(genpath('\\engnas.bu.edu\research\eng_research_handata\EricLowet\'))
%cd('C:\Users\hanlab\Dropbox (BOSTON UNIVERSITY)\hippocampus_data_sharing\SomArchon_CA1_DC_opto\')

ses= dir('*.mat')

session=4;
trial=3;
load(ses(session).name);

% Data were sampled at 828Hz with few exceptions
FS=828;
try
FS=result.lfp.sampling_rate{1};
end

figure('COlor','w')


%Membrane potential
Vm_trace=result.traces(result.trial_vec==trial)./result.tracesB(result.trial_vec==trial);

%Input
Im = result.lfp.opto{1};

dt = 1000/FS;
t = 0:dt:dt*length(Vm_trace)-dt;

subplot(2,1,1)
plot((1:length(Vm_trace))./FS,Vm_trace,'k') %,
axis tight
%Spike times
sptimes=result.resultS{trial}.spike_idx{1};
hold on,plot(sptimes./FS, ones(1,length(sptimes)).*max(Vm_trace),'.r')
ylim([0.9 1.5])
subplot(2,1,2)
% t = 0:dt:dt*length(Im)-dt;
plot(t,Im(1:length(t)),'k')
xlim([0,t(end)])


% plot(t,Vm_trace,'k')
%      
% figure
% subplot(2,1,1)
% plot(t(1:100),Vm_trace(1:100),'k')
% subplot(2,1,2)
% plot(t(1:100),Im(1:100),'k')

%  this is half of the data to avoid photobleaching
% cut_v = [Vm_trace(end/2:end) t(1:end/2+1)' Im(1:length(t)/2+1)']; %The last is the input;
% save('v_sample2.dat' ,'cut_v','-ascii');
[ Vm_trace_smooth, coeff]=exp_fit_Fx(Vm_trace,FS);
% Vm_trace_smooth = sgolayfilt(Vm_trace,1,3);

Vm_trace = Vm_trace - Vm_trace_smooth'; 
% %where smooth was taken from Signal Analyzer Toolbox with Savitz-Golar
% %filter
% cut_v = [Vm_trace t' Im(1:length(t))']; %The last is the input;
% save('v_sample_smooth.dat' ,'cut_v','-ascii');
