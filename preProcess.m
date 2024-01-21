function imPreProcessed = preProcess(originalRGB)
    % Convert the original RGB image to grayscale
    originalGray = rgb2gray(originalRGB);
    % figure; imshow(originalGray); title('Original Gray')
 
    % Apply top-hat transformation using a disk-shaped structuring element
    imTopHat = imtophat(originalGray, strel("disk", 95));
    % figure; imshow(imTopHat); title('Tophated (Disk Radius: 95)')

    % Binarize the image and perform morphological operations
    imBinary = imbinarize(imTopHat, graythresh(imTopHat));
    % figure; imshow(imBinary); title('Thresholded (Otsu)')

    imClosed = imclose(imBinary, strel("disk", 4));
    % figure; imshow(imClosed); title('Closed (Disk Radius: 4)')

    % Fill the holes in the binary image
    imFilled = imfill(imClosed, 'holes');
    % figure; imshow(imFilled); title('Filled')

    imPreProcessed = imFilled;
end