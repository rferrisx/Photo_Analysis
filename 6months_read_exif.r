library(data.table)
library(exifr)
# library(lubridate) Called as needed below
# Some routines to look at exif data in photos with read_exif()

# extract all exif names to matrix except thumbnail data which dumps badly into data.table
# Select exif attributes can be used in data.table j or k query fields
as.data.table(read_exif(dir(pattern="jpg")))[1,-85][,t(.SD)]

# nine months of jpg one at a time for select attributes.
# See function far below for more compact code:
# Note that not all Cameras or Camera Software will have congruent fields
# For example Samsung Note 8 does not have "Megapixels" field like Samsung Note 20 Ultra

setwd("D:/Photos/2020-01")
r01.2020 <- as.data.table(read_exif(dir(pattern="jpg")))[,-85][,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ShutterSpeed,LightValue,FileSize,ImageSize,Megapixels)]

setwd("D:/Photos/2020-02")
r02.2020 <- as.data.table(read_exif(dir(pattern="jpg")))[,-85][,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ShutterSpeed,LightValue,FileSize,ImageSize,Megapixels)]

setwd("D:/Photos/2020-03")
r03.2020 <- as.data.table(read_exif(dir(pattern="jpg")))[,-85][,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ShutterSpeed,LightValue,FileSize,ImageSize,Megapixels)]

setwd("D:/Photos/2020-04")
r04.2020 <- as.data.table(read_exif(dir(pattern="jpg")))[,-85][,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ShutterSpeed,LightValue,FileSize,ImageSize,Megapixels)]

setwd("D:/Photos/2020-05")
r05.2020 <- as.data.table(read_exif(dir(pattern="jpg")))[,-85][,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ShutterSpeed,LightValue,FileSize,ImageSize,Megapixels)]

setwd("D:/Photos/2020-06")
r06.2020 <- as.data.table(read_exif(dir(pattern="jpg")))[,-85][,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ShutterSpeed,LightValue,FileSize,ImageSize,Megapixels)]

setwd("D:/Photos/2020-07")
r07.2020 <- as.data.table(read_exif(dir(pattern="jpg")))[,-85][,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ShutterSpeed,LightValue,FileSize,ImageSize,Megapixels)]

setwd("D:/Photos/2020-08")
r08.2020 <- as.data.table(read_exif(dir(pattern="jpg")))[,-85][,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ShutterSpeed,LightValue,FileSize,ImageSize,Megapixels)]

setwd("D:/Photos/2020-09")
r09.2020 <- as.data.table(read_exif(dir(pattern="jpg")))[,-85][,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ShutterSpeed,LightValue,FileSize,ImageSize,Megapixels,DigitalZoomRatio)]

# one ring to bind them...
# fill = TRUE takes care of missing fields for different cameras/phones
r.2020 <- rbind(r01.2020,r02.2020,r03.2020,r04.2020,r05.2020,r06.2020,r07.2020,r08.2020,r09.2020,fill=TRUE)
r.2020[]

# Partial query of 9 months select attributes:
r.2020[,c(1,3,5,7,9)]
#               SourceFile ExposureTime FNumber ISO ShutterSpeed
#    1: 20200101_193722.jpg   0.03333333     1.7 160   0.03333333
#    2: 20200101_193725.jpg   0.03333333     1.7 160   0.03333333
#    3: 20200101_193729.jpg   0.03333333     1.7 160   0.03333333
#    4: 20200101_193740.jpg   0.03333333     1.7 250   0.03333333
#    5: 20200101_193742.jpg   0.04166667     1.7 250   0.04166667
#  ---                                                          
# 2623: 20200923_152234.jpg   0.02500000     1.8 320   0.02500000
# 2624: 20200923_152403.jpg   0.02564103     1.8 250   0.02564103
# 2625: 20200923_153326.jpg   0.01694915     1.8  64   0.01694915
# 2626: 20200923_154057.jpg   0.01694915     1.8 200   0.01694915
# 2627: 20200923_154102.jpg   0.01694915     1.8 250   0.01694915

# function to do the same as above for monthly file sequence (x:y)
read.jpg.list <- function(x,y){
for(i in c(x:y)){ 
setwd(paste0("D:/Photos/2020-0",i))
l <<- rbind(l,as.data.table(read_exif(dir(pattern="jpg")))[,-85][,
.(SourceFile,
CreateDate,
ExposureTime,
FOV,
FNumber,
ApertureValue,
ISO,
FocalLength,
ShutterSpeed,
LightValue,
FileSize,
ImageSize,
Megapixels)])}}

# run function read.jpg.list() as so:
l <- {};
read.jpg.list(1,9)
r.2020 <- l 

library(lubridate)
r.2020[,.N,.(Month=months(ymd_hms(CreateDate)))]
# Sample output:
# r.2020[,.N,.(Month=months(ymd_hms(CreateDate)))][-2]
#       Month   N
# 1:   January 133
# 2:  February 194
# 3:     March 263
# 4:     April 445
# 5:       May 126
# 6:      June 218
# 7:      July 400
# 8:    August 567
# 9: September 280

fsum <- function(x) {sum(x,na.rm=FALSE)}
CamFS <- r.2020[,.(sumFS=fsum(FileSize),Count=.N),
.(Month=months(ymd_hms(CreateDate)))][,
.SD[,.(mean.photo.FS.MB=round((sumFS/Count)/2^20,1))],.(Month,Count.Photos=Count,sumFS.GB=round(sumFS/2^30,1))]
CamFS[]
#  Sample output:
#  CamFS[]
#        Month Count.Photos sumFS.GB mean.photo.FS.MB
# 1:   January          133      0.3              2.3
# 2:  December            1      0.0              0.4
# 3:  February          194      0.4              2.2
# 4:     March          263      0.5              2.1
# 5:     April          445      1.0              2.3
# 6:       May          126      0.3              2.7
# 7:      June          218      0.6              2.7
# 8:      July          400      1.0              2.7
# 9:    August          567      1.5              2.8
#10: September          280      1.1              4.1

# Some simple time series plots
# using data.table (j,k) aggregate queries
library(lubridate)
dev.new()
r.2020[,.(Date=as.Date(ymd_hms(CreateDate)),Light=round(LightValue))][,plot(Light ~ Date)]
r.2020[,.(Date=as.Date(ymd_hms(CreateDate)),Light=round(LightValue))][,lines(lowess(Light ~ Date),col="red")]

dev.new()
r.2020[,.(Light=round(mean(LightValue,na.rm=TRUE))),.(Weeks=week(ymd_hms(CreateDate)))][,plot(Light ~ Weeks)]
r.2020[,.(Light=round(mean(LightValue,na.rm=TRUE))),.(Weeks=week(ymd_hms(CreateDate)))][,lines(lowess(Light ~ Weeks),col="blue")]

dev.new()
r.2020[,.(Light.mean=round(mean(LightValue,na.rm=TRUE),2)),.(week(ymd_hms(CreateDate)))][,barplot(Light.mean,name=week,col=rainbow(6))]

# Some data.table style (i,j) queries
as.data.table(read_exif(dir(pattern="jpg")))[,-85][Megapixels > 100,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ImageSize,Megapixels,DigitalZoomRatio)]

as.data.table(read_exif(dir(pattern="jpg")))[,-85][Megapixels < 100,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ImageSize,Megapixels,DigitalZoomRatio)]

as.data.table(read_exif(dir(pattern="jpg")))[,-85][DigitalZoomRatio >= 25,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ImageSize,Megapixels,DigitalZoomRatio)]

as.data.table(read_exif(dir(pattern="jpg")))[,-85][DigitalZoomRatio >= 20,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ImageSize,Megapixels,DigitalZoomRatio)]

as.data.table(read_exif(dir(pattern="jpg")))[,-85][DigitalZoomRatio >= 10,
.(SourceFile,CreateDate,ExposureTime,FOV,FNumber,ApertureValue,ISO,FocalLength,ImageSize,Megapixels,DigitalZoomRatio)]
