function get_histogram(inputImage)

[a,b,c]=size(inputImage);
imageSize = a*b;

figure('Name','Image Histogram','NumberTitle','off')

for k=1:c
    %for each colour
    probf=zeros(256,1);
    freq=zeros(256,1);
    
    for i=1:a
        for j=1:b
            value = inputImage(i,j,k);
            freq(value+1)=freq(value+1)+1;
            probf(value+1)=freq(value+1)/imageSize;
        end
    end
    
    h = subplot(c,1,k);
    bar (h,probf);
    xlabel('Intensity');
    ylabel('Probability');
    
    if(c>1)
        if(k==1)
            title('Red');
        elseif(k==2)
            title('Green');
        elseif(k==3)
            title('Blue');
        end
    else
        title('Greyscale');
    end
    
end