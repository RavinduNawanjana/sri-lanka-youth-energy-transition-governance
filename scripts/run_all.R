source("R/indicators.R")
x <- read_register("data/illustrative/roadmap_proposals.csv")
dir.create("outputs",showWarnings=FALSE)
utils::write.csv(quarter_summary(x), "outputs/ILLUSTRATIVE_quarter_summary.csv",row.names=FALSE)
utils::write.csv(status_summary(x), "outputs/ILLUSTRATIVE_status_summary.csv",row.names=FALSE)
utils::write.csv(theme_summary(x), "outputs/ILLUSTRATIVE_theme_summary.csv",row.names=FALSE)
png("outputs/ILLUSTRATIVE_status_fig.png",width=1100,height=620,res=140)
counts <- status_summary(x)
par(mar=c(10,5,4,1))
barplot(counts$records_in_supplied_register,names.arg=gsub("_"," ",counts$status),
        las=2,cex.names=.78,col="gray65",ylab="Activity records in illustrative file",
        main="ILLUSTRATIVE PROPOSAL REGISTER — NOT DELIVERY")
dev.off()
cat("Validated",nrow(x),"illustrative programme records.\n")
cat("Verified completions in the INPUT DEMO REGISTER:",sum(x$status == "completed_verified"),
    "; NOT a finding that no activity occurred in reality.\n")
