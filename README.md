# 🪙 Euro Coin Counting Project 📸

## Digital Image Processing and Analysis Project

Welcome to the Euro Coin Counting Project! This project represents the final assignment for the Digital Image Processing and Analysis course during the first semester of the iPSRS program. The primary aim is to employ digital image processing techniques to identify, classify, and count Euro coins from a given image.

### Project Overview

The Euro Coin Counting Project involves several key steps:

1. **Image Loading and Preprocessing 🖼️:**
   - Load the grayscale image from the 'images/train' directory.
   - Apply top-hat transformation to enhance image features.

2. **Watershed Segmentation 💧:**
   - Utilize watershed segmentation to identify different regions in the preprocessed image.

3. **Connected Component Labeling 🏷️:**
   - Label connected components and compute properties.

4. **Coin Classification and Counting 💰:**
   - Classify each connected component based on its diameter, determining the type of Euro coin.
   - Generate counts and a summary table, including the total amount of money in Euros.

5. **Visualization 📊:**
   - Display the original image with labeled circles representing each coin.
   - Show the total amount of money as a title.
