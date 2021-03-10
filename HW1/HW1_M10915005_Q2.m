%clear window
close all, clear, clc

%input the size of the gaussian filter
n=3;
n=input('please enter the size of filter:');

%read the image
gray_image=imread('ntust_gray.jpg');
%define the size of image x,y
[x,y]=size(gray_image);

%show the original image
figure(1)
imshow(gray_image),title('original image');

%change image value uint8 to double
trans=im2double(gray_image);

%create a gaussian filter to smoothing picture(sigma=2)
smoothimg=gaussian_filter(trans,n,2);
%show the smoothing picture after using gaussian filter
figure(2)
imshow(uint8(smoothimg*255)),title('smoothing');

%compute the USM result
result1=0.8*(trans-smoothimg)+trans;
%show the USM result
figure(3)
imshow(uint8(result1*255)),title('sharp');

%gaussian filter
function result=gaussian_filter(image,kernelsize,sigma)
    kernel=zeros(kernelsize);%initialize kernel
    temp=fix(kernelsize/2)+1;%compute the value need to shift index(beacuse the center of kernel is (0,0))
    %using gaussian filter formula to compute the matrix according to different filter size n 
    for i=1:kernelsize
        for j=1:kernelsize
            x=double(i-temp);
            y=double(j-temp);
            kernel(i,j)=(exp(-(x^2+y^2)/(2*sigma^2)))/(2*pi*sigma^2);
        end
    end
     kernel=kernel/sum(kernel(:));
    %adjust to the sum of kernel is 0(normalization)
    result=conv2(image,kernel,'same');%return output
end
