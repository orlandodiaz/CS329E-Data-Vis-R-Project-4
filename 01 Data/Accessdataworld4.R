require("tidyr")
require("dplyr")
require("ggplot2")
require("jsonlite")
require("RCurl")
require("grid")

# call in data from data.world
redacted <- 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50OmpsZWUiLCJpc3MiOiJhZ2VudDpqbGVlOjphYTAxYzZmMi1hMTBhLTRhYzQtOTU3Yi1lZmQwNDM4OTI0YzAiLCJpYXQiOjE0ODQ2OTcyMjcsInJvbGUiOlsidXNlcl9hcGlfd3JpdGUiLCJ1c2VyX2FwaV9yZWFkIl0sImdlbmVyYWwtcHVycG9zZSI6dHJ1ZX0.gnpazqWHViw7QcLMWccGADp4i8rmzRFwx7tp3OknW0T4q9JhJFKP46h-mQJL1GKku9rnHN8dXJGQ_WbFPfJiLw'

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",'oraclerest.cs.utexas.edu:5060/rest/native/?query="select * from Pantheria"')),httpheader=c(DB='jdbc:data:world:sql:ehjkim:s-17-dv-project-4', USER='jlee', PASS=redacted , MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE) ))

# display summary, head, and subset of the dataframe
print(summary(df))
print(head(df))
print(subset(df))