function mapSpec = polynomial_map_spec( deg ,dimIn, dimOut )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mapSpec = [];

if(dimIn > 1 || dimOut > 1)
    if deg > 1
        warning('For multivariate regression I have implemented only linear functions so far...')
    end
    multiFlag = true;
else
    multiFlag = false;
end

if deg < 2
    mapSpec.is_monotonic = true;
else
    mapSpec.is_monotonic = false;
end
if ~multiFlag
    mapSpec.params = zeros(deg+1,1);
    %mapSpec.fun = @(z,P)( dot( z.^(0:deg), P ) );
    mapSpec.fun = @(z,P)(bsxfun( @power, repmat(z,1,deg+1), 0:deg) * P);  
    %mapSpec.fun = @(z,P)( P(1) + P(2)*z  );
else
    mapSpec.params = zeros(dimOut * (1 + dimIn),1);
    %only linear map implemented here so far...
    mapSpec.fun = @(z,P)( P(1:dimOut) + reshape(P( (dimOut+1):end  ) , dimOut,dimIn ) * z(:) );
end
mapSpec.is_poly = true;
mapSpec.is_gp = false;

end

