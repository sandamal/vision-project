function outputImage = filter_alpha_trimmed_mean(inputImage,mask,colorType)


if strcmp(colorType,'truecolor')
    %The image is a colour image-------------------------------------------
    %convert it to black and white
    inputImage = rgb2gray(inputImage);
end
inputImage=im2double(inputImage);

% Specifications of the filter
d=4;

[row col]=size(inputImage);
temp1=[];
graber=0;
accumulator=[];

% Main Module for Alpha Trimmed Mean Filter
for i=1:row;
    for j=1:col;
        for m=-mask:mask;
            for n=-mask:mask;
                if (i+m>0 && i+m<row && j+n>0 && j+n<col && ...      % To keep indices in limit
                        mask+m>0 && mask+m<row && ...
                        mask+n>0 && mask+n<col)
                    
                    temp1=[temp1 inputImage(i+m,j+n)];
                    
                end
            end
        end
        
        temp1=sort(temp1);
        lenth=length(temp1);
        for k=((d/2)-1):(lenth-(d/2))
            accumulator=[accumulator temp1(k)];
        end
        accumulator=sum(accumulator);
        reformedimage(i,j)=(accumulator) / (25-d);
        
        accumulator=[];
        temp1=[];
        
    end
end

outputImage = reformedimage;

end
