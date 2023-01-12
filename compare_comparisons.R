#!/usr/bin/env Rscript

##################################################################################
# STUDY VARIABLES
##################################################################################
data_path <- normalizePath("./")
setwd(data_path)
output_path <- file.path(data_path,"compare")
dir.create(output_path)
library(VennDiagram)


##############
#
##############
conditions <- c("CONTROL_BASAL_vs_CONTROL_ASA","NIUA_BASAL_vs_NIUA_ASA","CONTROL_ASA_vs_NIUA_ASA")
names_to_plot <- c("Before vs Intake","Acute vs Resolution","Intake vs Acute")
list_total <- lapply(conditions,function(x){
  path_to <- file.path(data_path,x,"results","hunter_results_table_annotated.txt")
  df <- read.table(path_to,header=TRUE,sep="\t",row.names = 1)
  unique(df <- df[df$genes_tag == "PREVALENT_DEG",]$input_IDs)
  }
)
names(list_total) <- names_to_plot

list_up<- lapply(conditions,function(x){
  path_to <- file.path(data_path,x,"results","hunter_results_table_annotated.txt")
  df <- read.table(path_to,header=TRUE,sep="\t",row.names = 1)
  unique(df <- df[df$genes_tag == "PREVALENT_DEG" & df$mean_logFCs > 0,]$input_IDs)
}
)
names(list_up) <- names_to_plot

list_down <- lapply(conditions,function(x){
  path_to <- file.path(data_path,x,"results","hunter_results_table_annotated.txt")
  df <- read.table(path_to,header=TRUE,sep="\t",row.names = 1)
  unique(df <- df[df$genes_tag == "PREVALENT_DEG" & df$mean_logFCs < 0,]$input_IDs)
}
)
names(list_down) <- names_to_plot

overrideTriple=T
venn.diagram(list_total,filename = paste(output_path,"/vennAnaphComparisonsGENESTOTALCOLOR.png",sep=""),col = "black",
             fill = c("skyblue1", "khaki1","indianred1"),height = 2700, width = 2700,cat.pos = c(340,20,180),cat.cex=0.5,resolution=1000,sub.fontfamily="Times New Roman",main.fontfamily = "Times New Roman",cat.fontfamily="Times New Roman",cex=0.55,lwd=0.5)
venn.diagram(list_up,filename = paste(output_path,"/vennAnaphComparisonsGENESUPCOLOR.png",sep=""),col = "black",
             fill = c("skyblue1", "khaki1","indianred1"),height = 2700, width = 2700,cat.pos = c(330,30,170),cat.cex=0.5,resolution=1000,sub.fontfamily="Times New Roman",main.fontfamily = "Times New Roman",cat.fontfamily="Times New Roman",cex=0.55,lwd=0.5)
venn.diagram(list_down,filename = paste(output_path,"/vennAnaphComparisonsGENESDOWNCOLOR.png",sep=""),col = "black",
             fill = c("skyblue1", "khaki1","indianred1"),height = 2700, width = 2700,cat.pos = c(330,20,180),cat.cex=0.5,resolution=1000,sub.fontfamily="Times New Roman",main.fontfamily = "Times New Roman",cat.fontfamily="Times New Roman",cex=0.55,lwd=0.5)

tables_total <- lapply(conditions,function(x){
  path_to <- file.path(data_path,x,"results","hunter_results_table_annotated.txt")
  df <- read.table(path_to,header=TRUE,sep="\t",row.names = 1)
}
)
names(tables_total) <- names_to_plot


#####GOI

partitions_table <- as.data.frame(VennDiagram::get.venn.partitions(list_total))

goi <- partitions_table[6,5][[1]]

A_vs_R_goi <- tables_total[[2]][tables_total[[2]]$input_IDs%in%goi,]
write.table(A_vs_R_goi,file=paste(output_path,"/acute_only_DEGs.csv",sep=""),sep="\t",row.names = FALSE)

#########
list_total_sy <- lapply(conditions,function(x){
  path_to <- file.path(data_path,x,"results","hunter_results_table_annotated.txt")
  df <- read.table(path_to,header=TRUE,sep="\t",row.names = 1)
  print(nrow(df[df$genes_tag == "PREVALENT_DEG",]))
  df[is.na(df$Symbol),]$Symbol <- df[is.na(df$Symbol),]$input_IDs
  df[duplicated(df$Symbol),]$Symbol <- df[duplicated(df$Symbol),]$input_IDs
  print(nrow(df[df$genes_tag == "PREVALENT_DEG",]))
  genelist <- df[df$genes_tag == "PREVALENT_DEG",]$Symbol
}
)
names(list_total_sy) <- names_to_plot
partitions_table <- as.data.frame(VennDiagram::get.venn.partitions(list_total_sy))
for(i in 1:nrow(partitions_table)){
  vec <- paste(partitions_table$..values..[[i]],collapse=", ")
  partitions_table$..values..[[i]] <- vec
}
partitions_table$..values.. <- unlist(partitions_table$..values..)
write.table(partitions_table,file=paste(output_path,"/partable_DEGs.csv",sep=""),sep="\t")

#########
list_up_sy <- lapply(conditions,function(x){
  path_to <- file.path(data_path,x,"results","hunter_results_table_annotated.txt")
  df <- read.table(path_to,header=TRUE,sep="\t",row.names = 1)
  print(nrow(df[df$genes_tag == "PREVALENT_DEG",]))
  df[is.na(df$Symbol),]$Symbol <- df[is.na(df$Symbol),]$input_IDs
  df[duplicated(df$Symbol),]$Symbol <- df[duplicated(df$Symbol),]$input_IDs
  print(nrow(df[df$genes_tag == "PREVALENT_DEG",]))
  genelist <- df[df$genes_tag == "PREVALENT_DEG"& df$mean_logFCs > 0,]$Symbol
}
)
names(list_up_sy) <- names_to_plot
partitions_table <- as.data.frame(VennDiagram::get.venn.partitions(list_up_sy))
for(i in 1:nrow(partitions_table)){
  vec <- paste(partitions_table$..values..[[i]],collapse=", ")
  partitions_table$..values..[[i]] <- vec
}
partitions_table$..values.. <- unlist(partitions_table$..values..)
write.table(partitions_table,file=paste(output_path,"/partable_DEGs_UP.csv",sep=""),sep="\t")

#########
list_down_sy <- lapply(conditions,function(x){
  path_to <- file.path(data_path,x,"results","hunter_results_table_annotated.txt")
  df <- read.table(path_to,header=TRUE,sep="\t",row.names = 1)
  print(nrow(df[df$genes_tag == "PREVALENT_DEG",]))
  df[is.na(df$Symbol),]$Symbol <- df[is.na(df$Symbol),]$input_IDs
  df[duplicated(df$Symbol),]$Symbol <- df[duplicated(df$Symbol),]$input_IDs
  print(nrow(df[df$genes_tag == "PREVALENT_DEG",]))
  genelist <- df[df$genes_tag == "PREVALENT_DEG"& df$mean_logFCs < 0,]$Symbol
}
)
names(list_down_sy) <- names_to_plot
partitions_table <- as.data.frame(VennDiagram::get.venn.partitions(list_down_sy))
for(i in 1:nrow(partitions_table)){
  vec <- paste(partitions_table$..values..[[i]],collapse=", ")
  partitions_table$..values..[[i]] <- vec
}
partitions_table$..values.. <- unlist(partitions_table$..values..)
write.table(partitions_table,file=paste(output_path,"/partable_DEGs_DOWN.csv",sep=""),sep="\t")

##VOLCANO!

library(EnhancedVolcano)
t1 <- tables_total[[1]]

t1[t1$mean_logFCs < -5,]$Symbol <- paste(t1[t1$mean_logFCs < -5,]$Symbol,"*",sep="")
t1[t1$mean_logFCs < -5,]$mean_logFCs <- -4.99

tiff("volcano1.tiff", height = 25, width = 30, units='cm',compression = "lzw", res = 600)

EnhancedVolcano(t1,t1$Symbol,"mean_logFCs","FDR_limma",title = "Before vs Intake", subtitle = "Differential expression",
                pointSize = 3,
                labSize = 8,
                labFace = 'bold',
                legendPosition = 'none',
                FCcutoff = 0.58,
                pCutoff = 0.05,
                gridlines.major = FALSE,
                gridlines.minor = FALSE,
                ylim=c(0,11),
                xlim=c(-5,5)
)

dev.off()



t1 <- tables_total[[2]]

t1[t1$mean_logFCs < -5,]$Symbol <- paste(t1[t1$mean_logFCs < -5,]$Symbol,"*",sep="")
t1[t1$mean_logFCs < -5,]$mean_logFCs <- -4.99

tiff("volcano2.tiff", height = 25, width = 30, units='cm',compression = "lzw", res = 600)

EnhancedVolcano(t1,t1$Symbol,"mean_logFCs","FDR_limma",title = "Resolution vs Acute", subtitle = "Differential expression",
                pointSize = 3,
                labSize = 8,
                labFace = 'bold',
                legendPosition = 'none',
                FCcutoff = 0.58,
                pCutoff = 0.05,
                gridlines.major = FALSE,
                gridlines.minor = FALSE,
                ylim=c(0,11),
                xlim=c(-5,5)
)

dev.off()


t1 <- tables_total[[3]]

t1[t1$mean_logFCs < -5,]$Symbol <- paste(t1[t1$mean_logFCs < -5,]$Symbol,"*",sep="")
t1[t1$mean_logFCs < -5,]$mean_logFCs <- -4.99

tiff("volcano3.tiff", height = 25, width = 30, units='cm',compression = "lzw", res = 600)

EnhancedVolcano(t1,t1$Symbol,"mean_logFCs","FDR_limma",title = "Intake vs Acute", subtitle = "Differential expression",
                pointSize = 3,
                labSize = 8,
                labFace = 'bold',
                legendPosition = 'none',
                FCcutoff = 0.58,
                pCutoff = 0.05,
                gridlines.major = FALSE,
                gridlines.minor = FALSE,
                ylim=c(0,11),
                xlim=c(-5,5)
)

dev.off()
