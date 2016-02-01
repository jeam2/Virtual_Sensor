%videopath = 'C:\Users\joao_erik\Google Drive\UFPE\Mestrado\Virtual_Sensor_Algoritmo_MATLAB\video1.wmv';
% v = VideoReader(videopath);
% numFrames = v.NumberOfFrames;
% vidHeight = v.Height;
% vidWidth = v.Width;

% s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
%     'colormap',[]);
% 
% implay(videopath); %play video
% 
% display 'reading frames...';
% for k = 1 : numFrames
%     s(k).cdata = read(v,k);
% end
% display 'All frames read';

%Defining template: T(x,y)
% Template = s(1).cdata; %first frame


imagepath = 'C:\Users\joao_erik\Google Drive\UFPE\Mestrado\Virtual_Sensor_Algoritmo_MATLAB\people.jpg';
imagepath2 = 'C:\Users\joao_erik\Google Drive\UFPE\Mestrado\Virtual_Sensor_Algoritmo_MATLAB\people.jpg';

Template = imread(imagepath);
%imshow(Template);

%Getting template dimentions
template_width = size(Template,1);
template_height = size(Template,2);

% ==> Image1 = s(2).cdata; %second frame as a image 


Image1 = imread(imagepath2);
%Rotating image
Image1 = imrotate(Image1, 5);
%Resizing image: changig scale
%Image1 = imresize(Image1, [template_height*1.5 template_width*0.8]);
%figure, imshow(Image1);

figure;
subplot(1,2,1);
imshow(Template);
subplot(1,2,2);
imshow(Image1);

image_width = size(Image1,1);
image_height = size(Image1,2);




%Derivating center point of the Template T(x,y)
xc = ceil(template_width/2);
yc = ceil(template_height/2);

template_width
xc


%Derivating center point of the Sub scene Ts(x,y)
xc_im = ceil(image_width/2);
yc_im = ceil(image_height/2);

%===========================
% Ring Projection Algorithm
%===========================

%Maximum radius of polar frame coordanates of template
R_template = min(template_height, template_width);

R_image = min(image_height, image_width); 


%=============
% Create a radius lookup table for each pixel
%=============
% Table will contain the distance of each pixel to the center of image

radius_table = zeros(template_width, template_height); %Create lookup table with zeros
radius_table_im = zeros(image_width, image_height); %Create lookup table with zeros

for y = 1 : template_width
    for x = 1 : template_height
        radius_table(y,x) = int16(sqrt((x-xc)^2 + (y-yc)^2)+0.5);
        %radius_table(y,x)
    end
end
display 'r calculated.';



for y = 1 : image_width
    for x = 1 : image_height
        radius_table_im(y,x) = int16(sqrt((x-xc_im)^2 + (y-yc_im)^2)+0.5);
    end
end



Pt = zeros(2,max(max(radius_table))); % array 2D: 1st dimension is  
                                      % RPT of the Template and 2sd  
                                      % dimension will contain the total
                                      % number of pixels in the specific
                                      %  radius of tamplate
        %max(r) return the max values of each column of 'r'. 
        %max(max(r)) return the max of the max values of each column of 'r'


Ps = zeros(2,max(max(radius_table_im)));  


                           
%Scan the whole image and sum pixel values in each radius r

% Image1 
display 'Computing projection...';

%=================================================
% Compute a circular projection of the image within the template
%=================================================
% Each position of Pt array is the sum of all pixels values along a
% concentric circle
for y = 1 : template_width
    for x = 1 : template_height
        Pt(2,radius_table(y,x)) = Pt(2,radius_table(y,x)) + 1; %increasing the 
                         % total number of pixels falling on the circle of 
                         % radius 'radius_table(y,x)'
        Pt(1,radius_table(y,x)) = (Pt(1,radius_table(y,x))+ Template(y,x))/Pt(2,radius_table(y,x));
        
        % get the mean of pixels values on the same circle
    end
end


for y = 1 : image_width
    for x = 1 : image_height 
        Ps(2,radius_table_im(y,x)) = Ps(2,radius_table_im(y,x)) + 1;
        Ps(1,radius_table_im(y,x)) = (Ps(1,radius_table_im(y,x))+ Image1(y,x))/Ps(2,radius_table_im(y,x));
    end
end

display 'Projection done';

display 'Ploting PT vector';
% Range of radius to plot the Ring Template Projection (RTP)
max_radius = max(max(radius_table));
min_radius = min(min(radius_table));

x_radius = min_radius:max_radius;

max_radius_im = max(max(radius_table_im));
min_radius_im = min(min(radius_table_im));

x_radius_im = min_radius_im:max_radius_im;

%Ploting RTP x Radium
figure;
subplot(1,2,1);
plot(x_radius,Pt(1,:));
display 'Ploting PS vector';
subplot(1,2,2);
plot(x_radius_im,Ps(1,:));



%=============================
% NORMALIZED CROSS CORRELATION: C = normxcorr2(template, A)
% ref: http://www.mathworks.com/help/images/ref/normxcorr2.html?refresh=true
%=============================
% C = normxcorr2(template, A) computes the normalized cross-correlation of the matrices template and A. 
%The matrix A must be larger than the matrix template for the normalization
%to be meaningful. The values of template cannot all be the same. 
%The resulting matrix C contains the correlation coefficients, which can 
%range in value from -1.0 to 1.0.


 %** Example: http://www.mathworks.com/help/images/ref/normxcorr2.html?refresh=true
    %Use cross-correlation to find template in image:
 
 
    
 
 


