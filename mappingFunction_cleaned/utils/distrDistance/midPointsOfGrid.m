function c_x = midPointsOfGrid(x)

c_x =  x(1:end-1) + ( x(2:end) - x(1:(end-1)) )/2;

end