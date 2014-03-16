function outputImage = compare_images(firstImage,secondImage)

firstImage = rgb2gray(firstImage);
secondImage = rgb2gray(secondImage);

[a,b]=size(firstImage);

secondImage=imresize(secondImage,[size(firstImage,1) size(firstImage,2)]);

firstImage=uint8(firstImage);
secondImage=uint8(secondImage);
outputImage = zeros(size(firstImage));
    
    for i=1:a
        for j=1:b
            outputImage(i,j,:) =max(firstImage(i,j,:)-secondImage(i,j,:),0);
        end
    end
figure('Name','Image Difference','NumberTitle','off')
imshow(outputImage);
end
