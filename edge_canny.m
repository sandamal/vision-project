function [ outputImage ] = edge_canny(inputImage)

% convert it into double type
inputImage = double(inputImage);

[r c]=size(inputImage);

mod(r,c) = 0;


filter=[2 4 5 4 2;4 9 12 9 4;5 12 15 12 5;4 9 12 9 4;2 4 5 4 2];

for i=1:5
    for j=1:5
        filter(i,j)=filter(i,j)/159;
    end
end

inputImageFiltered = conv2(inputImage, filter);

Mx = [-1 0 1; -2 0 2; -1 0 1]; % Sobel Mask in X-Direction
My = [-1 -2 -1; 0 0 0; 1 2 1]; % Sobel Mask in Y-Direction

inputSobelX = conv2(inputImageFiltered, Mx);
inputSobelY = conv2(inputImageFiltered, My);

for u = 1:r
    for v = 1:c
        mod(u,v) = sqrt(inputSobelX(u,v)^2  +  inputSobelY(u,v)^2) ;
    end
end

modtemp = mod;

for i= 1 : r+2
    for j = 1:c+2
        if(i<=1 || j<=1 || i>=r || j>=c)
            mod(i,j) = 0;
        else 
            mod(i,j) = modtemp(i-1,j-1);
        end;
    end
end

theta(u,v) = 0;
supimg(u,v) = 0;
ntheta(u,v) = 0;

for u = 2 : r
    for v = 2 : c
        theta(u,v) = atand(inputSobelY(u,v)/inputSobelX(u,v));
        
        if ((theta(u,v) > 0 ) && (theta(u,v) < 22.5) || (theta(u,v) > 157.5) && (theta(u,v) < -157.5))
            ntheta(u,v) = 0;
        end
        
        if ((theta(u,v) > 22.5) && (theta(u,v) < 67.5) || (theta(u,v) < -112.5) && (theta(u,v) > -157.5))
            ntheta(u,v) = 45;
        end
        
        if ((theta(u,v) > 67.5 && theta(u,v) < 112.5) || (theta(u,v) < -67.5 && theta(u,v) > 112.5))
            ntheta(u,v) = 90;
        end
        
        if ((theta(u,v) > 112.5 && theta(u,v) <= 157.5) || (theta(u,v) < -22.5 && theta(u,v) > -67.5))
            ntheta(u,v) = 135;
        end
        if (ntheta(u,v) == 0)
            if (mod(u, v) > mod(u, v-1) && mod(u, v) > mod(u, v+1))
                supimg(u,v) = mod(u,v);
            else supimg(u,v) = 0;
            end
        end
        
        if (ntheta(u,v) == 45)
            if (mod(u, v) > mod(u+1, v-1) && mod(u, v) > mod(u-1, v+1))
                supimg(u,v) = mod(u,v);
                
            else supimg(u,v) = 0;
            end
        end
        
        
        if (ntheta(u,v) == 90)
            if (mod(u, v) > mod(u-1, v) && mod(u, v) > mod(u+1, v))
                supimg(u,v) = mod(u,v);
                
            else supimg(u,v) = 0;
            end
        end
        if (ntheta(u,v) == 135)
            if (mod(u, v) > mod(u-1, v-1) && mod(u, v) > mod(u+1, v+1))
                supimg(u,v) = mod(u,v);
                
            else supimg(u,v) = 0;
            end
        end
    end
end

outputImage = supimg;

end

