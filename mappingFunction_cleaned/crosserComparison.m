load('maps/mouse/FirstSessionLinearSV_mouse_trackpad_Crosser.mat');
firstSessionCrosser = CrosserObj;
load('maps/mouse/SecondSessionLinearSV_mouse_trackpad_Crosser.mat');
secondSessionCrosser = CrosserObj;


%firstSessionCrosser.estOptValue = [];
%secondSessionCrosser.estOptValue = [];

firstSessionCrosser = firstSessionCrosser.plottingCrossValResults();
secondSessionCrosser = secondSessionCrosser.plottingCrossValResults();

figure
hold on
grid on


aboxplot({firstSessionCrosser.secScoreMatrix,secondSessionCrosser.secScoreMatrix},'OutlierMarker','x','OutlierMarkerSize',2);

xlabel('Features')
ylabel('Normalised Score')
set(gca, 'XTickLabel',firstSessionCrosser.featureIDs,'XTickLabelRotation' ,  90)
legend({'First Session', 'Second Session'})
hold off

