function Distance = l2Dist( F1, F2, xs , normalize, Fs_other , xs_other)
%l2Dist computes an approximation of the L2 distance betweeen the empirical
%pdf associated to data1 and the one associated to data2.
%The integral is approximated using a mid-point quadrature formula between
% in the interval [a,b]

if nargin < 6
    Fs_other = [];
    xs_other = [];
    if nargin < 4
        normalize = true;
    end
end




Distance = mid_point( (F1 -  F2 ).^2  , xs);
tolSize = 1;
if ~isempty(xs_other)
    startIdx = find(xs_other >= xs(1),1,'first');
    if isempty(startIdx)
        %Distance = Distance + mid_point( Fs_other.^2  , xs_other);
        Distance = Distance + mid_point(  evalECDF(xs_other,Fs_other, midPointsOfGrid(xs_other)).^2  , xs_other);
    else
        if startIdx > tolSize
            aux_xs = linspace(xs_other(1),xs(1),10);
            Faux = evalECDF(xs_other,Fs_other,midPointsOfGrid(aux_xs));   
            Distance = Distance +  mid_point( Faux.^2  , aux_xs);
        end
        endIdx = find(xs_other > xs(end),1,'first');
        if ~isempty(endIdx)
            aux_xs = linspace(xs(end),xs_other(end),10);  
            Faux = evalECDF(xs_other,Fs_other,midPointsOfGrid(aux_xs)); 
            Distance = Distance +  mid_point( (Faux - 1).^2  ,aux_xs);

        end
    end
end

%Distance = Distance + mid_point(( f1(2:end-1)   - f2(2:end-1) ).^2 , c_xs);

%if Distance > 100
%    disp('  ')
%end
if normalize
    Distance = Distance/(xs(end) - xs(1));
end
%Fdiff = zeros(1,length(c_xs));
%for ii = 1:length(c_xs)
%F1_inC = ;
%F2_inC =;
%Fdiff = (evalECDF(x1,F1,c_xs) -  evalECDF(x2,F2,c_xs)).^2 ;
%end
%using f....
    %delta = c_xs(2)-(c_xs(1));
    %F1 = evalECDF(x1,F1,c_xs);
    %F2 =  evalECDF(x2,F2,c_xs);
    %f1 = (F1(2:end)-F1(1:end-1))/delta;
    %f2 = (F2(2:end)-F2(1:end-1))/delta;
    %Distance = mid_point( (f1 -  f2).^2  ,xs(2:end));
    %....end using f
    %Distance = 0;
    %for ii = 1:length(c_xs)
    %   Distance = Distance + Fdiff(ii) * (xs(ii+1)-xs(ii));
    %end
    %Distance = mid_point( (evalECDF(x1,F1,c_xs) -  evalECDF(x2,F2,c_xs)).^2  ,xs);

    %end

    %new code
    %if 0
    %cs = xs(1:end-1) + (xs(2:end)-xs(1:end-1))/2;

    %[~,Fy] = EstimateDistribution(data1,cs);
    %[~,Fz] = EstimateDistribution(data2,cs);

    %cs = cs(:);

    %%%%%%fy = fy(:);
    %Fy = Fy(:);

    %%%%%%fz = fz(:);
    %Fz = Fz(:);

    %Distance = mid_point( (Fy-Fz).^2,xs);
    %end new code
    %end


    %Distance = sum( Fdiff.*(xs(2:end)-xs(1:end-1)   ));

    %if normalize
    %    Distance = Distance/(b-a);
    %end

    %toc
%end
end





