function [result] = chunk_proc(image, chunksize, func)
    % Process the image in chunks using func and return a cell array of the results
    % chunksize must be a single scalar

    cells = cell()

    im_size = size(image)
    iterations = min(im_size) / chunksize;

    cellnum = 1;

    for x = 1:iterations
        for y = 1:iterations
            x_pos = x * chunksize;
            y_pos = y * chunksize;
            sub_image = image(x_pos: x_pos + chunksize, y_pos: y_pos + chunksize);
            func_result = func(sub_image);
            if func_result ~= []
                % If our function did not find anything meaningful, don't add anything to the cellarray
                cells{cellnum} = func_result;
                cellnum = cellnum + 1;
            end
        end
    end
    result = cells

end
