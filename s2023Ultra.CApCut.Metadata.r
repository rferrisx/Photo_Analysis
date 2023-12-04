# 4:46 PM 12/3/2023
# Uncomment to install these packages:
# install.packages("data.table)
# install.packages("exifr")
# Designed for Samsung Ultra 2023 files
# with Capcut Video Editor or any file repository.

library(data.table)
library(exifr)

#set path to files for your CapCut project if cloud files are locally stored:
setwd("C:/Users/rferrisx/AppData/Local/CapCut/User Data/Projects/com.lveditor.draft/1202/Resources/local")
# Otherwise changes to other project folders as needed

# Code to remove binary fields and show columan names
as.data.table(read_exif(getwd(),recursive=TRUE))[1][,names(.SD)] # show all meta tag names
as.data.table(read_exif(getwd(),recursive=TRUE))[1][,-c("ThumbnailImage","RedTRC","BlueTRC")] # remove binary field
as.data.table(read_exif(getwd(),recursive=TRUE))[1:10,1:20][,-c("ThumbnailImage","RedTRC","BlueTRC")] # remove binary fields

Images <- as.data.table(read_exif(getwd(),recursive=TRUE))[,
c("CreateDate",
"FileModifyDate",
"FileName",
"FileType",
"BitDepth",
"FileSize",
"MediaDataSize",
"ImageSize",
"MetaImageSize",
"ImageHeight",
"ImageWidth",
"CircleOfConfusion")][order(FileType,FileModifyDate,FileName)]
Images[,MegPix:=(ImageHeight * ImageWidth)/1000000] #synthetic mp field??
Images



