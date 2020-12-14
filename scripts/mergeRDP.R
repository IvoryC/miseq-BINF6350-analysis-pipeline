
# In case cluster job detached script from intended context
system("[ ${#PBS_O_WORKDIR} -gt 0 ] && cd $PBS_O_WORKDIR")

workingDir <- getwd()
moduleDir <- dirname(workingDir) 
pipeRoot <- dirname(moduleDir)

# Find the RDP module
rdpMod <- dir(pipeRoot, full.names=TRUE, pattern="[0123456789]*_RDP$") 

starter = hierTables <- file.path(rdpMod, "output", "control_hierCounts.txt")
allCounts = read.delim2(starter)

hierTables <- dir(file.path(rdpMod, "output"), pattern="^sample[0123456789]*_hierCounts.txt", full.names=TRUE)

for (file in hierTables){
    table = read.delim2(file)
    allCounts = merge(allCounts, table, all=TRUE,
                      by=c("taxid", "lineage", "name", "rank") )
    rm(table)
}

names(allCounts) = gsub(".fastq.gz", "", names(allCounts))

#change NA's to 0s
allCounts[is.na(allCounts)] <- 0

# split table by 'rank', remove "rootrank" and save each of the others as level tables
levelCounts = split(allCounts, f=allCounts$rank)

taxaLevels = c("class", "domain", "family", "genus", "order", "phylum")

for (rank in names(levelCounts)){
    if (rank %in% taxaLevels){
        outFile = file.path(moduleDir, "output", paste0("counts_", rank, ".txt"))
        write.table(levelCounts[[rank]], file=outFile, sep="\t", quote=FALSE,
                    col.names = TRUE, row.names = FALSE)
        message("Saved table of ", rank, " values to file: ", outFile)
    }else{
        message("Skipping rank '", rank, "', it is not a standard taxanomic level.")
    }
}

sessionInfo()
