classdef OptResults
%Class for handling and storing optimisation results.    
    properties
        x_star
        y_star
        runtime
        population
        scores
    end
    
    methods

        function res = OptResults(x_star,y_star,population,scores,runtime)
            res.x_star=x_star;
            res.y_star = y_star;
            res.runtime=runtime;
            
            %sort scores and population based also on solution distances
            %[sortedPop,sortedScores] = sortPopulation(population,scores);
            %res.scores = sortedScores;
            %res.population=sortedPop;
        end
        
        function [as,bs] = getNthBestSolution(res,n)
            if (n > size(res.population,1)) || (n==1)
                as=res.As;
                bs=res.Bs;
            else
                [as, bs] = getAsBs(res.population(n,:));
            end
        end
    end
end