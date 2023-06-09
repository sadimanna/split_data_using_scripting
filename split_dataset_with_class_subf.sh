#!/bin/bash

# Set the paths for the train folder, label folder, and target folder
image_folder_path="/path/to/train"
label_folder_path="/path/to/label"
target_train_folder="/path/to/train_split"
target_val_folder="/path/to/val_split"
target_test_folder="/path/to/test_split"

# Create the target folders if they don't exist
mkdir -p "$target_train_folder"
mkdir -p "$target_val_folder"
mkdir -p "$target_test_folder"

# Clear the target folders if they are not empty
rm -rf "$target_train_folder"/*
rm -rf "$target_val_folder"/*
rm -rf "$target_test_folder"/*

# Loop through the class folders in the train folder
for class_folder in "$image_folder_path"/*; do
    # Extract the class name from the class folder path
    class_name=$(basename "$class_folder")
    
    # Create the corresponding class folders in the target folders
    mkdir -p "$target_train_folder/$class_name"
    mkdir -p "$target_val_folder/$class_name"
    mkdir -p "$target_test_folder/$class_name"
    
    # Move the image files to the respective target folders
    find "$class_folder" -type f -name "*.jpg" -exec sh -c '
        # Get the base filename without the extension
        filename=$(basename "$0" .jpg)
        # Generate a random number between 0 and 1
        rand=$(awk "BEGIN{srand(); print rand()}")
        # Decide the split based on the random number
        if (( $(echo "$rand < 0.7" | bc -l) )); then
            mv "$0" "$target_train_folder/$class_name"
        elif (( $(echo "$rand < 0.9" | bc -l) )); then
            mv "$0" "$target_val_folder/$class_name"
        else
            mv "$0" "$target_test_folder/$class_name"
        fi
    ' {} \;
done

echo "Images divided into train, validation, and test splits successfully!"
