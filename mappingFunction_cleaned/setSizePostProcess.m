clear all
clc
close all
addpath(genpath('utils/'))
addpath('classes/')
sessionIDs = {'FirstSession','SecondSession'};

devCouples = {'Lead I', 'nymi';
              'Lead II', 'nymi';
              'Lead III', 'nymi';
              'mobile', 'nymi';
              'Palm', 'nymi'};
subDevCouples = {{},{}};
featureCoding = {};
deg = 1;
disp('ecg...')
[~,~,~,bioScores,bioTrainSizes,stdScores,sampleSizes] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs);


% figure
% hold on
% ylim([0,0.3])
% xlim([1,30])
% grid on
% %kk = cell(size(bioTrainSizes));
% kk = [];
% for ii = 1:length(bioTrainSizes)
%     xArea = [bioTrainSizes{ii} , fliplr(bioTrainSizes{ii})];
%     [lower,upper] = compConfInterval(stdScores{ii},bioScores{ii},sampleSizes{ii},0.99);
%     yArea = [lower' , fliplr(upper')];
%     %kk{ii} = plot(bioTrainSizes{ii},bioScores{ii},'LineWidth',1.5);
%     k = plot(bioTrainSizes{ii},bioScores{ii},'LineWidth',1.5);
%     kk = [kk,k];
%     h = fill(xArea,yArea,kk(ii).Color);    
%     h.FaceAlpha = 0.33;
%     h.LineStyle = 'none';
% end
% legend(kk,{'Lead I','Lead II', 'Lead III','mobile','Palm'})
% hold off
disp('ekgMove...')
devCouples = {'ekgMove', 'nymi'};
subDevCouples = {{'ekgMove_jog1','ekgMove_jog2'},{};
                 {'ekgMove_walk1','ekgMove_walk2'}, {};
                 {'ekgMove_rest'}, {}};

[~,~,~,bioScores1,bioTrainSizes1,stdScores1,sampleSizes1] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs);

%bioScoresTot = {bioScores{:},bioScores1{:}};
%bioTrainSizesTot = {bioTrainSizes{:},bioTrainSizes1{:}};
%stdScoresTot = {stdScores{:},stdScores1{:}};
%sampleSizesTot = {sampleSizes{:},sampleSizes1{:}};
%corsserIDs = {'Lead I','Lead II', 'Lead III','mobile','Palm','ekgMove-jog','ekgMove-walk','ekgMove-rest'};

%csvOfMomentsOfTrainSizeAnalysis(bioScoresTot,bioTrainSizesTot,stdScoresTot,sampleSizesTot,corsserIDs,'nymi',sessionIDs{:});


subDevCouples = {{},{}};
featureCoding = {};
deg = 1;

disp('phone...')
devCouples = {'ttsim','moto' ;
              'vivo', 'moto'};
[~,~,~,bioScores,bioTrainSizes,stdScores,sampleSizes] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs);
% corsserIDs = devCouples(:,1);
%csvOfMomentsOfTrainSizeAnalysis(bioScores,bioTrainSizes,stdScores,sampleSizes,corsserIDs,devCouples{1,2},sessionIDs{:});


devCouples = {'moto','ttsim' ;
              'vivo', 'ttsim'};
[~,~,~,bioScores1,bioTrainSizes1,stdScores1,sampleSizes1] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs);
% corsserIDs = devCouples(:,1);
%csvOfMomentsOfTrainSizeAnalysis(bioScores,bioTrainSizes,stdScores,sampleSizes,corsserIDs,devCouples{1,2},sessionIDs{:});

devCouples = {'moto','vivo' ;
              'ttsim', 'vivo'};
[~,~,~,bioScores2,bioTrainSizes2,stdScores2,sampleSizes2] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs);
% corsserIDs = devCouples(:,1);
%csvOfMomentsOfTrainSizeAnalysis(bioScores,bioTrainSizes,stdScores,sampleSizes,corsserIDs,devCouples{1,2},sessionIDs{:});
% bioScoresTot = {bioScores{:},bioScores1{:},bioScores2{:}};
% bioTrainSizesTot = {bioTrainSizes{:},bioTrainSizes1{:},bioTrainSizes2{:}};
% stdScoresTot = {stdScores{:},stdScores1{:},stdScores2{:}};
% sampleSizesTot = {sampleSizes{:},sampleSizes1{:},sampleSizes2{:}};
% 
% figure
% hold on
% ylim([0,0.3])
% xlim([1,30])
% grid on
% %kk = cell(size(bioTrainSizes));
% kk = [];
% for ii = 1:length(bioTrainSizesTot)
%     xArea = [bioTrainSizesTot{ii} , fliplr(bioTrainSizesTot{ii})];
%     [lower,upper] = compConfInterval(stdScoresTot{ii},bioScoresTot{ii},sampleSizesTot{ii},0.99);
%     yArea = [lower' , fliplr(upper')];
%     %kk{ii} = plot(bioTrainSizes{ii},bioScores{ii},'LineWidth',1.5);
%     k = plot(bioTrainSizesTot{ii},bioScoresTot{ii},'LineWidth',1.5);
%     kk = [kk,k];
%     h = fill(xArea,yArea,kk(ii).Color);    
%     h.FaceAlpha = 0.33;
%     h.LineStyle = 'none';
% end
% legend(kk,{'ttsim->moto','vivo->moto', 'moto->ttsim','vivo->ttsim','moto->vivo','ttsim->vivo'})
% hold off
% 


disp('mouse...')
devCouples = {'mouse','trackpad'};
subDevCouples = {{},{}};
deg = 1;
[~,~,~,bioScores,bioTrainSizes,stdScores,sampleSizes] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs);
% corsserIDs = devCouples(:,1);
% csvOfMomentsOfTrainSizeAnalysis(bioScores,bioTrainSizes,stdScores,sampleSizes,corsserIDs,devCouples{1,2},sessionIDs{:});
%
devCouples = {'trackpad','mouse'};
subDevCouples = {{},{}};
deg = 1;
[~,~,~,bioScores,bioTrainSizes,stdScores,sampleSizes] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs);
% corsserIDs = devCouples(:,1);
% csvOfMomentsOfTrainSizeAnalysis(bioScores,bioTrainSizes,stdScores,sampleSizes,corsserIDs,devCouples{1,2},sessionIDs{:});




disp('eyes...')
devCouples = {'uncalibrated','calibrated'};

subDevCouples = { {'reading'} , {'reading'};%0
    {'video1'} , {'reading'};%1
    {'video2'} , {'reading'};%2
    {'wiki'} , {'reading'};%3
    {'writing'} , {'reading'};%4
    {'video1'} , {'video1'};%0
    {'reading'} , {'video1'};%1
    {'video2'} , {'video1'};%2
    {'wiki'} , {'video1'};%3
    {'writing'} , {'video1'};%4
    {'video2'} , {'video2'};%0
    {'reading'} , {'video2'};%1
    {'video1'} , {'video2'};%2
    {'wiki'} , {'video2'};%3
    {'writing'} , {'video2'};%4
    {'wiki'} , {'wiki'};%0
    {'reading'} , {'wiki'};%1
    {'video1'} , {'wiki'};%2
    {'video2'} , {'wiki'};%3
    {'writing'} , {'wiki'};%4
    {'writing'} , {'writing'};%0
    {'reading'} , {'writing'};%1
    {'video1'} , {'writing'};%2
    {'video2'} , {'writing'};%3
    {'wiki'} , {'writing'};%4
    };
deg = 1;
[~,~,~,bioScores,bioTrainSizes,stdScores,sampleSizes] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs);
corsserIDs = devCouples(:,1);
%csvOfMomentsOfTrainSizeAnalysis(bioScores,bioTrainSizes,stdScores,sampleSizes,corsserIDs,devCouples{1,2},sessionIDs{:});


disp('gait...')
devCouples = {'chest', 'arm';%1
              'hand','arm';%2
              'pocket','arm';%3
              'watch','arm';%4
              'arm', 'chest';%1
              'hand','chest';%2
              'pocket','chest';%3
              'watch','chest';%4
              'chest', 'hand';%1
              'arm','hand';%2
              'pocket','hand';%3
              'watch','hand';%4
              'chest', 'pocket';%1
              'hand','pocket';%2
              'arm','pocket';%3
              'watch','pocket';%4
              'chest', 'watch';%1
              'hand','watch';%2
              'pocket','watch';%3
              'arm','watch';%4
              };
          
subDevCouples = {{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'};
                 {'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'}};
             
deg = 1;
[~,~,~,bioScores,bioTrainSizes,stdScores,sampleSizes] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs);
corsserIDs = devCouples(:,1);



devCouples = {'arm', 'arm';
              'hand','hand';
              'chest','chest';
              'pocket','pocket';
              'watch','watch'};

subDevCouples = {{'jog1_feat','jog2_feat'},{'walk1_feat','walk2_feat'};
                 {'walk1_feat','walk2_feat'},{'jog1_feat','jog2_feat'}};
             
             deg = 1;
[~,~,~,bioScores,bioTrainSizes,stdScores,sampleSizes] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs);
corsserIDs = devCouples(:,1);
