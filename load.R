fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
tf<-"exdata-data-NEI_data.zip"
download.file(fileUrl,tf)
fnames<-unzip(tf,list=TRUE)$Name
fnames<-unzip(tf,files=fnames,exdir=".",overwrite=TRUE)
fname<-fnames[1]
ssc<- readRDS(fname)
fname<-fnames[2]
pm25<- readRDS(fname)
pm25r <- pm25[sample(nrow(pm25), 500), ]


