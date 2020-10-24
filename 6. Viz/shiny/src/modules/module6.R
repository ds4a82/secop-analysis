module6UI <- function(id){
  ns <- NS(id)
  main <- list(""
    , br()
    , br()
    , br()
    , fluidRow(
       ""
        , HTML('<div style="overflow:hidden;position: relative;"><iframe frameborder="0" scrolling="no" marginheight="0" marginwidth="0"width="104" height="443" type="text/html" src="https://www.youtube.com/embed/v_3NCu6v4ew?autoplay=0&fs=1&iv_load_policy=3&showinfo=0&rel=0&cc_load_policy=0&start=0&end=0"></iframe><div style="position: absolute;bottom: 10px;left: 0;right: 0;margin-left: auto;margin-right: auto;color: #000;text-align: center;"><small style="line-height: 1.8;font-size: 0px;background: #fff;"> <a href="https://deloge.de/" rel="nofollow">Deloge</a> </small></div><style>.newst{position:relative;text-align:right;height:900px;width:100%;} #gmap_canvas img{max-width:none!important;background:none!important}</style></div><br />')
     )
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module6 <- function(input, output, session){
  
}