
module2UI <- function(id){
  ns <- NS(id)
  # This makes web page load the JS file in the HTML head.
  # The call to singleton ensures it's only included once
  # in a page. It's not strictly necessary in this case, but
  # it's good practice.
  
  perspective <- radioButtons(
    inputId = ns("perspective")
    , label = h4("Category")
    , choices = cats_[1:3]
    , selected = cats_[1]
    # , inline = TRUE
    # , selectize = TRUE
  )
  insight <- radioButtons(
    # insight <- selectInput(
    inputId = ns("insight")
    , label = h4("Metric")
    , choices = c("Count", nums_)
    , selected = nums_[1]
    # , inline = TRUE
  )
  bar <- radioButtons(
    # bar <- selectInput(
    inputId = ns("bar")
    , label = h4("Period")
    , choices = c("Weekly", "Monthly", "Quarterly", "Yearly")
    , selected = c("Yearly")
    # , selectize = TRUE
    # , inline = TRUE
  )
  main <- list(""
               , fluidRow(""
                          , crm_filtrosUI(ns("crm_filtros"))
                          , column(width = 4
                                   , valueBoxOutput(ns("box1"), width = 12)
                                   , valueBoxOutput(ns("box2"), width = 12)
                                   , valueBoxOutput(ns("box3"), width = 12)
                          )
                          , column(
                            width = 4
                            , valueBoxOutput(ns("box4"), width = 12)
                            , valueBoxOutput(ns("box5"), width = 12)
                            , valueBoxOutput(ns("box6"), width = 12)
                          )
               )
               , fluidRow(
                 box(plotlyOutput(ns("circle"))
                     , box(perspective, title = NULL, footer = NULL, width = 6, height = NULL, status = "primary")
                     , box(insight, title = NULL, footer = NULL, width = 6, height = NULL, status = "primary")
                     , title = "Contratos", footer = NULL, width = 6, height = NULL, status = "primary")
                 , box(plotlyOutput(ns("bar_chart"))
                       , box(bar, title= NULL, footer = NULL, width = 12, height = NULL, status = "primary")
                       , title = "Firmas de contratos", footer = NULL, width = 6, height = NULL, status = "primary")
               )
               , fluidRow(
                 tabBox(id = "gerencia_tabs"
                        , title = 'Tablas'
                        , tabPanel("All"
                                   , DT::dataTableOutput(ns("table0"))
                        )
                        , tabPanel(cats_[1]
                                   , DT::dataTableOutput(ns("table1"))
                        )
                        , tabPanel(cats_[2]
                                   , DT::dataTableOutput(ns("table2"))
                        )
                        , tabPanel(cats_[3]
                                   , DT::dataTableOutput(ns("table3"))
                        )
                        , width = 12)
               ) 
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module2 <- function(input, output, session){
  logic <- callModule(crm_filtros, "crm_filtros")
  
  
  # ValueBox 1
  output$box1 <- renderBox("Number of Contracts", "file-contract", "green", reactive({
    format(d[logic(), length(cat4_)], digits = 0, big.mark = ",")
  }))
  
  # ValueBox 2
  output$box2 <- renderBox(sprintf("Total Contract Value", nums_[1]), "dollar", "red", reactive({
    comprss(d[logic(), sum(num1_, na.rm = T)])
  }))
  # ValueBox 3
  output$box3 <- renderBox("Average Contract Value", "line-chart", "purple", reactive({
    comprss(d[logic(), mean(num1_, na.rm = T)])
  }))
  
  # ValueBox 4
  output$box4 <- renderBox("Number of Providers", "users", "orange", reactive({
    format(d[logic(), length(unique(cat5_))], digits = 0, big.mark = ",")
  }))
  
  # ValueBox 5
  output$box5 <- renderBox("Average Contract per Provider", "hand-holding-usd", "navy", reactive({
    # Monthly mean
    comprss(d[logic(), sum(num1_, na.rm = T)/length(unique(cat5_))])
  }))
  
  # ValueBox 6
  output$box6 <- renderBox("Number of Departments", "globe-americas", "aqua", reactive({
    d[logic(), length(unique(cat2_))]
  }))
  
  t <- list(
    family = "source sans pro",
    size = 14,
    color = 'black')
  
  # PieChart:
  output$circle <- renderPlotly({
    
    label_ = input$perspective
    value_ = input$insight
    logic = logic()
    
    for(i in 1:length(cats_)){
      if(cats_[i] == label_){
        d$label_ <- d[[paste0("cat", i, "_")]]
        break
      }
    }
    ds <- d[logic(), .(
      count_ = .N
      , num1_ = sum(num1_, na.rm = T)
    ), keyby = label_]
    for (i in 1:(length(nums_)+1)) {
      if (value_ == "Count") {
        ds$value_ <- ds$count_
        break
      }
      if (nums_[i] == value_) {
        ds$value_ <- ds[[paste0("num", i, "_")]]
        break
      }
    }
    plot_ly(
      data = ds
      , labels = ~label_
      , values = ~value_
      , type = "pie"
      , hole = 0.5
      , text = ~paste0(
        nums_[1], ": ", comprss(`num1_`)
        , "<br>", "Count"," : ", count_
      )
      , textinfo = "percent" # "label+percent"
      , textposition = 'inside'
      , hoverinfo = "label+text+percent"
      , showlegend = F
    ) %>%
      layout(font = t, 
          yaxis = list(title = "", zeroline = FALSE, showline = FALSE, showticklabels = FALSE, showgrid = FALSE)
        , xaxis = list(title = "", zeroline = FALSE, showline = FALSE, showticklabels = FALSE, showgrid = FALSE)
      )
  })
  
  # Bar chart for financial forecast
  output$bar_chart <- renderPlotly({
    # timeframe <- "Semanal"
    timeframe <- input$bar
    d$timeframe_ <- d[[timeframe]]
    
    ds <- d[, .(
      count_ = .N
      , num1_ = sum(num1_, na.rm = T)
    ), keyby = timeframe_]
    ds <- d[logic(), .(
      count_ = .N
      , num1_ = sum(num1_, na.rm = T)
    ), keyby = timeframe_]
    plot_ly(
      data = ds
      , y = ~count_
      , x = ~timeframe_
      , name = "Count"
      , type = "bar"
      , hoverinfo = "text"
      # , hovertemplate = ~paste0(timeframe_, ': %{x}')
      , text = ~paste0(
        "Count: ", count_
        , "<br>Date: ", `timeframe_`
      )
    ) %>% add_trace( # Add margin line:
      y = ~num1_
      , name = nums_[1]
      , yaxis = "y2"
      , type = "scatter"
      , mode = "lines"
      , hoverinfo = "text"
      , text = ~paste0(
        nums_[1], ": ", comprss(num1_)
        , "<br>Date: ", `timeframe_`
      )
    ) %>% layout(font = t, 
      xaxis = list(title = "", zeroline = FALSE, showline = FALSE, showticklabels = FALSE, showgrid = FALSE)
      , yaxis = list(title = "", zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = FALSE)
      , yaxis2 = list(
        tickfont = list(color = "orange"),
        overlaying = "y",
        side = "right"
      )
      , barmode = "stack"
      , showlegend = TRUE
      , legend = list(orientation = 'h')
    )
    
  })
  
  output$table0 <- render_tables(
    data = reactive({
      x <- d[logic(), ]
      setnames(x = x, old = "cat1_", new = parameters$cats_[1])
      setnames(x = x, old = "cat2_", new = parameters$cats_[2])
      setnames(x = x, old = "cat3_", new = parameters$cats_[3])
      setnames(x = x, old = "num1_", new = parameters$nums_[1])
      setnames(x = x, old = "date_", new = parameters$date_)
      x
    })
    , currency = parameters$nums_[1]
  )

  output$table1 <- render_tables(
    data = reactive({
      x <- d[logic(), .(
        'Count' = .N
        , num1_ = sum(`num1_`, na.rm = T)
      ), keyby = `cat1_`]
      setnames(x = x, old = "cat1_", new = parameters$cats_[1])
      setnames(x = x, old = "num1_", new = parameters$nums_[1])
      x
    })
    , round = c("Count"), currency = parameters$nums_[1]
  )

  output$table2 <- render_tables(
    data = reactive({
      x  <- d[logic(), .(
        'Count' = .N
        , num1_ = sum(`num1_`, na.rm = T)
      ), keyby = `cat2_`]
      setnames(x = x, old = "cat2_", new = parameters$cats_[2])
      setnames(x = x, old = "num1_", new = parameters$nums_[1])
      x
    })
    , round = c("Count"), currency = parameters$nums_[1]
  )
  output$table3 <- render_tables(
    data = reactive({
      x <- d[logic(), .(
        'Count' = .N
        , num1_ = sum(`num1_`, na.rm = T)
      ), keyby = `cat3_`]
      setnames(x = x, old = "cat3_", new = parameters$cats_[3])
      setnames(x = x, old = "num1_", new = parameters$nums_[1])
      x
    })
    , round = c("Count"), currency = parameters$nums_[1]
  )
}