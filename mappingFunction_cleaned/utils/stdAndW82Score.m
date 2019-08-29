function stdOut = stdAndW82Score(stdFits,featW8)
stdOut = sqrt(dot(featW8.^2,stdFits.^2))/(sum(featW8));

end