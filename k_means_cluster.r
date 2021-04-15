a <- read.table("ortho.tsv",header=TRUE,sep="\t")
m <- ncol(a)
b <- a[,2:m]
b <- log(b+1,2)
b<- round(b)
a[,2:m] <-b
set.seed(1)
km_result <- kmeans(b,8, nstart = 24)
m <-a[tt,]
e <- melt(m)
e[,2] <- factor(e[,2],c)
e[,1] <- factor(e[,1],a[tt,1])
ggplot(e,aes(ID,variable)) + geom_tile(aes(fill = value))  + theme(axis.text.x  = element_blank(),axis.ticks =element_blank())  + scale_fill_gradient(low="white",high="red")
