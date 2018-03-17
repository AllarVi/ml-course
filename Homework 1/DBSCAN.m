classdef DBSCAN
    methods(Static)
        function neighbors = RangeQuery(DB, point, eps)
            neighbors = Point.empty;
            neighborIDX = 1;
            for pointIDX = 1:length(DB)
                % points = [point.position; DB(pointIDX).position]; % for
                % mahalanobis squared
                if MetricFunction.canberraDistance(point.position, DB(pointIDX).position) <= eps
                    neighbors(neighborIDX) = DB(pointIDX);
                    neighborIDX = neighborIDX + 1;
                end
            end
        end
         
        function [DB, C] = execute(DB, eps, minPts)
            C = 0; % Cluster counter
            for pointIDX = 1:length(DB)
                fprintf('pointIDX: %f \n', pointIDX);
                point = DB(pointIDX);
                
                if point.label ~= 0 % Previously processed in inner loop
                    continue;
                end
                
                neighbors = DBSCAN.RangeQuery(DB, point, eps); % Find neighbors
                fprintf('neighbors: %0.1f \n', length(neighbors));
                if length(neighbors) < minPts
                    DB(pointIDX).label = -1; % Label as Noise
                    continue;
                end
                C = C + 1; % next cluster label
                DB(pointIDX).label = C; % Label initial point
                
                mask = arrayfun(@(x) ~isequal(x.position, DB(pointIDX).position), neighbors);
                seedSet = neighbors(mask); % Neighbors to expand
                
                seedPointIDX = 1;
                
                fprintf('seedSet length to proc: %0.1f \n', length(seedSet));
                while seedPointIDX <= length(seedSet) % Process every seed point
                    % fprintf('seed: %0.1f \n', seedPointIDX);
                    seedPoint = seedSet(seedPointIDX);
                    seedPointIDX = seedPointIDX + 1;
                    seedPoint = DB(seedPoint.index);
                    
                    % fprintf('seedPoint index: %0.1f \n', seedPoint.index);

                    if seedPoint.label == -1
                        DB(seedPoint.index).label = C; % Change Noise to border point
                    end
                    
                    if seedPoint.label ~= 0 % Previously processed
                        continue;
                    end
                    
                    DB(seedPoint.index).label = C; % Label neighbor
                    seedNeighbors = DBSCAN.RangeQuery(DB, seedPoint, eps);
                    if length(seedNeighbors) >= minPts
                        seedSet = [seedSet, seedNeighbors]; % Add new neighbors to seed set
                    end
                end
            end
        end
        
    end
end