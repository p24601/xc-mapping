function [ strOut ] = fromID2fieldName( strIn )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
if ~strcmp('p_',strIn(1:2))
    strOut = ['p_',strIn];
else
    strOut = strIn;
end
end

