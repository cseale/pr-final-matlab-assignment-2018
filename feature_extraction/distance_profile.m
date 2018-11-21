function dist_profile = distance_profile(i)

% first count from top and zero out rows where there are no non-zero value
[sel_top, ind_top] = max(i, [], 1);
results_top = sel_top .* ind_top;

% distance profile from bottom
[sel_bottom, ind_bottom] = max(flip(i), [], 1);
results_bottom = sel_bottom .* ind_bottom;

% distance profile from left
[sel_left, ind_left] = max(i, [], 2);
results_left = (sel_left .* ind_left)';

% distance profile from right
[sel_right, ind_right] = max(flip(i, 2), [], 2);
results_right = (sel_right .* ind_right)';

% create resulting distance profile
dist_profile = [results_top results_left results_bottom results_right];

end

