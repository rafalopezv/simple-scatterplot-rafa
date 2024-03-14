library(jsonlite)
library(stringr)

convert_to_js_objects <- function(data, file_path = NULL) {
  
  json_data <- toJSON(data, pretty = TRUE, auto_unbox = TRUE)
  
  
  js_array_of_objects <- gsub('"(\\w+)":', '\\1:', json_data)
  
  
  if (!is.null(file_path)) {
    writeLines(js_array_of_objects, file_path)
  }
  
  
  return(js_array_of_objects)
}

# example
gapminder::gapminder %>% 
  filter(year == 2007) %>% 
  ggplot(aes(gdpPercap, lifeExp)) +
  geom_point()
  convert_to_js_objects(file_path = "/Users/xlopra/Documents/svelte_course/simple-scatterplot-rafa/src/data/data.js") 




