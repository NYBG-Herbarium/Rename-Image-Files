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