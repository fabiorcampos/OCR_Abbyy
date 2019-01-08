### table 1 - Packing List
pl1 = do.call(rbind, mget(ls(pattern = "packing1.csv")))
pl2 = do.call(rbind, mget(ls(pattern = "packing1_[0-9].csv")))
pl3 = do.call(rbind, mget(ls(pattern = "packing1_[0-9][0-9].csv")))
pl4 = rbind(pl1,pl2)
pl4 = rbind(pl4,pl3)
pl = pl4[,1:3]

pl$NamesId = rownames(pl)
pl$NamesId = gsub("packing1", "", pl$NamesId)
pl$NamesId = gsub("_", "", pl$NamesId)
pl$NamesId = gsub(".csv", "", pl$NamesId)
pl$Delivery = gsub(", ", "", pl$Delivery)

### table 2 - Packing List
table22 = do.call(rbind, mget(ls(pattern = "packing2.csv")))
table20 = do.call(rbind, mget(ls(pattern = "packing2_[0-9].csv")))
table21 = do.call(rbind, mget(ls(pattern = "packing2_[0-9][0-9].csv")))
table2 = rbind(table22,table20)
table2 = rbind(table2, table21)
table2 = table2[,c(1,2,6)]

table2$NamesId = rownames(table2)
table2$NamesId = gsub("packing2", "", table2$NamesId)
table2$NamesId = gsub("_", "", table2$NamesId)
table2$NamesId = gsub(".csv", "", table2$NamesId)
table2$Packs = as.numeric(gsub(" :", "", table2$Packs))
table2$NetWeight = as.numeric(gsub(",", "", table2$NetWeight))
table2$BatchNumber = gsub("L ", "", table2$BatchNumber)

### Table 4 - Packing List
table40 = do.call(rbind, mget(ls(pattern = "packing4.csv")))
table41 = do.call(rbind, mget(ls(pattern = "packing4_[0-9].csv")))
table42 = do.call(rbind, mget(ls(pattern = "packing4_[0-9][0-9].csv")))
table4 = rbind(table40, table41)
table4 = rbind(table4, table42)

table4$NamesId = rownames(table4)
table4$NamesId = gsub("packing4", "", table4$NamesId)
table4$NamesId = gsub("_", "", table4$NamesId)
table4$NamesId = gsub(".csv", "", table4$NamesId)
table4$NamesId = gsub(" ", "1", table4$NamesId)
table4$TotalGrossWeight = gsub(" KG", "", table4$TotalGrossWeight)
table4$TotalGrossWeight = gsub(",", "", table4$TotalGrossWeight)
table4$TotalGrossWeight = gsub("' ", "", table4$TotalGrossWeight)
table4$TotalGrossWeight = as.numeric(table4$TotalGrossWeight)


