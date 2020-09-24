as.data.table(read_exif(dir(pattern="jpg")))[1,-85][,t(.SD)]

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

r.2020 <- rbind(r01.2020,r02.2020,r03.2020,r04.2020,r05.2020,r06.2020,r07.2020,r08.2020,r09.2020,fill=TRUE)
r.2020


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

l <- {};
read.jpg.list(1,9)
r.2020 <- l 

r.2020[,.N,.(Month=months(ymd_hms(CreateDate)))]
fsum <- function(x) {sum(x,na.rm=FALSE)};
CamFS <- r.2020[,.(sumFS=fsum(FileSize),Count=.N),
.(Month=months(ymd_hms(CreateDate)))][,
.SD[,.(mean.photo.FS.MB=round((sumFS/Count)/2^20,1))],.(Month,Count.Photos=Count,sumFS.GB=round(sumFS/2^30,1))]
CamFS[]

dev.new()
r.2020[,.(Date=as.Date(ymd_hms(CreateDate)),Light=round(LightValue))][,plot(Light ~ Date)]
r.2020[,.(Date=as.Date(ymd_hms(CreateDate)),Light=round(LightValue))][,lines(lowess(Light ~ Date),col="red")]

dev.new()
r.2020[,.(Light=round(mean(LightValue,na.rm=TRUE))),.(Weeks=week(ymd_hms(CreateDate)))][,plot(Light ~ Weeks)]
r.2020[,.(Light=round(mean(LightValue,na.rm=TRUE))),.(Weeks=week(ymd_hms(CreateDate)))][,lines(lowess(Light ~ Weeks),col="blue")]

dev.new()
r.2020[,.(Light.mean=round(mean(LightValue,na.rm=TRUE),2)),.(week(ymd_hms(CreateDate)))][,barplot(Light.mean,name=week,col=rainbow(6))]



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