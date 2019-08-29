function this = runCrossVal(this,numOfThreads,degs,modelMatName,featuresCoding,one2one,distanceMeasure)
%Main wrapping function for performing cross validation on the results.
if nargin < 7
    distanceMeasure = 'l2';
    if nargin < 6
        one2one = true;
        if nargin < 5
            featuresCoding = {};
            if nargin < 4
                modelMatName = '';
                if nargin < 3
                    degs = 1;
                    if nargin < 2
                        numOfThreads = 1;
                    end
                end
            end
        end
    end
end
tic
switch this.crossMod
    case 'loo'
        this = this.levaeOneOutCrossVal(this.dataPath,numOfThreads,degs,featuresCoding,one2one,distanceMeasure,modelMatName);
    case 'no'
        this = this.trivialCrossVal(this.dataPath,numOfThreads,degs,featuresCoding,one2one,distanceMeasure);
    otherwise
        error('crossMod not implemented')
end
toc
end