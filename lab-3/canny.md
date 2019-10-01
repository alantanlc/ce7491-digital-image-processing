# Canny Edge Detection

## Short introduction
Canny edge detection is the edge detection technique in image processing. It is notable that with the non-maximal suppression and hysteresis thresholding, this method performs well in both **noise processing** and **edge positioning**.

## More details
Canny algorithm can be divided into the steps below (from step 0 to step 5). There are resultant images in each step.

#### Step 0: Select an input image

#### Step 1: Convert the input image to grayscale image.
As for the RGB image, it needs to be converted to grayscale image first. There are two common conversion formulas, and we prefer to use the second one. It is found that human are sensitive to different colors, where green is the most sensitive color to humans and blue is the least sensitive color to humans. Therefore, the second conversion will perform a better result.

    Gray = (Red + Green + Blue) / 3

    Gray = 0.299 * Red + 0.587 * Green + 0.114 * Blue

#### Step 2: Noise removal
Apply Gaussian filter to remove noise effectively, and also make the image more smooth. Here is the 3x3 filter.

    int Gaussian[3][3] = {
        1/16, 2/16, 1/16,
        2/16, 4/16, 2/16,
        1/16, 2/16, 1/16
    }

#### Step 3: Sobel filter (basic edge detection)
Apply the Sobel operator (sobelx and sobely) to do the basic edge detection.

    int sobelx[3][3] = {
        -1, 0, 1,
        -2, 0, 2,
        -1, 0, 1
    }

    int sobely[3][3] = {
        -1, -2, -1,
         0,  0,  0,
         1,  2,  1
    }

Calculate the horizontal magnitude Gx by convoluting sobelx with the second-step-resultant-image.

Calculate the vertical magnitude Gy by convoluting sobely with the second-step-resultant-image.

Use the following two formulas to obtain gradient direction (Dir) and gradient magnitude (Mag).

    Dir = arctan(Gy/Gx);

    Mag = sqrt(Gy*Gy+Gx*Gx);

Dir is classified into one of the four categories (0,45,90,135 degrees), where 0~22.5 and 157.5~180 degree are in 0-degree-category, 22.5~67.5 degress are in 45-degree-category, 67.5~112.5 degrees are in 90-degree category, and 112.5~157.5 degrees are in 135-degree-category.

As we can see that there are thick edges in the resultant image.

(image)

#### Step 4: Non-maximal suppression (edge thinning)
The edges are usually in high gradient magnitude regions. Following the gradient direction (Dir), we select the dominant edges in their neighborhood (from n1 to n8). That is, if the current pixel value (px) is not the maximal value among their neighbors, then we set the value to zero (discard the pixel). For example, Dir is 45 degrees, so that we have to check if px>n3 and px>n6. It is what non-maximal suppression do. Obviously, there are great improvements in terms of the edge processing.

    n1 n2 n3
    n4 px p5
    n6 n7 n8

#### Step 5: Hysterisis threshold (edge connection)
There are two threshold values, which are the upper bound (TH) and the lower bound (TL). Compare with the single threshold, it won't depict too much fake edges like the resultant image in third step.

Follows the three rules below. Consider that a weak edge (TL < px < TH) is between two strong edges (px > TH). If we discard the weak edge, then there will be a disconnection between strong edges. It is what the third rule aims to do -- detect weak edge and connect with strong edges.

    if (pixel value < TL), then discard it.

    if (pixel value > TH), then label it as edge.

    if (TL < pixel value < TH) and there are at least one neighbor(s) where pixel value > TH, then label it as edge.

    Note that using higher threshold might miss some important information (edge disconnection), while applying lower threshold will keep more irrelevant information (thick edges).