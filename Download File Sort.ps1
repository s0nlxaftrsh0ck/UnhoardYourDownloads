<# Download organizer:
  - Script function: Organize files into folders for me to comb through and delete

  Need to fix: Digs into child folders and moves files into created directories. Need it to not do that
  and only focus on the %$env:HOMEPATH\Downloads folder... this should also speed up the run time a bit as
  it's scanning more files than needed... [Fixed 5/1/2023]

  5/1/2023 Fix: 
  Changed:

  Get-ChildItem $userDownloads -Include ('*.exe', '*.msi') -Recurse
  
  To

  Get-ChildItem $userDownloads\* -Include

  Dropped the -recurse as this was going through going further into directories and pulling out files from there. Could possibly resolve this with -Depth to 
  control how deep I want it to traverse. 

  Added the \* to look directly and only in that folder.

  Added:

  Audio Files

  Feature to implement:

  Will look into using RoboCopy as thats faster and less resource intensive.
  https://thesurlyadmin.com/2014/08/04/getting-directory-information-fast/

  Can shell into CMD to run RoboCopy

#>


function createDirectory {
  param (
    [string] $directory
  )

  # Grabs what is put into $directory and puts it into this function. Then creates full path for folder.
  $fullPath = "$userDownloads\$directory"
  
    # Checks if there is a directory, if not create one
  
    Write-Host "Checking to see if $fullPath exists... `n" -ForegroundColor Yellow
    If (!(Test-Path "$fullPath")) {
      Write-Host "Directory not found, creating $fullPath `n" -ForegroundColor Green
        New-Item -Path $fullPath -ItemType Directory
  
        Write-Host "$fullPath `n" -ForegroundColor Green
    }
    Else {
      Write-Host "Directory exists... Skipping `n" -ForegroundColor Cyan
    }
  }

# Create variables and folder names
$userDownloads = "$env:HOMEPATH\Downloads\"
$archive = "Archive"
$audio = "Audio"
$executables = "Executables"
$images = "Images"
$office = "Office"
$pdf = "PDF"
$video = "Video"

# Create an array for folders
$folderList = @(
  $archive
  $audio
  $executables
  $images
  $office
  $pdf
  $video
)

# For loop that steps through array list and runs the createDirectory function
for ($i = 0; $i -lt $folderList.Count; $i++) {
  
  createDirectory($folderList[$i])
}


$fullArchive = "$userDownloads\$archive"

Get-ChildItem $userDownloads\* -Include ('*.7z','*.rar','*.tar','.tarz','*.zip') | ForEach-Object { 
  
  $source = $_.FullName
  $target = $fullArchive

  Write-Host "Copying Archive Files... `n"

  Move-Item -LiteralPath $source -Destination $target 
  
  Write-Host "Done!`n"

}


$fullAudio = "$userDownloads\$audio"

Get-ChildItem $userDownloads\* -Include ('*.flac','*.mp3','*.m4a','*.wav') | ForEach-Object { 
  
  $source = $_.FullName
  $target = $fullAudio

  Write-Host "Copying Audio Files... `n"

  Move-Item -LiteralPath $source -Destination $target 
  
  Write-Host "Done!`n"

}


$fullExecute = "$userDownloads\$executables"

Get-ChildItem $userDownloads\* -Include ('*.exe', '*.msi') | ForEach-Object { 
  
  $source = $_.FullName
  $target = $fullExecute
  Write-Host "Copying Executables Files... `n"

  Move-Item -LiteralPath $source -Destination $target -Force

  Write-Host "Done!`n"

}


$fullImages = "$userDownloads\$images"

Get-ChildItem $userDownloads\* -Include ('*.bmp', '*.jpg','*.jpeg', '*.png','*.svg','*.tiff') | ForEach-Object { 
  
  $source = $_.FullName
  $target = $fullImages

  Write-Host "Copying Image Files... `n"

  Move-Item -LiteralPath $source -Destination $target -Force

  Write-Host "Done!`n"

}


$fullOffice = "$userDownloads\$office"

Get-ChildItem $userDownloads\* -Include ('*.csv','*.doc','*.docx','*.txt','*.xls','*.xlsx') | ForEach-Object { 
  
  $source = $_.FullName
  $target = $fullOffice
  Write-Host "Copying Office Files... `n"

  Move-Item -LiteralPath $source -Destination $target -Force

  Write-Host "Done!`n"

}


$fullPDF = "$userDownloads\$pdf"

Get-ChildItem $userDownloads\* -Include ('*.pdf') | ForEach-Object { 
  
  $source = $_.FullName
  $target = $fullPDF

  Write-Host "Copying PDF Files... `n"

  Move-Item -LiteralPath $source -Destination $target -Force

  Write-Host "Done!`n"

}

$fullVideo = "$userDownloads\$video"

Get-ChildItem $userDownloads\* -Include ('*.avi','*.mkv','*.mov','*.mp4') | ForEach-Object { 
  
  $source = $_.FullName
  $target = $fullVideo

  Write-Host "Copying Video Files... `n"

  Move-Item -LiteralPath $source -Destination $target -Force

  Write-Host "Done!`n"

}



