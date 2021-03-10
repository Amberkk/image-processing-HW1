%clear window
close all, clear, clc

%read image
gray_image=imread('ntust_gray.jpg');

%define image size x,y
[x,y]=size(gray_image);

%show original image
figure(1)
imshow(gray_image),title('original image');

%change image value uint8 to double
trans=im2double(gray_image);

%define sobel and binarize matrix
sobel_result=trans;
binary_result=trans;

%padding the picture 0 
for i = 1:x   
    for j = 1:y 
        binary_result(i,j)=0;
    end
end

%compute sobel
for i = 2:x - 1  
    for j = 2:y - 1
        %horizotal filter
        tmp_x = -trans(i-1,j-1) - 2*trans(i-1,j) - trans(i-1,j+1)+ trans(i+1,j-1) + 2*trans(i+1,j) + trans(i+1,j+1) ;
        %vertical filter
        tmp_y = -trans(i-1,j-1) - 2*trans(i,j-1) - trans(i+1,j-1)+trans(i-1,j+1) + 2*trans(i,j+1) + trans(i+1,j+1)  ;
        %compute the value for relief
        sobel_result(i,j) = tmp_x + tmp_y +0.5; 
        %compute the new x,y absolute value
        tmp_x=abs(tmp_x);
        tmp_y=abs(tmp_y);
        %setting threshold,and binarization
        if tmp_x>0.5 |  tmp_y>0.5 
           binary_result(i,j)=binary_result(i,j)+1;
        end
    end
end 
%show the relief picture
figure(2)
imshow(sobel_result),title('sobel');
%show the binarization picture
figure(3)
imshow(binary_result),title('binary');

%adjust the value from double to uint8
binary=uint8(255*binary_result);
%show the binarization picture and save it
figure(4)
imshow(binary),title('result');
saveas(figure(4),'result.jpg')

