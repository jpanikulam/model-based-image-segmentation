function [distance] = divergence(set_1, set_2, method)
	% Determine the Bregman diveregence specified in the string "method" to difference the two distributions
	if nargin < 3
		method = 'cdf'
	end

	if strcmp(method, 'kl')
		distance = kl_divergence(set_1, set_2)
	elseif strcmp(method, 'cdf')
		distance = cdf_distance(set_1, set_2)
	elseif strcmp(method, 'mahalanobis')
		% Does this actually work?
		distance = mahalanobis(set_1, set_2)
	else
		error(['No such method', method])
	end


function [dist] = cdf_distance(set_1, set_2)

end

function [dist] = kl_divergence(set_1, set_2)
	dist = 10
end
