This PowerShell script was written by Tony Kirchgessner of The New York Botanical Garden to facilitate herbarium specimen image processing workflows. Specifically, this script will rename DNG image files to match derivative JPEG image files that have been renamed by the application BardecodeFiler. 

The New York Botanical Garden (NYBG) captures herbarium specimen images in camera raw file format (e.g. Canon, Nikon), then converts them to the Adobe digital negative format (DNG) for archiving.

The application BardecodeFiler (http://www.bardecode.com/en1/app/bardecodefiler/) is a barcode reading application which will rename TIF, JPEG, and PDF documents as the barcode(s) it reads in each document. Unfortunately this application does not rename DNGs. 

To work around this, NYBG generates derivative JPEG images from the DNGs and renames these JPEGs using the BardecodeFiler application. Then we run this PowerShell script which uses the BardecodeFiler results.csv to rename the DNGs based on the renamed JPEGs.


#1. Create a folder called dng in the location of the BardecodeFiler files, and copy the dng files here
    # As an example, I have created mine here: C:\Documents and Settings\tkirchgessner\My Documents\BardecodeFiler\dng
    # If there are too many to copy, let me know where they are and I will modify the script to find them.
#2. Set the path in the line below to the location of the BardecodeFiler csv output file
$path = "E:\BardecodeFiler\output\results.csv"
Import-csv -path $path | 
foreach-object `
{ 
  $jpegfolder = $_.Folder
  $dngfolder = $jpegfolder -replace "input$", "dng\"
  $oldname = $_."File Name"
  $oldnamedng = $oldname -replace "jpg$", "dng"
  $oldfile = $dngfolder + $oldnamedng
  $count = $_.Count
  $barcode = $_.Value
  rename-item $oldfile -newname ($barcode + '.dng')
}