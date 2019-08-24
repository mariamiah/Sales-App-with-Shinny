# load shiny library
library(shiny)
library(magrittr)
library(dplyr)
library(ggplot2)
salesdetails <- read.csv("/Users/mariah/Rpractice/ShinyAPP/sales_data_sample.csv")

# create the server functions for the dashboard
shinyServer(
  function(input, output){
    # some data manipulation to derive the values of KPI boxes
    total.sale <- sum(salesdetails$SALES)
    sales.country <- salesdetails %>% group_by(COUNTRY) %>% summarise(value=sum(SALES)) %>% filter(value == max(value))
    sales.prod <- salesdetails %>% group_by(PRODUCTLINE) %>% summarise(value=sum(SALES)) %>% filter(value == max(value))
    # creating the value box output content
    output$value1 <- renderValueBox({
      valueBox(
        formatC(sales.country$value, format="d", big.mark = ','),
        paste('Top country:', sales.country$COUNTRY),
        icon = icon("stats", lib="glyphicon"),
        color = "red"
      )
    })
    output$value2 <- renderValueBox({
      valueBox(
        formatC(total.sale, format="d", big.mark=','),
        'Total Sales',
        icon = icon("usd", lib="glyphicon"),
        color = "green"
      )
    })
    # creating the plot output content
    output$SalesbyProd <- renderPlot({
      ggplot(data = salesdetails,
             aes(x=PRODUCTLINE, y=SALES, fill=factor(YEAR_ID))) +
        geom_bar(position = "dodge", stat="identity") + ylab("sales(USD)") + xlab("Product")+
        theme(legend.position = "bottom", plot.title = element_text(size=15, face="bold")) +
        ggtitle("sales by product") + labs(fill = "year")
      
    })
    output$salesbyorderstatus <- renderPlot({
      ggplot(data = salesdetails,
             aes(x=STATUS, y=SALES, fill=factor(PRODUCTLINE))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Sales(USD)") +
        xlab("status") + theme(legend.position="bottom",
                               plot.title = element_text(size=15, face="bold")) +
        ggtitle("Sales by Order status") + labs(fill = "Products")
    })
  }
)
