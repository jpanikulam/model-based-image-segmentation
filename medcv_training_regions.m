function [positive_distributions, negative_distributions] = get_training_distributions(image, true_mask)
% Generate training distributions using a truth mask from the gold standard dataset
% Crawl through the downsampled image, and grab squares of the image
% TO run...
% dists = medcv_training_regions(set{1,2}, set{2, 1});

if size(image, 3) == 3
	image = image(:, :, 2);
end

image = imresize(image, 1, 'nearest');
im_binary = imresize(true_mask, 1);

block_image = cat(3, image, im_binary);

positive_func = @(block) get_positive_distribution(block);
positive_distributions = medcv_chunk_proc(block_image, 10, positive_func);

negative_func = @(block) get_negative_distribution(block);
negative_distributions = medcv_chunk_proc(block_image, 10, negative_func);

end

function [B] = get_positive_distribution(input_image)
	% The input is a two layer image, where (:, :, 1) is the image, 
	% and (:, :, 2) is the binary 

	image = input_image(:, :, 1);
	im_binary = logical(input_image(:, :, 2));

	if sum(im_binary) < 10
		B = [];
		return;
	end
	cc = bwconncomp(im_binary);
	allowed_regions = cc.PixelIdxList;
	B = {};
	for region_number = 1:length(allowed_regions)
		allowed = image(allowed_regions{region_number});
		if length(allowed) < 10
			tabulated = [];
		else
			tabulated = medcv_compute_distribution(allowed, 1:255);
		end
		B = [B, tabulated];
	end
end

function [B] = get_negative_distribution(input_image)
	% The input is a two layer image, where (:, :, 1) is the image, 
	% and (:, :, 2) is the binary 

	image = input_image(:, :, 1);
	im_binary = logical(input_image(:, :, 2));

	if sum(~im_binary) < 10
		B = [];
		return;
	elseif sum(image) < 50
		% In case it is a black region
		disp('all black')
		B = [];
		return;
	end
	allowed = image(~im_binary);
	B = medcv_compute_distribution(allowed, 1:255);
end