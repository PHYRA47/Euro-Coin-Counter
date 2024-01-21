function centroids = getCentroids(labeledImage)
    % Compute region properties
    regionProps = regionprops(labeledImage, "Centroid");

    % Extract centroid information
    centroids = cat(1, regionProps.Centroid);
end