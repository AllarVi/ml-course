classdef MetricFunction
    %MetricFunction Metric or distance function is a function that defines
    % a distance between each pair of elements of a set.
    
    methods(Static)  
        function result = minkowskiDistance(set1, set2, p)
            set3 = abs(set1 - set2) .^ p;
            result = sum(set3)^(1 / p);
        end
        
        function result = euclideanDistance(set1, set2)
            result = MetricFunction.minkowskiDistance(set1, set2, 2);
        end
        
        function result = manhattanDistance(set1, set2)
            result = MetricFunction.minkowskiDistance(set1, set2, 1);
        end
        
        function result = chebyshevDistance(set1, set2)
            set3 = abs(set1 - set2);
            result = max(set3);
        end
        
        function result = canberraDistance(set1, set2)
            set3 = abs(set1 - set2);
            set4 = abs(set1) + abs(set2);
            result = sum(set3 ./ set4);
        end
        
        function result = mahalanobisDistance(dataset, vector)
            % S - covariance matrix
            S = cov(dataset);
            sub_ = (vector' - mean(dataset)');
            
            % formula
            squared = sub_' * pinv(S) * sub_;
            result = sqrt(squared);
        end
        
        function distance = mahalanobisDistanceSquared(point1, point2, points)
            S = cov(points);
            
            sub_ = (point1' - point2');
            distance = sqrt(sub_' * pinv(S) * sub_);
        end
        
        function distance = cosineDistance(rndVector1, rndVector2)
            vectorMultiplication = sum(rndVector1 .* rndVector2);
            similarity = vectorMultiplication / sqrt((sum(rndVector1 .^ 2) * sum(rndVector2 .^ 2)));
            % cosine distance - not a proper distance metric as it does not have the triangle inequality
            distance = 1 - similarity;
            
            % angular distance
            % distance = acos(similarity) / pi;
        end
    end
end

