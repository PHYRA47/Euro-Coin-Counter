function diameters = getDiameters(labeledImage)
    % Compute region properties
    regionProps = regionprops("table", labeledImage, "MajorAxisLength", "MinorAxisLength");
    
    majorAxis = regionProps.MajorAxisLength;
    minorAxis = regionProps.MinorAxisLength;

    % Extract diameter information
    diameters = mean([majorAxis, minorAxis], 2);
end