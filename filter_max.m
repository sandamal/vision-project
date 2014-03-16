function outputImage = filter_max(inputImage,mask,colorType)

%PAD THE MATRIX WITH ZEROS ON ALL SIDES
padding = floor(mask/2);

if strcmp(colorType,'truecolor')
    %The image is a colour image-------------------------------------------
    
    % Extract the individual red, green, and blue color channels.
    redChannel = inputImage(:,:,1);
    greenChannel = inputImage(:,:,2);
    blueChannel = inputImage(:,:,3);
    
    redOutput = zeros(size(redChannel));
    greenOutput = zeros(size(greenChannel));
    blueOutput = zeros(size(blueChannel));
    
    %For the red channel---------------------------------------------------
    
    modifiedRed = zeros(size(redChannel)+padding*2);
    
    %COPY THE ORIGINAL RED IMAGE MATRIX TO THE PADDED MATRIX
    for x=1:size(redChannel,1)
        for y=1:size(redChannel,2)
            modifiedRed(x+padding,y+padding)=redChannel(x,y);
        end
    end
    
    for i= 1:size(modifiedRed,1)-padding*2
        for j=1:size(modifiedRed,2)-padding*2
            window=zeros(mask*mask,1);
            inc=1;
            for x=1:mask
                for y=1:mask
                    window(inc)=modifiedRed(i+x-1,j+y-1);
                    inc=inc+1;
                end
            end
            %PLACE THE MAX ELEMENT IN THE OUTPUT MATRIX
            redOutput(i,j)=max(window);
        end
    end
    
    %For the green channel------------------------------------------------
    
    modifiedGreen = zeros(size(greenChannel)+padding*2);
    
    %COPY THE ORIGINAL GREEN IMAGE MATRIX TO THE PADDED MATRIX
    for x=1:size(greenChannel,1)
        for y=1:size(greenChannel,2)
            modifiedGreen(x+padding,y+padding)=greenChannel(x,y);
        end
    end
    
    for i= 1:size(modifiedGreen,1)-padding*2
        for j=1:size(modifiedGreen,2)-padding*2
            window=zeros(mask*mask,1);
            inc=1;
            for x=1:mask
                for y=1:mask
                    window(inc)=modifiedGreen(i+x-1,j+y-1);
                    inc=inc+1;
                end
            end
            %PLACE THE MAX ELEMENT IN THE OUTPUT MATRIX
            greenOutput(i,j)=max(window);
        end
    end
    
    %For the blue channel------------------------------------------------
    
    modifiedBlue = zeros(size(blueChannel)+padding*2);
    
    %COPY THE ORIGINAL BLUE IMAGE MATRIX TO THE PADDED MATRIX
    for x=1:size(blueChannel,1)
        for y=1:size(blueChannel,2)
            modifiedBlue(x+padding,y+padding)=blueChannel(x,y);
        end
    end
    
    for i= 1:size(modifiedBlue,1)-padding*2
        for j=1:size(modifiedBlue,2)-padding*2
            window=zeros(mask*mask,1);
            inc=1;
            for x=1:mask
                for y=1:mask
                    window(inc)=modifiedBlue(i+x-1,j+y-1);
                    inc=inc+1;
                end
            end
            %PLACE THE MAX ELEMENT IN THE OUTPUT MATRIX
            blueOutput(i,j)=max(window);
        end
    end
    
    %Combine the three channels
    outputImage = cat(3, redOutput, greenOutput, blueOutput);
    
    
    % ---------------------------------------------------------------------
    % ---------------------------------------------------------------------
else
    %The image is a grayscale image
    modifiedInput = zeros(size(inputImage)+padding*2);
    outputImage = zeros(size(inputImage));
    
    %COPY THE ORIGINAL IMAGE MATRIX TO THE PADDED MATRIX
    for x=1:size(inputImage,1)
        for y=1:size(inputImage,2)
            modifiedInput(x+padding,y+padding)=inputImage(x,y);
        end
    end
    
    %LET THE WINDOW BE AN ARRAY
    %STORE THE NEIGHBOUR VALUES IN THE ARRAY
    %SORT AND FIND THE MIDDLE ELEMENT
    
    
    for i= 1:size(modifiedInput,1)-padding*2
        for j=1:size(modifiedInput,2)-padding*2
            window=zeros(mask*mask,1);
            inc=1;
            for x=1:mask
                for y=1:mask
                    window(inc)=modifiedInput(i+x-1,j+y-1);
                    inc=inc+1;
                end
            end
            
            %PLACE THE MAX ELEMENT IN THE OUTPUT MATRIX
            outputImage(i,j)=max(window);
            
        end
    end
end

%CONVERT THE OUTPUT MATRIX TO 0-255 RANGE IMAGE TYPE
outputImage=uint8(outputImage);
end
