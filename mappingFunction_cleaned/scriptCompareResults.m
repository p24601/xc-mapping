addpath(genpath('utils/'));
addpath('classes/');
close all
clear all
%%%Phone
disp('Plotting Phone results...')
%target: vivo (all done)
featureScoreVecVivo = produceComparePlot({'moto','ttsim'},'vivo',{'FirstSession','SecondSession'});
%target: moto (all done)
featureScoreVecMoto = produceComparePlot({'vivo','ttsim'},'moto',{'FirstSession','SecondSession'});
%target ttsim (all done)
featureScoreVecTtsim = produceComparePlot({'vivo','moto'},'ttsim',{'FirstSession','SecondSession'});

%compareFeatureScores(featureScoreVecVivo,{'moto','ttsim'},'vivo',featureScoreVecMoto,{'vivo','ttsim'},'moto',featureScoreVecTtsim,{'vivo','moto'},'ttsim');
%%%ECG
disp('Plotting ECG results...')
%target: nymi (all done)
produceComparePlot({'Lead I','Lead II','Lead III','mobile','Palm','ekgMove','ekgMove','ekgMove'},'nymi',{'FirstSession','SecondSession'}, ...
    {'Lead I','Lead II','Lead III','mobile','Palm','ekgMove jog','ekgMove walk','ekgMove rest'}, 'nymi',...
    {{''},{''},{''},{''},{''},{'ekgMove_jog1','ekgMove_jog2'},{'ekgMove_walk1','ekgMove_walk2'},{'ekgMove_rest'}} );

%%%Eyes calibrated input
disp('Plotting Eyes results...')
%target: reading (all done) 
produceComparePlot({'calibrated','calibrated','calibrated','calibrated'},'calibrated',{'FirstSession','SecondSession'},{'video 1','video 2','wiki', 'writing'},...
    'reading',{{'video1'},{'video2'},{'wiki'},{'writing'}},{'reading'});

%target: video 1 (all done) 
produceComparePlot({'calibrated','calibrated','calibrated','calibrated'},'calibrated',{'FirstSession','SecondSession'}, ...
    {'reading','video 2','wiki','writing'},'video 1',{{'reading'},{'video2'},{'wiki'},{'writing'}},{'video1'});

%target: video 2 (all done)
produceComparePlot({'calibrated','calibrated','calibrated','calibrated'},'calibrated',{'FirstSession','SecondSession'}, ...
    {'video 1','reading','wiki', 'writing'},'video2',{{'video1'},{'reading'},{'wiki'},{'writing'}},{'video2'});

%target: wiki (all done)
produceComparePlot({'calibrated','calibrated','calibrated','calibrated'},'calibrated',{'FirstSession','SecondSession'}, ...
    {'video 1','reading','video 2', 'writing'},'wiki',{{'video1'},{'reading'},{'video2'},{'writing'}},{'wiki'});

%target: writing (all done)
produceComparePlot({'calibrated','calibrated','calibrated','calibrated'},'calibrated',{'FirstSession','SecondSession'}, ...
    {'video 1','reading','video 2', 'wiki'},'writing',{{'video1'},{'reading'},{'video2'},{'wiki'}},{'writing'});


%%%Eyes uncalibrated input
disp('Plotting Eyes results...')
%target: reading (all done) 
produceComparePlot({'uncalibrated','uncalibrated','uncalibrated','uncalibrated','uncalibrated'},'calibrated',{'FirstSession','SecondSession'},{'video 1','video 2','wiki', 'writing','reading'},...
    'reading',{{'video1'},{'video2'},{'wiki'},{'writing'},{'reading'}},{'reading'});

%target: video 1 (all done) 
produceComparePlot({'uncalibrated','uncalibrated','uncalibrated','uncalibrated','uncalibrated'},'calibrated',{'FirstSession','SecondSession'}, ...
    {'reading','video 2','wiki','writing','video 1'},'video 1',{{'reading'},{'video2'},{'wiki'},{'writing'},{'video1'}},{'video1'});

%target: video 2 (all done)
produceComparePlot({'uncalibrated','uncalibrated','uncalibrated','uncalibrated','uncalibrated'},'calibrated',{'FirstSession','SecondSession'}, ...
    {'video 1','reading','wiki', 'writing','video2'},'video2',{{'video1'},{'reading'},{'wiki'},{'writing'},{'video2'}},{'video2'});

%target: wiki (all done)
produceComparePlot({'uncalibrated','uncalibrated','uncalibrated','uncalibrated','uncalibrated'},'calibrated',{'FirstSession','SecondSession'}, ...
    {'video 1','reading','video 2', 'writing','wiki'},'wiki',{{'video1'},{'reading'},{'video2'},{'writing'},{'wiki'}},{'wiki'});

%target: writing (all done)
produceComparePlot({'uncalibrated','uncalibrated','uncalibrated','uncalibrated','uncalibrated'},'calibrated',{'FirstSession','SecondSession'}, ...
    {'video 1','reading','video 2', 'wiki','writing'},'writing',{{'video1'},{'reading'},{'video2'},{'wiki'},{'writing'}},{'writing'});




%%%Mouse
disp('Plotting Mouse results...')
%target mouse (all done)
produceComparePlot({'mouse'},'trackpad',{'FirstSession','SecondSession'});

%target trackpad (all done)
produceComparePlot({'trackpad'},'mouse',{'FirstSession','SecondSession'});

%%%Gait:
disp('Plotting Gait results...')

%arm walk
produceComparePlot({'chest','hand','pocket','watch','arm'},'arm',{'FirstSession','SecondSession'},{'chest-walk','hand-walk','pocket-walk','watch-walk','arm-jog'},...
    'arm-walk',{{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'jog1_feat','jog2_feat'}},...
    {'walk1_feat','walk2_feat'});

%arm jog
produceComparePlot({'chest','hand','pocket','watch','arm'},'arm',{'FirstSession','SecondSession'},{'chest-jog','hand-jog','pocket-jog','watch-jog','arm-walk'},...
    'arm-jog',{{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'walk1_feat','walk2_feat'}},...
    {'jog1_feat','jog2_feat'});

%chest walk
produceComparePlot({'arm','hand','pocket','watch','chest'},'chest',{'FirstSession','SecondSession'},{'arm-walk','hand-walk','pocket-walk','watch-walk','chest-jog'},...
    'chest-walk',{{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'jog1_feat','jog2_feat'}},...
    {'walk1_feat','walk2_feat'});

%chest jog
produceComparePlot({'arm','hand','pocket','watch','chest'},'chest',{'FirstSession','SecondSession'},{'arm-jog','hand-jog','pocket-jog','watch-jog','chest-walk'},...
    'chest-jog',{{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'walk1_feat','walk2_feat'}},...
    {'jog1_feat','jog2_feat'});

%hand walk
produceComparePlot({'arm','chest','pocket','watch','hand'},'hand',{'FirstSession','SecondSession'},{'arm-walk','chest-walk','pocket-walk','watch-walk','hand-jog'},...
    'hand-walk',{{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'jog1_feat','jog2_feat'}},...
    {'walk1_feat','walk2_feat'});

%hand jog
produceComparePlot({'arm','chest','pocket','watch','hand'},'hand',{'FirstSession','SecondSession'},{'arm-jog','chest-jog','pocket-jog','watch-jog','hand-walk'},...
    'hand-jog',{{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'walk1_feat','walk2_feat'}},...
    {'jog1_feat','jog2_feat'});

%pocket walk
produceComparePlot({'arm','chest','hand','watch','pocket'},'pocket',{'FirstSession','SecondSession'},{'arm-walk','chest-walk','hand-walk','watch-walk','pocket-jog'},...
    'pocket-walk',{{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'jog1_feat','jog2_feat'}},...
    {'walk1_feat','walk2_feat'});

%pocket jog
produceComparePlot({'arm','chest','hand','watch','pocket'},'pocket',{'FirstSession','SecondSession'},{'arm-jog','chest-jog','hand-jog','watch-jog','pocket-walk'},...
    'pocket-jog',{{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'walk1_feat','walk2_feat'}},...
    {'jog1_feat','jog2_feat'});

%watch walk
produceComparePlot({'arm','chest','hand','pocket','watch'},'watch',{'FirstSession','SecondSession'},{'arm-walk','chest-walk','hand-walk','pocket-walk','watch-jog'},...
    'watch-walk',{{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'walk1_feat','walk2_feat'},{'jog1_feat','jog2_feat'}},...
    {'walk1_feat','walk2_feat'});

%watch jog
produceComparePlot({'arm','chest','hand','pocket','watch'},'watch',{'FirstSession','SecondSession'},{'arm-jog','chest-jog','hand-jog','pocket-jog','watch-walk'},...
    'watch-jog',{{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'jog1_feat','jog2_feat'},{'walk1_feat','walk2_feat'}},...
    {'jog1_feat','jog2_feat'});


%ecg gender analysis:

[featScoreM,bestFitMatrixesM] = produceComparePlot({'Lead I','Lead II','Lead III','mobile','Palm','ekgMove','ekgMove','ekgMove'},'nymi',{'FirstSession'}, ...
    {'Lead I','Lead II','Lead III','mobile','Palm','ekgMove jog','ekgMove walk','ekgMove rest'}, 'nymi',...
    {{''},{''},{''},{''},{''},{'ekgMove_jog1','ekgMove_jog2'},{'ekgMove_walk1','ekgMove_walk2'},{'ekgMove_rest'}},{''},'genderAnalysis/M' );


[featScoreF,bestFitMatrixesF] = produceComparePlot({'Lead I','Lead II','Lead III','mobile','Palm','ekgMove','ekgMove','ekgMove'},'nymi',{'FirstSession'}, ...
    {'Lead I','Lead II','Lead III','mobile','Palm','ekgMove jog','ekgMove walk','ekgMove rest'}, 'nymi',...
    {{''},{''},{''},{''},{''},{'ekgMove_jog1','ekgMove_jog2'},{'ekgMove_walk1','ekgMove_walk2'},{'ekgMove_rest'}},{''},'genderAnalysis/F' );


[featScoreB,bestFitMatrixesB] = produceComparePlot({'Lead I','Lead II','Lead III','mobile','Palm','ekgMove','ekgMove','ekgMove'},'nymi',{'FirstSession'}, ...
    {'Lead I','Lead II','Lead III','mobile','Palm','ekgMove jog','ekgMove walk','ekgMove rest'}, 'nymi',...
    {{''},{''},{''},{''},{''},{'ekgMove_jog1','ekgMove_jog2'},{'ekgMove_walk1','ekgMove_walk2'},{'ekgMove_rest'}},{''},'genderAnalysis/B' );

bar([featScoreM,featScoreF,featScoreB])
