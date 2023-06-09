#!/bin/bash

# Set the paths for Image Folder and the three target folders
image_folder_path="/content/images"
train_image_path="/content/train_images"
val_image_path="/content/val_images"
test_image_path="/content/test_images"
# Set the paths for Mask Folder and the three target folders
mask_folder_path="/content/annotations/trimaps"
train_mask_path="/content/train_masks"
val_mask_path="/content/val_masks"
test_mask_path="/content/test_masks"

# Create the target folders if they don't exist
mkdir -p "$train_image_path"
mkdir -p "$val_image_path"
mkdir -p "$test_image_path"
mkdir -p "$train_mask_path"
mkdir -p "$val_mask_path"
mkdir -p "$test_mask_path"

# Set the split ratios (adjust these values as per your requirements)
train_ratio=0.25
val_ratio=0.25
test_ratio=0.5

# Get the total number of files in Image Folder
total_files=$(ls "$image_folder_path" | wc -l)

# Calculate the number of files for each split
train_files=$(awk "BEGIN {printf \"%.0f\n\", $train_ratio * $total_files}")
val_files=$(awk "BEGIN {printf \"%.0f\n\", $val_ratio * $total_files}")
test_files=$(awk "BEGIN {printf \"%.0f\n\", $test_ratio * $total_files}")

# Move files from Image Folder to the train folder
ls "$image_folder_path" | shuf -n $train_files | xargs -I {} mv "$image_folder_path/{}" "$train_image_path"

# Move files from Folder A to the val folder
ls "$image_folder_path" | shuf -n $val_files | xargs -I {} mv "$image_folder_path/{}" "$val_image_path"

# Move the remaining files from Folder A to the test folder
mv "$image_folder_path"/* "$test_image_path"

echo "Image Files divided successfully!"

# Loop through the image files in the train folder
for image_file in "$train_image_path"/*.jpg; do
    image_filename=$(basename "$image_file" .jpg)
    # Move the label file with the same name and ".png" extension to the target folder
    mv "$mask_folder_path/$image_filename.png" "$train_mask_path"
done

# Loop through the image files in the valid folder
for image_file in "$val_image_path"/*.jpg; do
    image_filename=$(basename "$image_file" .jpg)
    # Move the label file with the same name and ".png" extension to the target folder
    mv "$mask_folder_path/$image_filename.png" "$val_mask_path"
done

# Loop through the image files in the test folder
for image_file in "$test_image_path"/*.jpg; do
    image_filename=$(basename "$image_file" .jpg)
    # Move the label file with the same name and ".png" extension to the target folder
    mv "$mask_folder_path/$image_filename.png" "$test_mask_path"
done
echo "Mask files moved successfully!"
