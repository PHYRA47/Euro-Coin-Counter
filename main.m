clear; close all; clc;

% Read the grayscale image and perform top-hat transformation
originalRGB = imread('images\train\euros1.bmp');
originalGray = rgb2gray(originalRGB); 

figure; imshow(originalGray); title('Original Gray')

% Preprocess the image
imPreProcessed = preProcess(originalRGB);
figure; imshow(imPreProcessed); title('Preprocessed')

% Perform watershed segmentation
imSegmented = watershedSegmentation(imPreProcessed);
figure; imshow(imSegmented); title('Watershed Segmented')

% Label connected components and compute properties
[connectedComponents, TotalCoins] = bwlabel(imSegmented);
figure; imshow(connectedComponents); title('Labeled')

imLabeledRGB = label2rgb(connectedComponents, 'lines', 'white', 'shuffle');
figure; imshow(imLabeledRGB); title('Labeled RGB')

% Get centroids of labeled regions
centroids = getCentroids(connectedComponents);

% Get diameters of labeled regions
diametersOfRegions = getDiameters(connectedComponents);

% Constants for coin diameters (in millimeters)
diameter2Euro = 64; 
diameter1Euro = 57.8;
diameter50Cent = 59.8;
diameter20Cent = 55;
diameter10Cent = 48.8;
diameter5Cent = 52.6;
diameter2Cent = 46.7;
diameter1Cent = 40;

lengthTolerance = 0.8;

% Discriminate coins based on diameter
detectedCoins = zeros(size(diametersOfRegions));  
count2Euro = 0; count1Euro = 0; count50Cent = 0; count20Cent = 0;
count10Cent = 0; count5Cent = 0; count2Cent = 0; count1Cent = 0; 

for i = 1:length(diametersOfRegions)
    if abs(diametersOfRegions(i) - diameter2Euro) < lengthTolerance
        detectedCoins(i) = 2;
        count2Euro = count2Euro + 1;
    elseif (abs(diametersOfRegions(i) - diameter1Euro) < lengthTolerance) 
        detectedCoins(i) = 1;
        count1Euro = count1Euro + 1; 
    elseif (abs(diametersOfRegions(i) - diameter50Cent) < lengthTolerance) 
        detectedCoins(i) = 0.5;
        count50Cent = count50Cent + 1;
    elseif abs(diametersOfRegions(i) - diameter20Cent) < lengthTolerance
        detectedCoins(i) = 0.2;
        count20Cent = count20Cent + 1;
    elseif abs(diametersOfRegions(i) - diameter10Cent) < lengthTolerance
        detectedCoins(i) = 0.1;
        count10Cent = count10Cent + 1;
    elseif abs(diametersOfRegions(i) - diameter5Cent) < lengthTolerance
        detectedCoins(i) = 0.05;
        count5Cent = count5Cent + 1;
    elseif abs(diametersOfRegions(i) - diameter2Cent) < lengthTolerance
        detectedCoins(i) = 0.02;
        count2Cent = count2Cent + 1;
    elseif abs(diametersOfRegions(i) - diameter1Cent) < lengthTolerance
        detectedCoins(i) = 0.01;
        count1Cent = count1Cent + 1;
    else
        detectedCoins(i) = NaN; % Unrecognized coin
    end
end

% Create a table with counts of different coin types
coinCountsTable = table(count2Euro, count1Euro, count50Cent, count20Cent, count10Cent, count5Cent, count2Cent, count1Cent, TotalCoins);

% Calculate the total amount of money
totalAmountOfEuros = (count2Euro * 200 + count1Euro * 100 + count50Cent * 50 + count20Cent * 20 + count10Cent * 10 + count5Cent * 5 + count2Cent * 2 + count1Cent * 1) / 100;

% Display the total amount of money
coinSummaryTable = table(count2Euro, count1Euro, count50Cent, count20Cent, count10Cent, count5Cent, count2Cent, count1Cent, TotalCoins);
disp(coinSummaryTable);
disp(["Total Amount of money: ", num2str(totalAmountOfEuros), " €"]);

% Create a vector of numbers for visualization
number = 1:size(diametersOfRegions);

% Display the original image with labeled circles and coin values
figure('WindowState', 'normal');
imshow(originalRGB);
title(sprintf("Total Amount of money in €:  %.2f", totalAmountOfEuros));
viscircles(centroids, diametersOfRegions./2, 'Color', 'cyan');
hold on;
% text(centroids(:, 1), centroids(:, 2), ...
%     [num2str(detectedCoins(:))], ...
%     'color', 'k', ...
%     'BackgroundColor','white', ...
%     'FontSize', 6, ...
%     'FontWeight', 'bold');
hold off;