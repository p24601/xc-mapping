function opts = getOptimisationOptsPS( verbose,numOfThreads )

opts = psoptimset;

opts.Display = 'off';

opts.Cache = 'on';
opts.CacheTol= 10^-4;
opts.TolFun = 10^-5;
opts.InitialMeshSize = 0.25;
opts.MaxMeshSize = 0.25;
%opts.InitialMeshSize = 0.1;
%opts.MaxMeshSize = 0.5;
opts.TolMesh = 10^-4;
opts.TolX = 10^-4;

opts.CompletePoll = 'on';
opts.CompleteSearch = 'on';
%opts.MeshContraction = 0.75;
opts.MeshExpansion = 1.25;
opts.TolBind = 1e-2;

opts.MaxIter = 300;
end

