library(dplyr)
library(reshape)
library(reshape2)
library(xlsx)
library(r2excel)

### Local  
setwd("C:/Users/Spock/Downloads/teste_abbyy/teste_abbyy") 

### Generate csv list  
file.list = list.files(pattern = "*.csv", recursive = TRUE) 

### Loop Function to read each file as data.frame.  
for (i in 1:length(file.list)){
  
  assign(file.list[i], 
         
         read.csv(file.list[i], sep=",", header = TRUE, stringsAsFactors = FALSE)
         
         
  )}

### Load Packing Script
source("packing_mexico.R")

### Merge Packing List - Data.frame
PackingList = merge(pl, table2, by="NamesId", sort = TRUE, all = TRUE)
PackingList = merge(PackingList, table4, by="NamesId", sort = TRUE, all = TRUE)

### Load Invoice Script
source("invoice_mexico.R")

### Invoice Load
Invoice = table_inv
Invoice = Invoice[,-c(1,2,10)]

### Comparação script
source("comparacao_mexico.R")

### Clean Script
source("clean_mexico.R")

### Export FIles
filename = "output.xlsx"
wb = createWorkbook(type="xlsx")
# Create a sheet in that workbook to contain the data table
sheet1 = createSheet(wb, sheetName = "Planilha de Conferência")

# Check Peso Bruto e Peso Líquido - Invoice x Packing List
xlsx.addHeader(wb, sheet1, value="Peso Bruto e Peso Líquido - Invoice x Packing List",level=3, 
               color="black", startCol = 1)
xlsx.addLineBreak(sheet1, 1)
xlsx.addTable(wb, sheet1, checkdf, startCol=1)
xlsx.addLineBreak(sheet1, 2)

# Check Valor dos Itens x Valor Total Fatura
xlsx.addHeader(wb, sheet1, value="Valor total dos itens x Valor total das Invoices",level=3, 
               color="black", startCol = 1)
xlsx.addLineBreak(sheet1, 1)
xlsx.addTable(wb, sheet1, ValorItem_df, startCol=1)
xlsx.addLineBreak(sheet1, 2)

# Comparar quantidade net na invoice com a quantidade no packing list por lote
xlsx.addHeader(wb, sheet1, value="Quantidade Net na Invoice x Peso Líquido Packing List (Por Lote)",level=3, 
               color="black", startCol = 1)
xlsx.addLineBreak(sheet1, 1)
xlsx.addTable(wb, sheet1, check_pesoliq_cod, startCol=1)
xlsx.addLineBreak(sheet1, 2)
xlsx.addTable(wb, sheet1, pesoliq_cod_invoice, startCol=1)
xlsx.addLineBreak(sheet1, 2)
xlsx.addTable(wb, sheet1, pesoliq_cod_packinglist, startCol=1)

# Somar Packs
xlsx.addHeader(wb, sheet1, value="Packs",level=3, 
               color="black", startCol = 1)
xlsx.addLineBreak(sheet1, 1)
xlsx.addTable(wb, sheet1, packs, startCol=1)
xlsx.addLineBreak(sheet1, 2)

# Sheet2
sheet2 = createSheet(wb, sheetName = "Invoice")
xlsx.addTable(wb, sheet2, Invoice, startCol=1)

# Sheet3
sheet3 = createSheet(wb, sheetName = "Packing List")
xlsx.addTable(wb, sheet3, PackingList, startCol=1)

# save the workbook to an Excel file
saveWorkbook(wb, filename)
xlsx.openFile(filename)# View the file



