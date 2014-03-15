function outputImage = filter_median(inputImage,mask)

%PAD THE MATRIX WITH ZEROS ON ALL SIDES
modifiedInput = zeros(size(inputImage)+2);
outputImage = zeros(size(inputImage));

%COPY THE ORIGINAL IMAGE MATRIX TO THE PADDED MATRIX
for x=1:size(inputImage,1)
    for y=1:size(inputImage,2)
        modifiedInput(x+1,y+1)=inputImage(x,y);
    end
end

%LET THE WINDOW BE AN ARRAY
%STORE THE 3-by-3 NEIGHBOUR VALUES IN THE ARRAY
%SORT AND FIND THE MIDDLE ELEMENT


for i= 1:size(modifiedInput,1)-2
    for j=1:size(modifiedInput,2)-2
        window=zeros(mask*mask,1);
        inc=1;
        for x=1:mask
            for y=1:mask
                window(inc)=modifiedInput(i+x-1,j+y-1);
                inc=inc+1;
            end
        end
        
        %PLACE THE MEDIAN ELEMENT IN THE OUTPUT MATRIX
        outputImage(i,j)=median(window);
        
    end
end
%CONVERT THE OUTPUT MATRIX TO 0-255 RANGE IMAGE TYPE
outputImage=uint8(outputImage);
end
