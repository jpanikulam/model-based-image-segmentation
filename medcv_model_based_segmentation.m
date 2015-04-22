function [segmented] = mbs(image, true_mask)
	% To try: Segment only a small section of a major image
	image = image(:, :, 2);
	imshow(image);
	[image, crop_range] = imcrop;

	% image = image(310:456, 1965: 2191);
	% true_mask = true_mask(310:456, 1965:2191);
	true_mask = imcrop(true_mask, crop_range);
	[true_dists,  false_dists] = medcv_training_regions(image, true_mask);

	block_image = imresize(image, 1., 'nearest');

	do_region_func = @(block_struct) do_region(block_struct.data, true_dists, false_dists);
	processed = blockproc(block_image, [10, 10], do_region_func);
	segmented = processed(:, :, 1);
	figure, imshow(segmented * 255)
	title('segmented')

	figure, imshow(cat(3, true_mask & ~segmented, segmented, segmented & ~true_mask) * 255)
	title('Error visualization')
end


function [B] = do_region(block, true_dists, false_dists)

	distribution = medcv_compute_distribution(block(:), 1:255);
	% disp('---')
	% classification = medcv_classify(distribution, true_dists, false_dists, 'cdf');
	[t, f] = medcv_classify(distribution, true_dists, false_dists, 'js');

	% B = ones(size(block)) .* classification;
	oneified = ones(size(block, 1), size(block, 2));
	B = uint8(cat(3, oneified * t, oneified * f, oneified .* 0));

end