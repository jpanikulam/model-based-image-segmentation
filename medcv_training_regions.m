function [distributions] = get_training_distributions(image, true_mask)
% Generate training distributions using a truth mask from the gold standard dataset
% Find regions of more than 80% truth and take those as what we want
% Altly, take random subsections of vasculature and treat those as training elements
% TO run...
% dists = medcv_training_regions(set{1,2}, set{2, 1});

if size(image, 3) == 3
	image = image(:, :, 2);
end

image = imresize(image, 0.25, 'nearest');
im_binary = imresize(true_mask, 0.25);

block_image = cat(3, image, im_binary);

positive = @(block_struct) get_positive_distribution(block_struct.data);
positive_distributions = blockproc(block_image, [100, 100], positive);

% negative = @(block_struct) get_negtaive_distribution(block_struct.data);
% negative_distributions = blockproc(block_image, [100, 100], negative);

distributions = positive_distributions;

end

function [cleaned] = clean_distribution(B)
	for k = 1:length(B)
		col = B(:, k);

	end
end

function [B] = get_positive_distribution(input_image)
	% The input is a two layer image, where (:, :, 1) is the image, 
	% and (:, :, 2) is the binary 

	% tabulation = tabulate(image(:));
	image = input_image(:, :, 1);
	im_binary = logical(input_image(:, :, 2));
	% if sum(im_binary) < 10
	% 	B = NaN([1, 255])';
	% 	return;
	% end

	allowed = image(im_binary);
	B = hist(allowed, 1:255)';
	% B = hist(image(:), 1:255);
	imshow(image);
end

function [B] = get_negative_distribution(input_image)
	% The input is a two layer image, where (:, :, 1) is the image, 
	% and (:, :, 2) is the binary 

	image = input_image(:, :, 1);
	im_binary = logical(input_image(:, :, 2));

	if sum(~im_binary) < 10
		B = NaN([1, 255]);
		return;
	elseif sum(image) < 50
		% In case it is a black region
		B = NaN([1, 255]);
		return;
	end
	allowed = image(~im_binary);
	B = hist(allowed, 1:255);
	imshow(image);
end