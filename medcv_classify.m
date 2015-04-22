% function [choice] = classify(test_dist, true_dists, false_dists, method)
function [t, f] = classify(test_dist, true_dists, false_dists, method)

	% Test the divergence between test_dist, true_dists, and false_dists
	% Return true is the distribution to which test_dist has the minimum divergence is in true_dists
	% TRY: Implementing a percentile approach (Which group has MORE near-matches vs which has the single minimum)
	if nargin < 4
		method = 'cdf'
	end

	choice = false;
	best_match = 0.0;

	tdists = zeros(1, length(true_dists));
	for k = 1:length(true_dists)
		dist = medcv_divergence(test_dist, true_dists{k}, method);
		if dist == 0
			% Ignore it if it is the same
			continue;
		end
		tdists(k) = dist;
	end

	fdists = zeros(1, length(false_dists));
	for k = 1:length(false_dists)
		dist = medcv_divergence(test_dist, false_dists{k}, method);
		fdists(k) = dist;
	end


	min(tdists)
	min(fdists)
	t = sum(tdists < 1.4 * min(tdists))
	f = sum(fdists < 1.4 * min(fdists))

	% if min(tdists) < min(fdists)
	% 	choice = true;
	% else
	% 	choice = false;
end