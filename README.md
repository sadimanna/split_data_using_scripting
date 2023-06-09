# Shell and Batch Script to split Datasets into Train, Validation and Test sets

- Files '**split_dataset_with_single_folder.\***' splits a dataset containing all the images in a single folder (possibly for tasks like segmentation) into train, validation and test sets. It also splits the labels/masks corresponding to the files in train, val or test folder accordingly.

- Files '**split_dataset_with_class_subf.\***' splits a datasets containing data in class-wise subfolders, into train, validation and test folders, while preserving the directory structure and containing all the class subfolders.
