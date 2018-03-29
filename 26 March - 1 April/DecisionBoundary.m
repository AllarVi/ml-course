function [decision_boundary, out] = DecisionBoundary(D, mdl, step)
    % this function returns surface representing decision boundary between two
    % classes
    
    % this funciton is limited to 2 and 3D cases only
    [~, cols] = size(D);
    
    
    % determine maximums and minimums of D_valid
    D_min = min(D);
    D_max = max(D);
    
    % generate axis
    
    for j = 1:cols
        axis(j).values = D_min(j):step:D_max(j); % generate coordiantes along the dimension
        rows(j) = length(axis(j).values); % lenght of the coordinate vector
    end
    
    out.axis = axis;
    
    switch cols
        case 2
            for i = 1:rows(1)
                for j = 1:rows(2)
                    spaceD(i, j).value = [axis(1).values(i), axis(2).values(j)];
                    labels_hat(i, j) = predict(mdl, spaceD(i, j).value);
                end
            end
        case 3
            for i = 1:rows(1)
                for j = 1:rows(2)
                    for k = 1:rows(3)
                        spaceD(i, j, k).value = [axis(1).values(i), axis(2).values(j), axis(3).values(k)];
                        labels_hat(i, j, k) = predict(mdl, spaceD(i, j, k).value);
                    end
                end
            end
    end
    
    
    out.labels_hat = labels_hat;
    out.spaceD = spaceD;
    
    
    switch cols
        case 2
            k = 0; % this is counter
            [rowsS, colsS] = size(spaceD); % determine size of a new array
            for i = 2:rowsS - 1
                for j = 2:colsS - 1
                    neigbourhood = labels_hat(i-1:i+1, j-1:j+1); % square corresponding to a neighborhood
                    etalon = ones(3, 3) * labels_hat(i, j); % etalon is the the matrix where all elements are identical (no border case)
                    tf = isequal(neigbourhood, etalon); % compare to etalon
                    
                    if tf == 1
                        point_type(i, j) = 0;
                    else
                        point_type(i, j) = 1;
                        k = k + 1;
                        decision_boundary(k, :) = spaceD(i, j).value;
                    end
                    clear neigbourhood etalon tf
                    
                end
            end
            
        case 3
            l = 0;
            [rowsS, colsS, pillS] = size(spaceD); % determine size of a new array
            for i = 2:rowsS - 1
                for j = 2:colsS - 1
                    for k = 2:pillS - 1
                        neigbourhood = labels_hat(i-1:i+1, j-1:j+1, k-1:k+1);
                        etalon = ones(3, 3, 3) * labels_hat(i, j, k);
                        tf = isequal(neigbourhood, etalon);
                        if tf == 1
                            point_type(i, j, k) = 0;
                        else
                            point_type(i, j, k) = 1;
                            l = l + 1;
                            decision_boundary(l, :) = spaceD(i, j, k).value;
                            db_surf(i-1, j-1) = spaceD(i, j, k).value(3);
                        end
                        clear neigbourhood etalon tf
                    end
                end
            end
            out.db_surf = db_surf;
        otherwise
            decision_boundary = 0;
            
    end
    
end
