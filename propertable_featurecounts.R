setwd("/path/to/bams")
ftable <- read.table(file = "featurecounts_table.txt",header=TRUE)
gene_names <- ftable[,1]
gene_length <- ftable[,6]
ftable <- ftable[,-c(1:6)]
colnames(ftable) <-sub("Aligned.sortedByCoord.out.bam","",sub("star_..","",colnames(ftable)))
gene_names[order(rowSums(ftable),decreasing = TRUE)]

rownames0 <- gsub("\\..*","",gene_names)
dup_rows <- rownames0[duplicated(rownames0)]

for(i in 1:length(dup_rows)){
  dup_indexes <- which(rownames0 == dup_rows[i])
  print(dup_indexes)
  ftable[dup_indexes[1],] <- colSums(ftable[dup_indexes,])
}

nrow(ftable)
ftable <- ftable[-which(duplicated(rownames0)),]
nrow(ftable)

rownames(ftable)  <- gsub("\\..*","",rownames0[-which(duplicated(rownames0))])

write.table(ftable,file="featurecounts.txt",sep="\t")
