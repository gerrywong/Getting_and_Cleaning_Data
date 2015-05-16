if(!file.exists("./data")){
    dir.create("./data")
}
fileurl<-"http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
download.file(fileurl,destfile="./data/dataset.zip")
unzip("./data/dataset.zip",exdir="./data")
setwd("./data")  ##unzip the downloaded file in "data" folder
