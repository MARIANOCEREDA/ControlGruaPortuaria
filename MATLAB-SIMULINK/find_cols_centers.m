function [centers] = find_cols_centers(step,delta,n_cols)
    centers = [];
    for i=1:n_cols
        centers(1,i)= 2*step*i+delta-step;
    end
end
