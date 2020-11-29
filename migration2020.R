library(data.table) 
root <- "~/../../Dropbox/My PC (LAPTOP-7NO9SE3D)/Downloads/" 
Visitor_departure_totals <- fread(paste0(root, "ITM330901_20201127_123438_94.csv")) 
Visitor_arrival_totals <- fread(paste0(root, "ITM330701_20201127_123734_81.csv")) 
Total_passenger_movements <- fread(paste0(root, "ITM332201_20201127_124127_73.csv")) 
 
nz_arrival <- fread(paste0(root, "ITM551901_20201127_125139_52.csv")) # NZ_resident_traveller_arrivals_by_closest_overseas_port 
nz_arrival[, V1 := paste0(V1, "-01")]; nz_arrival[, V1 := as.Date(V1, "%YM%m-%d")]; 
setnames(nz_arrival, as.character(nz_arrival[2])); setnames(nz_arrival, "NA", "DATE") 
nz_arrival <- nz_arrival[!is.na(DATE)]; nz_arrival <- nz_arrival[DATE > "2019-01-01"] 
incoming_kiwi <- melt(nz_arrival, id.vars = "DATE", variable.name = "ClosestOverseasPort", value.name = "IncomingKiwi") 
incoming_kiwi[, IncomingKiwi := as.numeric(IncomingKiwi)] 
incoming_kiwi[, YEAR := year(DATE)]; incoming_kiwi[, MONTH := month.name[month(DATE)]] 
 
incoming_kiwi[, sum(IncomingKiwi), by = .(YEAR, MONTH)] 
         
