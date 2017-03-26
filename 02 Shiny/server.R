require(dplyr)
require(ggplot2)
require("tidyr")
require("dplyr")
require("ggplot2")
require("jsonlite")
require("RCurl")
require("grid")

# call in data from data.world
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",'oraclerest.cs.utexas.edu:5000/rest/native/?query="select * from pantheria"')),httpheader=c(DB='jdbc:data:world:sql:jlee:s-17-edv-project-3', USER='jlee', PASS=redacted , MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE) ))

# df <- read.csv("https://query.data.world/s/12gav2q7y7l3ustgkagav5rkp",header=T);

server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(df) + geom_point(aes(x=X17.1_MaxLongevity_m, y=X23.1_SexualMaturityAge_d, color=MSW05_Order, size=4)) + guides(size=FALSE) # guides is the legend, cuz size will become a legend, so you wanna turn it off
  })
  
  output$plot2 <- renderPlot({
    brush = brushOpts(id="plot_brush", delayType = "throttle", delay = 30)
    bdf=brushedPoints(df, input$plot_brush)
    # View(bdf)
    if( !is.null(input$plot_brush) ) {
      df %>% dplyr::filter(X17.1_MaxLongevity_m %in% bdf[, "X17.1_MaxLongevity_m"]) %>% ggplot() + geom_point(aes(x=X17.1_MaxLongevity_m, y=X23.1_SexualMaturityAge_d, color=MSW05_Order, size=4)) + guides(size=FALSE)
    } 
  })
}