# R 4.22 code for querying exif on Samsung s2023
# Can do something similar with Windows cmd line with exiftool:
# D:\tools\exiftool-12.06\exiftool 20230218_124134.jpg
# Available @ https://exiftool.org/
# See Windows cmd output far below

# R 4.22 code:
# Make sure to have an Active State or Strawbery installation of PERL ...
# if neccessary for latest models:
# devtools::install_github("paleolimbot/exifr")
library(exifr)
library(data.table)
library(lubridate)

# "datatablelize" read_exif code
read_exif("F:\\Photos\\S2023UltraTest",recursive=TRUE)
S2023 <- as.data.table(read_exif("F:\\Photos\\S2023UltraTest",recursive=TRUE))

names(S2023) # see 169 exif fields output below; some will have binary output
S2023[,.(FileName,Megapixel)]
S2023[,.(FileName,CreateTime=(ymd_hms(CreateDate)),CreateDate=(ymd_hms(CreateDate)),Megapixels,ImageHeight,ImageWidth,ImageSize)]

#Sample Queries
S2023[FileName == "20230218_083535.jpg",.(Megapixels,ImageSize,Aperture,FocalLength,LightValue)]
S2023[FileName == "20230218_083535.jpg",.(Megapixels,ImageSize,Aperture,FocalLength,LightValue)][,t(as.matrix(.SD))]


# Windows cmd line exiftool output:
cat('
D:\tools\exiftool-12.06\exiftool 20230218_124017.jpg
ExifTool Version Number         : 12.06
File Name                       : 20230218_124017.jpg
Directory                       : .
File Size                       : 29 MB
File Modification Date/Time     : 2023:02:18 12:41:46-08:00
File Access Date/Time           : 2023:02:18 12:56:27-08:00
File Creation Date/Time         : 2023:02:18 12:51:08-08:00
File Permissions                : rw-rw-rw-
File Type                       : JPEG
File Type Extension             : jpg
MIME Type                       : image/jpeg
Exif Byte Order                 : Little-endian (Intel, II)
Make                            : samsung
Camera Model Name               : Galaxy S23 Ultra
Orientation                     : Horizontal (normal)
X Resolution                    : 72
Y Resolution                    : 72
Resolution Unit                 : inches
Software                        : S918USQU1AWA6
Modify Date                     : 2023:02:18 12:40:17
Y Cb Cr Positioning             : Centered
Exposure Time                   : 1/60
F Number                        : 1.7
Exposure Program                : Program AE
ISO                             : 25
Exif Version                    : 0220
Date/Time Original              : 2023:02:18 12:40:17
Create Date                     : 2023:02:18 12:40:17
Offset Time                     : -08:00
Offset Time Original            : -08:00
Components Configuration        : Y, Cb, Cr, -
Shutter Speed Value             : 1
Aperture Value                  : 1.7
Brightness Value                : 4.76
Exposure Compensation           : 0
Max Aperture Value              : 1.7
Metering Mode                   : Center-weighted average
Flash                           : No Flash
Focal Length                    : 6.3 mm
Sub Sec Time                    : 894
Sub Sec Time Original           : 894
Sub Sec Time Digitized          : 894
Flashpix Version                : 0100
Color Space                     : Uncalibrated
Exif Image Width                : 16320
Exif Image Height               : 12240
Exposure Mode                   : Auto
White Balance                   : Auto
Digital Zoom Ratio              : 3.68
Focal Length In 35mm Format     : 23 mm
Scene Capture Type              : Standard
Image Unique ID                 : P12XLPE00NM P12XLPE00NM
Compression                     : JPEG (old-style)
Thumbnail Offset                : 842
Thumbnail Length                : 61315
Profile CMM Type                :
Profile Version                 : 4.3.0
Profile Class                   : Display Device Profile
Color Space Data                : RGB
Profile Connection Space        : XYZ
Profile Date Time               : 2022:07:01 00:00:00
Profile File Signature          : acsp
Primary Platform                : Unknown (SEC)
CMM Flags                       : Not Embedded, Independent
Device Manufacturer             : Unknown (SEC)
Device Model                    :
Device Attributes               : Reflective, Glossy, Positive, Color
Rendering Intent                : Perceptual
Connection Space Illuminant     : 0.9642 1 0.82491
Profile Creator                 : Unknown (SEC)
Profile ID                      : 0
Profile Description             : DCI-P3 D65 Gamut with sRGB Transfer
Profile Copyright               : Copyright (c) 2022 Samsung Electronics Co., Ltd.
Media White Point               : 0.9642 1 0.82491
Chromatic Adaptation            : 1.04781 0.02289 -0.05013 0.02954 0.99048 -0.01704 -0.00923 0.01505 0.75214
Red Matrix Column               : 0.51508 0.24117 -0.00105
Green Matrix Column             : 0.29195 0.69223 0.04189
Blue Matrix Column              : 0.15718 0.06659 0.78455
Red Tone Reproduction Curve     : (Binary data 32 bytes, use -b option to extract)
Green Tone Reproduction Curve   : (Binary data 32 bytes, use -b option to extract)
Blue Tone Reproduction Curve    : (Binary data 32 bytes, use -b option to extract)
Image Width                     : 16320
Image Height                    : 12240
Encoding Process                : Baseline DCT, Huffman coding
Bits Per Sample                 : 8
Color Components                : 3
Y Cb Cr Sub Sampling            : YCbCr4:2:0 (2 2)
Time Stamp                      : 2023:02:18 12:40:17-08:00
Aperture                        : 1.7
Image Size                      : 16320x12240
Megapixels                      : 199.8
Scale Factor To 35 mm Equivalent: 3.7
Shutter Speed                   : 1/60
Create Date                     : 2023:02:18 12:40:17.894
Date/Time Original              : 2023:02:18 12:40:17.894-08:00
Modify Date                     : 2023:02:18 12:40:17.894-08:00
Thumbnail Image                 : (Binary data 61315 bytes, use -b option to extract)
Circle Of Confusion             : 0.008 mm
Field Of View                   : 76.1 deg
Focal Length                    : 6.3 mm (35 mm equivalent: 23.0 mm)
Hyperfocal Distance             : 2.84 m
Light Value                     : 9.4
')

cat('
names(S2023)
  [1] "SourceFile"                "ExifToolVersion"           "FileName"                  "Directory"                 "FileSize"                  "FileModifyDate"            "FileAccessDate"            "FileCreateDate"           
  [9] "FilePermissions"           "FileType"                  "FileTypeExtension"         "MIMEType"                  "ExifByteOrder"             "Make"                      "Model"                     "Orientation"              
 [17] "XResolution"               "YResolution"               "ResolutionUnit"            "Software"                  "ModifyDate"                "YCbCrPositioning"          "ExposureTime"              "FNumber"                  
 [25] "ExposureProgram"           "ISO"                       "ExifVersion"               "DateTimeOriginal"          "CreateDate"                "OffsetTime"                "OffsetTimeOriginal"        "ShutterSpeedValue"        
 [33] "ApertureValue"             "BrightnessValue"           "ExposureCompensation"      "MaxApertureValue"          "MeteringMode"              "Flash"                     "FocalLength"               "SubSecTime"               
 [41] "SubSecTimeOriginal"        "SubSecTimeDigitized"       "ColorSpace"                "ExifImageWidth"            "ExifImageHeight"           "ExposureMode"              "WhiteBalance"              "DigitalZoomRatio"         
 [49] "FocalLengthIn35mmFormat"   "SceneCaptureType"          "ImageUniqueID"             "Compression"               "ThumbnailOffset"           "ThumbnailLength"           "ProfileCMMType"            "ProfileVersion"           
 [57] "ProfileClass"              "ColorSpaceData"            "ProfileConnectionSpace"    "ProfileDateTime"           "ProfileFileSignature"      "PrimaryPlatform"           "CMMFlags"                  "DeviceManufacturer"       
 [65] "DeviceModel"               "DeviceAttributes"          "RenderingIntent"           "ConnectionSpaceIlluminant" "ProfileCreator"            "ProfileID"                 "ProfileDescription"        "ProfileCopyright"         
 [73] "MediaWhitePoint"           "ChromaticAdaptation"       "RedMatrixColumn"           "GreenMatrixColumn"         "BlueMatrixColumn"          "RedTRC"                    "GreenTRC"                  "BlueTRC"                  
 [81] "ImageWidth"                "ImageHeight"               "EncodingProcess"           "BitsPerSample"             "ColorComponents"           "YCbCrSubSampling"          "TimeStamp"                 "Aperture"                 
 [89] "ImageSize"                 "Megapixels"                "ScaleFactor35efl"          "ShutterSpeed"              "SubSecCreateDate"          "SubSecDateTimeOriginal"    "SubSecModifyDate"          "ThumbnailImage"           
 [97] "CircleOfConfusion"         "FOV"                       "FocalLength35efl"          "HyperfocalDistance"        "LightValue"                "MajorBrand"                "MinorVersion"              "CompatibleBrands"         
[105] "MediaDataSize"             "MediaDataOffset"           "MovieHeaderVersion"        "TimeScale"                 "Duration"                  "PreferredRate"             "PreferredVolume"           "PreviewTime"              
[113] "PreviewDuration"           "PosterTime"                "SelectionTime"             "SelectionDuration"         "CurrentTime"               "NextTrackID"               "PlayMode"                  "Author"                   
[121] "AndroidVersion"            "AndroidCaptureFps"         "TrackHeaderVersion"        "TrackCreateDate"           "TrackModifyDate"           "TrackID"                   "TrackDuration"             "TrackLayer"               
[129] "TrackVolume"               "GraphicsMode"              "OpColor"                   "CompressorID"              "SourceImageWidth"          "SourceImageHeight"         "BitDepth"                  "ColorRepresentation"      
[137] "VideoFrameRate"            "MatrixStructure"           "MediaHeaderVersion"        "MediaCreateDate"           "MediaModifyDate"           "MediaTimeScale"            "MediaDuration"             "HandlerType"              
[145] "HandlerDescription"        "Balance"                   "AudioFormat"               "AudioChannels"             "AudioBitsPerSample"        "AudioSampleRate"           "AvgBitrate"                "Rotation"                 
[153] "ComponentsConfiguration"   "FlashpixVersion"           "InteropIndex"              "InteropVersion"            "SensingMethod"             "SceneType"                 "GPSLongitudeRef"           "GPSAltitudeRef"           
[161] "GPSTimeStamp"              "GPSDateStamp"              "GPSAltitude"               "GPSDateTime"               "GPSLongitude"              "OtherImageStart"           "OtherImageLength"          "LightSource"              
[169] "JFIFVersion"               "OtherImage"
')               

