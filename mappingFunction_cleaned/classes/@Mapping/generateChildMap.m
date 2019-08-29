function child = generateChildMap(this, currFeat)
%generateChildMap generates the sub-map of mapping object this, with the
%fields concerning only the feature currFeat.
%In doing so, I remove all the fields which are not strictly necessary for
%the optimization itself


child = this;

%removing other features from the sources distributions
%and removing unecessary fields


child.sourceDistributions = rmOtherFeatures( child.sourceDistributions , currFeat );


%removing other features from the target patients
%and removing unecessary fields
child.targetDistributions = rmOtherFeatures( child.targetDistributions , currFeat );


child.mapSpec =  rmOtherFeatures( this.mapSpec , currFeat );
child.child4 = currFeat;

end

