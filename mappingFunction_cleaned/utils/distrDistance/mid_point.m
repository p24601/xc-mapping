function value = mid_point(fun,xs)

%tic
value = 0;
for ii = 1:(length(xs)-1)
   value = value + fun(ii) * (xs(ii+1)-xs(ii));
end
%toc

%diffX = diff(xs);
%value = (xs(2)-xs(1))*sum(fun);
%value = dot(fun(),diff(xs));

end
