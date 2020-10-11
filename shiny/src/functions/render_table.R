require(DT)
render_tables <- function(data, currency = NULL, percentage = NULL, round = NULL, dom = 'ftirp'){
  DT::renderDataTable(expr = {
    if(!is.null(currency)){
      currency <- currency[currency %in% colnames(data())]
    } else if(!is.null(percentage)){
      percentage <- percentage[percentage %in% colnames(data())]
    } else if(!is.null(round)){
      round <- round[round %in% colnames(data())]
    }
    
    DT::datatable(data()
              , rownames = FALSE
              , escape = FALSE
              , options = list(
                pageLength = 25
                , dom = dom
                , scrollX = TRUE
                
              ) # Reference for dom: https://datatables.net/reference/option/dom
    ) %>%
      formatCurrency(currency, digits = 0) %>%
      formatPercentage(percentage, digits = 1) %>%
      formatRound(round, digits = 0)
  }, options = list(
    lengthChange = TRUE
  ))
}
