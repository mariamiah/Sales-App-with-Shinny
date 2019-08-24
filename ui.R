# load shiny dashboard
library(shinydashboard)

shinyUI(dashboardPage(
  # Dashboard header carrying the title of the dashboard
  header <- dashboardHeader(title = "Sales Dashboard"),
  # Side bar content of the dashboard
  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName="overview", icon=icon("dashboard")),
      menuItem("Detailed", tabName="Detailed", icon=icon("send", lib="glyphicon"))
    )
  ),
  # Body content of the dashboard
  body <- dashboardBody(
    tabItems(
      tabItem(tabName = "overview",
              h2("Sales overview"),
              # contains quick summaries
              frow1 <- fluidRow(
                valueBoxOutput("value1"),
                valueBoxOutput("value2"),
                valueBoxOutput("value3")
              ),
              # contains graphical plots
              frow2 <- fluidRow(
                box(
                  title = "Sales per product",
                  status = "primary",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  plotOutput("SalesbyProd", height = "300px")
                ),
                box(
                  title = "Sales per order status",
                  status = "primary",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  plotOutput("salesbyorderstatus", height= "300px")
                )
                
              )
      ),
      tabItem(tabName = "Detailed",
              h2("Sales detailed analysis"),
              box(title = "sales info", status="primary", plotOutput("plot", height=350)),
              box(
                title = "Inputs", status = "warning",
                "Box content here", br(), "More box content",
                selectInput(
                  inputId = "var1", label="select the x variable",
                  choices = c("salesdetails.QUANTITY"=1, "salesdetails.PRICEEACH"=2, "salesdetails.SALES"=3), selected=1
                ),
                selectInput(inputId="var2", label="select the Y variable", choices = c("salesdetails.QUANTITY"=1, "salesdetails.PRICEEACH"=2,
                                                                                       "salesdetails.SALES"=3), selected = 1)
              )
      )
    )
  ),
  skin="purple"
))
