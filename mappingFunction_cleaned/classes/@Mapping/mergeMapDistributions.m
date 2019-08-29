function mapp=mergeMapDistributions(mapp,sourcePatientName,targetPatientName)
%merging the input and output distributions of the mapp object.

userNamesIn = fieldnames(mapp.inputDistributions);
userNamesOut = fieldnames(mapp.outputDistributions);

superPatientDistrIn = mapp.inputDistributions.(userNamesIn{1});
superPatientDistrOut = mapp.outputDistributions.(userNamesOut{1});


for ii = 2:length(userNamesIn)
    superPatientDistrIn = superPatientDistrIn.mergeEmpDistributions(mapp.inputDistributions.(userNamesIn{ii}));
end



for ii = 2:length(userNamesOut)
    superPatientDistrOut = superPatientDistrOut.mergeEmpDistributions(mapp.outputDistributions.(userNamesOut{ii}));
end

mapp.inputDistributions = [];
mapp.inputDistributions.(sourcePatientName) = superPatientDistrIn;

mapp.outputDistributions = [];
mapp.outputDistributions.(targetPatientName) = superPatientDistrOut;

end
