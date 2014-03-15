function outputImage = edge_sobel(inputImage)

iSobelX =   [-1 0 1;
            -2 0 2;
            -1 0 1];
iSobelY =   [1  2  1;
             0  0  0;
            -1 -2 -1];

% convert it into double type
inputImage = double(inputImage);

imgX = conv2(inputImage, iSobelX);
imgY = conv2(inputImage, iSobelY);
outputImage = abs(imgX) + abs(imgY);

end
