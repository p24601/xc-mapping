function [lower,upper] = compConfInterval(stdIn,meanIn,N,alpha)

delta = (1-alpha)/2;
lower = zeros(length(stdIn),1);
upper = zeros(length(stdIn),1);
for ii = 1:length(stdIn)
    SEM = stdIn(ii)/sqrt(N(ii));          
    ts = tinv([delta  1-delta],N(ii)-1);        
    lower(ii) = meanIn(ii) + ts(1)*SEM;                   
    upper(ii) = meanIn(ii) + ts(2)*SEM;
end
end