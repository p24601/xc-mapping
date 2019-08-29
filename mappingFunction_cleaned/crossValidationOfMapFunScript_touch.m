%Example of computing mapping function on touch screen data.


addpath('classes/');
addpath(genpath('utils/'));
warning('off','MATLAB:table:ModifiedAndSavedVarnames');
%setting up path to dataset. Look at the folder to check the formatting
%request from the data
dataPath = '../data/touch/';

numOfThreads = 1;

%Getting IDs name for users included in the dataset. Those are stored in
%the file ../data/biometrics-collect-db - Sheet1.csv
[idsFirst, idsSecond] = getIDs();

       

%'vivo' is the source device, 'moto' is the target device.
devCouples = {'vivo','moto'};


subDevCouples = {{},{}};

%String ID used to identify the results
optId = 'FirstSessionLinearSV';


featureCoding = {};

%getting IDs of first session of recordings.
idsVec = strsplit(int2str(idsFirst'));

%For loops iteratinf over all the devCouples requested.
for ii = 1:size(devCouples,1)
    currSource = devCouples(ii,1);
    targetDev = devCouples{ii,2};
    for jj = 1:size(subDevCouples,1)
        subDevSource =  subDevCouples{jj,1};
        subDevTarget =  subDevCouples{jj,2};
        
        %creating folder to cache results.
        if exist(['maps',filesep,currSource{:}],'dir')~=7
            mkdir(['maps',filesep,currSource{:}]);
        end
        %Getting Ids in the form requested by the code.
        [existIds, ~] = getEstimationIDs(idsVec,dataPath,currSource{:},targetDev,subDevSource,subDevTarget);
        %Creating the object used to provide Cross validation results.
        CrosserObj = Crosser(existIds,currSource{:},targetDev,dataPath,subDevSource,subDevTarget,'loo',featureCoding); 
        %Running cross validation
        CrosserObj = CrosserObj.runCrossVal(numOfThreads);
        %Saving crosser objects to disk. This will store all the
        %information used in the mapping function estiamtion,
        save(['maps',filesep,currSource{:},filesep,optId,'_', currSource{:}, '_', strjoin(subDevSource), '_',...
            targetDev,'_', strjoin(subDevTarget), '_Crosser.mat' ],'CrosserObj');
        
    end
end
