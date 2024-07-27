# Data Description
Breast cancer is cancer that develops from breast tissue. In this dataset, we provide attributes of images of a fine needle aspirate (FNA) of a breast mass. They describe the characteristics of the cell nuclei present in the image. 5% of the labels (column 1) of this dataset has been randomly picked and changed from their actual label ('B' to 'M' and 'M' to 'B'). The indices (starting from 0) of these changed rows have been provided inside the "changed_label_row_inds.npy" file.

# Attribute Information
- Column 2-31 can all be used as model input features (all features are continuous)
- Column 1 denotes "diagnosis" which is the label to be predicted
- Total 569 samples -> (1) 212 malignant samples (denoted by 'M') and (2) 357 benign samples (denoted by 'B')
- No missing values exist in the dataset
- All the features are derived mainly from 10 measurements:
    a) radius (mean of distances from center to points on the perimeter)
    b) texture (standard deviation of gray-scale values)
    c) perimeter
    d) area
    e) smoothness (local variation in radius lengths)
    f) compactness (perimeter^2 / area - 1.0)
    g) concavity (severity of concave portions of the contour)
    h) concave points (number of concave portions of the contour)
    i) symmetry
    j) fractal dimension ("coastline approximation" - 1)

# Task
- You have to identify the outliers (mislabeled 5% samples) from the dataset using appropriate techniques and visualization
- After detection, you can change the label of these outlier samples and perform the classification task (malignant / benign)
