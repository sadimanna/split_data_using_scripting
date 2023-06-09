@echo off 
setlocal enabledelayedexpansion 
 
REM Set the paths for Folder A, train folder, val folder, and test folder 
set "base_path=C:\Users\ISI_UTS\Siladittya\MIDA2023" 
set "image_folder_path=%base_path%\images" 
set "train_image_path=%base_path%\train_images" 
set "val_image_path=%base_path%\val_images" 
set "test_image_path=%base_path%\test_images" 
 
REM Create the train, val, and test folders if they don't exist 
mkdir "%train_image_path%" 
mkdir "%val_image_path%" 
mkdir "%test_image_path%" 
 
REM Clear the train, val, and test folders if they are not empty 
del /q "%train_image_path%\*" 
del /q "%val_image_path%\*" 
del /q "%test_image_path%\*" 
REM Define the percentage split for train, val, and test (adjust as needed) 
set "train_split=25" 
set "val_split=50" 
set "test_split=100" 
REM Move files from Folder A to the train, val, and test folders 
for %%f in ("%image_folder_path%\*") do ( 
    set /a "rand_num=!random! %% 100" 
    if !rand_num! lss %train_split% ( 
        move "%%~ff" "%train_image_path%\" 
    ) else if !rand_num! lss %val_split% ( 
        move "%%~ff" "%val_image_path%\" 
    ) else ( 
        move "%%~ff" "%test_image_path%\" 
    ) 
) 
 
echo Files divided into train, val, and test splits successfully! 
REM Set the paths for Folder A, train folder, val folder, and test folder 
set "mask_folder_path=%base_path%\annotations\trimaps" 
set "train_mask_path=%base_path%\train_masks" 
set "val_mask_path=%base_path%\val_masks" 
set "test_mask_path=%base_path%\test_masks" 
REM Create the target folder if it doesn't exist 
mkdir "%train_mask_path%" 
mkdir "%val_mask_path%" 
mkdir "%test_mask_path%" 
set "extension=.png" 
REM Move label files from the label folder to the train folder based on file names 
for %%F in ("%train_image_path%\*") do ( 
    set "file_name=%%~nF" 
    move "%mask_folder_path%\!file_name!%extension%" "%train_mask_path%\" 
) 
REM Move label files from the label folder to the val folder based on file names 
for %%F in ("%val_image_path%\*") do ( 
    set "file_name=%%~nF" 
    move "%mask_folder_path%\!file_name!%extension%" "%val_mask_path%\" 
) 
REM Move label files from the label folder to the test folder based on file names 
for %%F in ("%test_image_path%\*") do ( 
    set "file_name=%%~nF" 
    move "%mask_folder_path%\!file_name!%extension%" "%test_mask_path%\" 
) 
echo Label files moved to the target folder successfully! 
endlocal 