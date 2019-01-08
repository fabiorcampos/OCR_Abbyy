### Format Invoice Main Table
inv0 = do.call(rbind, mget(ls(pattern = "invoice.csv")))
inv1 = do.call(rbind, mget(ls(pattern = "invoice_[0-9].csv")))
inv2 = do.call(rbind, mget(ls(pattern = "invoice_[0-9][0-9].csv")))
inv = rbind(inv0, inv1)
inv = rbind(inv, inv2)

inv$fletemaritimo = gsub(",", "", inv$fletemaritimo)
inv$fletemaritimo = as.numeric(inv$fletemaritimo)

inv$GrossWeight = gsub(" KG", "", inv$GrossWeight)
inv$GrossWeight = gsub(" kg", "", inv$GrossWeight)
inv$GrossWeight = gsub(",", "", inv$GrossWeight)
inv$GrossWeight = as.numeric(inv$GrossWeight)

colnames(inv)[colnames(inv)=="ROW_INDEX"] = "Invoice_ROW_INDEX"
inv$NamesId = rownames(inv)
inv$NamesId = gsub(".csv", "", inv$NamesId)

table_inv0 = do.call(rbind, mget(ls(pattern = "RepeatingGroup.csv")))
table_inv0$NamesId = rownames(table_inv0)

table_inv0$NamesId = gsub("/RepeatingGroup.csv", "", table_inv0$NamesId)

table_inv = merge(inv, table_inv0, by = "NamesId", all = TRUE, sort = TRUE)

table_inv$PrecioUnitario = gsub(",", "", table_inv$PrecioUnitario)
table_inv$PrecioUnitario = as.numeric(table_inv$PrecioUnitario)

table_inv$ValorUSD = gsub(",","", table_inv$ValorUSD)
table_inv$ValorUSD = as.numeric(table_inv$ValorUSD)

table_inv$CantidadTotalNeta = gsub(",","", table_inv$CantidadTotalNeta)
table_inv$CantidadTotalNeta = as.numeric(table_inv$CantidadTotalNeta)

table_inv$total = gsub(",","", table_inv$total)
table_inv$total = as.numeric(table_inv$total)


