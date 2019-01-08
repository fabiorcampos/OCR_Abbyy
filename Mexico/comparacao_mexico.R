### Check Table Gross Weight
GrossWeight = if(sum(Invoice$GrossWeight, na.rm = TRUE) == sum(PackingList$TotalGrossWeight, na.rm = TRUE)) {
  print("Peso ok")
} else {
  print("Peso divergente")
}

gross_inv = sum(Invoice$GrossWeight, na.rm = TRUE)
gross_pl = sum(PackingList$TotalGrossWeight, na.rm = TRUE)

### Check Table Net Weight
NetWeight = if(sum(Invoice$CantidadTotalNeta, na.rm = TRUE) == sum(PackingList$NetWeight, na.rm = TRUE)) {
  print("Peso OK")
} else {
  print("Peso divergente")
}

net_inv = sum(Invoice$CantidadTotalNeta, na.rm = TRUE)
net_pl = sum(PackingList$NetWeight, na.rm = TRUE)

### Create Check Data.frame
checkdf = data.frame(PesoBrutoInvoice = gross_inv, PesoBrutoPackingList = gross_pl, CheckGross = GrossWeight,
                     PesoLiquidoInvoice = net_inv, PesoLiquidoPackingList = net_pl, CheckNet = NetWeight)

### comparar a somatória do valor total de cada item da fatura com o valor total do embarque menos o frete maritimo
a = sum(Invoice$total, na.rm = TRUE)
b = sum(Invoice$fletemaritimo, na.rm = TRUE)
c = a - b
d = sum(Invoice$ValorUSD, na.rm = TRUE)

ValorItem = ifelse(d == c, print("Valor Total OK"),print("Valor Total divergente"))

valor_item_inv = sum(Invoice$ValorUSD, na.rm = TRUE)
valor_total_inv = sum(Invoice$total, na.rm = TRUE) - sum(Invoice$fletemaritimo, na.rm = TRUE)

ValorItem_df = data.frame(ValorItemUsd = valor_item_inv, ValorInvoiceUsd = valor_total_inv, Conferencia = ValorItem)

### Somar o total de Packs do Packing List

packs = sum(PackingList$Packs, na.rm = TRUE)
packs = data.frame(QuantidadePacks = packs)

### Dividir o texto PalletsIncluding do Packing List ### VERIFICAR SE É POSSÍVEL

### Comparar a quantidade da invoice x peso liquido packing list
pesoliq_cod_invoice = aggregate(CantidadTotalNeta ~ lote, Invoice, sum)
pesoliq_cod_packinglist = aggregate(NetWeight ~ BatchNumber, PackingList, sum)
check_pesoliq_cod = cbind(pesoliq_cod_invoice, pesoliq_cod_packinglist)
check_pesoliq_cod$Conferencia = ifelse(check_pesoliq_cod$CantidadTotalNeta == check_pesoliq_cod$NetWeight,
                                       print("Quantidade por Lote OK"),
                                       print("Quantidade por Lote Divergente")
) 

checkdf$PesoBrutoInvoice = format(checkdf$PesoBrutoInvoice, decimal.mark = ",", big.mark = ".")
checkdf$PesoBrutoPackingList = format(checkdf$PesoBrutoPackingList, decimal.mark = ",", big.mark = ".")
checkdf$PesoLiquidoInvoice = format(checkdf$PesoLiquidoInvoice, decimal.mark = ",", big.mark = ".")
checkdf$PesoLiquidoPackingList = format(checkdf$PesoLiquidoPackingList, decimal.mark = ",", big.mark = ".")

Invoice$fletemaritimo = format(Invoice$fletemaritimo, decimal.mark = ",", big.mark = ".")
Invoice$netoantesdeimpuesto = format(Invoice$netoantesdeimpuesto, decimal.mark = ",", big.mark = ".")
Invoice$total = format(Invoice$total, decimal.mark = ",", big.mark = ".")
Invoice$GrossWeight = format(Invoice$GrossWeight, decimal.mark = ",", big.mark = ".")
Invoice$PrecioUnitario = format(Invoice$PrecioUnitario, decimal.mark = ",", big.mark = ".")
Invoice$ValorUSD = format(Invoice$ValorUSD, decimal.mark = ",", big.mark = ".")

PackingList$GrossWeight = format(PackingList$GrossWeight, decimal.mark = ",", big.mark = ".")
PackingList$NetWeight = format(PackingList$NetWeight, decimal.mark = ",", big.mark = ".")
PackingList$TotalGrossWeight = format(PackingList$TotalGrossWeight, decimal.mark = ",", big.mark = ".")