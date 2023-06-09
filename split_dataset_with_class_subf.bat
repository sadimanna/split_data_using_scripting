@echo off
setlocal enabledelayedexpansion

REM Set the paths for the main image folder, train folder, val folder, and test folder
set "image_folder=C:\Path\to\ImageFolder"
set "train_folder=C:\Path\to\train"
set "val_folder=C:\Path\to\val"
set "test_folder=C:\Path\to\test"

REM Create the train, val, and test folders if they don't exist
mkdir "%train_folder%" 2>nul
mkdir "%val_folder%" 2>nul
mkdir "%test_folder%" 2>nul

REM Define the percentage split for train, val, and test (adjust as needed) >> script.bat
set "train_split=25"
set "val_split=50"
set "test_split=100"

REM Clear the train, val, and test folders if they are not empty
del /q "%train_folder%\*"
del /q "%val_folder%\*"
del /q "%test_folder%\*"

REM Loop through each subfolder in the image folder
for /d %%a in ("%image_folder%\*") do (
    REM Get the current subfolder name (class name)
    set "class_name=%%~nxa"
    
    REM Create the corresponding class subfolders in train, val, and test splits
    mkdir "%train_folder%\!class_name!"
    mkdir "%val_folder%\!class_name!"
    mkdir "%test_folder%\!class_name!"

    REM Move files from the current class subfolder to the train, val, or test split
    for %%b in ("%%a\*") do (
        set /a "rand_num=!random! %% 100"

        if !rand_num! lss %train_split% (
            move "%%~fb" "%train_folder%\!class_name!\"
        ) else if !rand_num! lss %valid_split% (
            move "%%~fb" "%val_folder%\!class_name!\"
        ) else (
            move "%%~fb" "%test_folder%\!class_name!\"
        )
    )
)

echo Files divided into train, val, and test splits successfully!
endlocal
