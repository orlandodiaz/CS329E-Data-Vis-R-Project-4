require(dplyr)
require(ggplot2)
require(tidyr)
require(ggplot2)
require(jsonlite)
require(RCurl)
require(grid)

# call in data from data.world
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",'oraclerest.cs.utexas.edu:5060/rest/native/?query="select * from Pantheria"')),httpheader=c(DB='jdbc:data:world:sql:ehjkim:s-17-dv-project-4', USER='franny', PASS=redacted , MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE) ))


server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(df) + geom_point(aes(x=v_22, y=v_27, color=v_0, size=4)) + guides(size=FALSE) + labs(x="Max Longevity (months)", y="Sexual Maturity Age (days)") + scale_color_discrete (guide=guide_legend(title = "Order"))
  })
  
  output$plot2 <- renderPlot({
    brush = brushOpts(id="plot_brush", delayType = "throttle", delay = 30)
    bdf=brushedPoints(df, input$plot_brush)
    # View(bdf)
    if( !is.null(input$plot_brush) ) {
      df %>% dplyr::filter(v_22 %in% bdf[, "v_22"]) %>% ggplot() + geom_point(aes(x=v_22, y=v_27, color=v_0, size=4)) + guides(size=FALSE) + labs(x="Max Longevity (months)", y="Sexual Maturity Age (days)") + scale_color_discrete (guide=guide_legend(title = "Order"))
    } 
  })
}