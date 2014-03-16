function outputImage = filter_mean(inputImage,mask,colorType)

kernel = ones(mask, mask) / (mask*mask); % the mean kernel

if strcmp(colorType,'truecolor')
    % Extract the individual red, green, and blue color channels.
    redChannel = inputImage(:, :, 1);
    greenChannel = inputImage(:, :, 2);
    blueChannel = inputImage(:, :, 3);
    
    redOutput = conv2(redChannel, kernel, 'same');
    greenOutput = conv2(greenChannel, kernel, 'same');
    blueOutput = conv2(blueChannel, kernel, 'same');
    outputImage = cat(3, redOutput, greenOutput, blueOutput);
else
    outputImage = conv2(inputImage, kernel, 'same'); % Convolve keeping size of the inputImage
end
    %CONVERT THE OUTPUT MATRIX TO 0-255 RANGE IMAGE TYPE
    outputImage=uint8(outputImage);
end
