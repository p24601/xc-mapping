function dataDir = getDataDir()
if exist('/data/greywagtail/aims/aims16/apatane/','dir') == 7
    dataDir = '/data/greywagtail/aims/aims16/apatane/';
elseif exist('/data/greyheron/aims/aims16/apatane/','dir') == 7
    dataDir = '/data/greyheron/aims/aims16/apatane/';
elseif exist('/data/greypartridge/aims/aims16/apatane/','dir') == 7
    dataDir = '/data/greypartridge/aims/aims16/apatane/';
elseif exist('/data/greyplover/aims/aims16/apatane/','dir') == 7
    dataDir = '/data/greyplover/aims/aims16/apatane/';
else
    dataDir = 'maps/';
end
end