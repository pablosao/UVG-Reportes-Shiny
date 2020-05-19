#
#           UVG-Reportes-COVID-19
#
#   Creado por: Juan Fernando De Leon Quezada
#
#   Descripcion: Shiny Dashboard
#
#   Fecha: 19/05/2020
#

library(shiny)
library(shinydashboard)


ui <- dashboardPage(
    dashboardHeader(title= "Reportes COVID-19 UVG"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("General", tabName = "general", icon = icon("chart-pie")),
            menuItem("Casos", tabName = "cases", icon = icon("caret-right")),
            menuItem("Afectados", tabName = "afected", icon = icon("caret-right")),
            menuItem("Regiones", tabName = "regions", icon = icon("caret-right")),
            menuItem("Sintomas Comunes", tabName = "symptoms", icon = icon("caret-right"))
        )
    ),
    dashboardBody(
        tabItems(
            tabItem("general",
                    fluidPage(
                        h1("General"),
                        br(),
                        box(plotOutput("correlation_plot"), width = 8),
                        box(selectInput("features", "Features:",
                                        c("Sepal.Width", "Petal.Length", "Petal.Width")),
                            width = 4
                        )
                    )
            ),
            tabItem("cases",
                    fluidPage(
                        h1("Casos")
                    )
            ),
            tabItem("afected",
                    fluidPage(
                        h1("Afectados")
                    )
            ),
            tabItem("regions",
                    fluidPage(
                        h1("Regiones")
                    )
            ),
            tabItem("symptoms",
                    fluidPage(
                        h1("Sintomas Comunes")
                    )
            )
        )
    )
)

server <- function(input, output){
    output$correlation_plot <- renderPlot({
        plot(iris$Sepal.Length, iris[[input$features]], xlab = "Sepal length", ylab = "Features")
    })
}

shinyApp(ui, server)