function score = fitAndW82Score(avgFits,featW8)
    score = dot(avgFits,featW8)/sum(featW8);
end