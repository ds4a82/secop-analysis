require(readxl)
require(data.table)

d <- readRDS(parameters$data_filename)

# Categories
for (i in 1:length(parameters$cats_)) { # i = 2
  d[[paste0("cat", i, "_")]] <- d[[parameters$cats_[i]]]
  d[[parameters$cats_[i]]] <- NULL
}

# Numeric values
for (i in 1:length(parameters$nums_)) { # i = 2
  d[[paste0("num", i, "_")]] <- d[[parameters$nums_[i]]]
  d[[parameters$nums_[i]]] <- NULL
}

# Date
for (i in 1:length(parameters$date_)) { # i = 2
  d[[paste0("date", i, "_")]] <- d[[parameters$date_[i]]]
  d[[parameters$date_[i]]] <- NULL
}

