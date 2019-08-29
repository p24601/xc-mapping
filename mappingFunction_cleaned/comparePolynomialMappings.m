addpath(genpath('utils/'))
addpath('classes/')
clear all
close all
clc

degs = [1,2,3,4];
sessionIDs = {'FirstSession','SecondSession'};

plotComparisonHistogram('moto',{'ttsim','vivo'},{{},{}},{},degs,sessionIDs,{'ttsim','vivo'},'moto');


plotComparisonHistogram('ttsim',{'moto','vivo'},{{},{}},{},degs,sessionIDs,{'moto','vivo'},'ttsim');

plotComparisonHistogram('vivo',{'moto','ttsim'},{{},{}},{},degs,sessionIDs,{'moto','ttsim'},'vivo');

plotComparisonHistogram('nymi',{'Lead I','Lead II','Lead III','mobile','Palm','ekgMove','ekgMove','ekgMove'},...
    {{},{},{},{},{},{'ekgMove_jog1','ekgMove_jog2'},{'ekgMove_walk1','ekgMove_walk2'},{'ekgMove_rest'}},{},...
    degs,sessionIDs,{'Lead I','Lead II','Lead III','mobile','Palm','ekgMove jog','ekgMove walk','ekgMove rest'},'nymi');






%target: reading (all done) 
plotComparisonHistogram('calibrated',{'uncalibrated','uncalibrated','uncalibrated','uncalibrated','uncalibrated'},...
    {{'video1'},{'video2'},{'wiki'},{'writing'},{'reading'}},{'reading'},...
    degs,sessionIDs,{'video1','video2','wiki','wirting','reading'},'reading');

%target: video 1 (all done) 
plotComparisonHistogram('calibrated',{'uncalibrated','uncalibrated','uncalibrated','uncalibrated','uncalibrated'},...
    {{'video1'},{'video2'},{'wiki'},{'writing'},{'reading'}},{'video1'},...
    degs,sessionIDs, {'video1','video2','wiki','wirting','reading'},'video1');

%target: video 2 (all done)
plotComparisonHistogram('calibrated',{'uncalibrated','uncalibrated','uncalibrated','uncalibrated','uncalibrated'},...
    {{'video1'},{'video2'},{'wiki'},{'writing'},{'reading'}},{'video2'},...
    degs,sessionIDs, {'video1','video2','wiki','wirting','reading'},'video2');

%target: wiki (all done)
plotComparisonHistogram('calibrated',{'uncalibrated','uncalibrated','uncalibrated','uncalibrated','uncalibrated'},...
    {{'video1'},{'video2'},{'wiki'},{'writing'},{'reading'}},{'wiki'},...
    degs,sessionIDs, {'video1','video2','wiki','wirting','reading'},'wiki');

%target: writing (all done)
plotComparisonHistogram('calibrated',{'uncalibrated','uncalibrated','uncalibrated','uncalibrated','uncalibrated'},...
    {{'video1'},{'video2'},{'wiki'},{'writing'},{'reading'}},{'writing'},...
    degs,sessionIDs, {'video1','video2','wiki','wirting','reading'},'writing');
