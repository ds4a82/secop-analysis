require(data.table)

d <- readRDS(parameters$data_filename)
nums_ <- parameters$nums_
cats_ <- parameters$cats_
date_ <- parameters$date_
  
# Categories
for (i in 1:length(parameters$cats_)) { # i = 2
  setnames(x = d, old = parameters$cats_[i], new = paste0("cat", i, "_"))
}

# Numeric values
for (i in 1:length(parameters$nums_)) { # i = 2
  setnames(x = d, old = parameters$nums_[i], new = paste0("num", i, "_"))
}

# Date
setnames(x = d, old = parameters$date_, new = "date_")

# Grouping of date to use in the filter
d[!is.na(date_), Weekly := paste0(year(date_), "-", ifelse(isoweek(date_) < 10, "0", ""), isoweek(date_))]
d[!is.na(date_), Monthly := paste0(year(date_), "-", ifelse(month(date_) < 10, "0", ""), month(date_))]
d[!is.na(date_), Quarterly := paste0(year(date_), "-", quarter(date_))]
d[!is.na(date_), Yearly := year(date_)]
