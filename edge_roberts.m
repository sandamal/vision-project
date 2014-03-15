function [ outputImage ] = edge_roberts( inputImage )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

iRobertsX = [1  0;
            0 -1];
iRobertsY = [0 -1;
            1  0];

inputImage = double(inputImage);
        
imgX = conv2(inputImage, iRobertsX);
imgY = conv2(inputImage, iRobertsY);
outputImage = abs(imgX) + abs(imgY);

end

