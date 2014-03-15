function [ outputImage ] = edge_prewitt( inputImage )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

iPrewittX = [ -1 0 1;
              -1 0 1;
              -1 0 1];
iPrewittY = [ 1  1  1;
              0  0  0;
             -1 -1 -1];
         
% convert it into double type
inputImage = double(inputImage);

imgX = conv2(inputImage, iPrewittX);
imgY = conv2(inputImage, iPrewittY);
outputImage = abs(imgX) + abs(imgY);


end

