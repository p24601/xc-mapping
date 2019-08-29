function F_inC = evalECDF(x , F , c )

F_inC = zeros(size(c));

lessIdx = c <= x(1);
greatIdx = c >= x(end);
F_inC(lessIdx) = 0;
F_inC(greatIdx) = 1;
F_inC(~lessIdx & ~greatIdx) = interp1(x,F,c(~lessIdx & ~greatIdx));




end