#
#           UVG-Reportes-COVID-19
#
#   Creado por: Juan Fernando De Leon Quezada
#   Descripcion: Shiny Dashboard
#   Fecha: 19/05/2020
#
#   Modifico: Pablo Sao
#   Fecha: 31-05-2020
#   Descripción: Se incorpora filtro de fecha, y actualización de datos de la gráfica
#                de sintomas reportados
#

library(dplyr)
library(shiny)
library(shinydashboard)
library(RPostgreSQL)
library(DT)
library(ECharts2Shiny)
#install.packages("ini")
library(ini)
source("queryManager.R")
library(plotly)

# PSAO / 19-05-2020 / Ser cargan datos de conexion configurado en archivo .ini
datosConexion <- read.ini('conexion.ini')

# PSAO / 19-05-2020 / Se configuran credenciales de DB a partir de archivo .ini a DB
db <- datosConexion$db_conexion$db  
host_db <- datosConexion$db_conexion$host 
db_port <- datosConexion$db_conexion$port 
db_user <- datosConexion$db_conexion$user 
db_password <- datosConexion$db_conexion$password 

# Realizando conexion a DB
con <- dbConnect(RPostgres::Postgres(), dbname = db, host=host_db, port=db_port, user=db_user, password=db_password)

# PSAO / 19-05-1010 / Se agrega llamado a funcion para obtener querys
casosPorMunicipio <- dbGetQuery(con, getCasos_MunicipioDummy())
#cantDeSintomas <- dbGetQuery(con, getCantidad_SintomasDummy())
sexoVsCasos <- dbGetQuery(con,getCasos_SexoDummy() )

ui <- dashboardPage(
    title = "Reportes COVID-19",
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
        tags$head(
            tags$style(HTML('
              .skin-blue .main-header .navbar{
                background-color: #21822b;
              }
              .skin-blue .main-header .logo{
                background-color: #21822b;
              }
              .skin-blue .sidebar-menu > li.active > a, .skin-blue .sidebar-menu > li:hover > a{
                border-left-color: #21822b;
              }
              .skin-blue .left-side, .skin-blue .main-sidebar, .skin-blue .wrapper {
                background-color: #3b3a3b;
              }
        '))
        ),
        tabItems(
            tabItem("general",
                    fluidPage(
                        h1("General"),
                        hr(),
                        # PSAO / 31-05-2020 / Se agrega filtro de rango de fechas
                        box(
                            dateRangeInput('RangoFechas',
                                           label = 'Rango de Fechas',
                                           start = as.Date('2020-05-12') , end = as.Date('2020-05-13')
                            ),
                            width = 15
                        ),
                        
                        # PSAO / 31-05-2020 / Se colocan dos gráficas por columna
                        fluidRow(
                            column(6,
                                   # PSAO / 19-05-2020 / se cambia por grafica de plotly
                                   plotlyOutput("Gsintomas_reportados", height = "600px")
                            ),
                            
                            column(6,
                                   plotOutput('sexvscases')
                            )
                        ),
                        
                        h3("Casos por Municipio"),
                        box(
                            DT::dataTableOutput("cpm"),
                            width = 15
                        ),
                        #h3("Síntomas Reportados"),
                        #box(
                            # PSAO / 19-05-2020 / se cambia por grafica de plotly
                        #    plotlyOutput("Gsintomas_reportados", height = "600px"),
                        #    width = 15
                        #),
                        #h3("Cantidad de por Sexo"),
                        #box(
                        #    plotOutput('sexvscases'), 
                        #    width = 15,
                        #)
                        
                        
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
    output$cpm = DT::renderDataTable({
        casosPorMunicipio
    })
    
    # PSAO / 19-05-2020 / se agrega libreria de plotly para graficas
    output$Gsintomas_reportados <- renderPlotly({
        
        # PSAO / 31-05-2020 / Agregando actualización segun rango de fechas seleccioando
        cantDeSintomas <- dbGetQuery(con, getCantidad_Sintomas(input$RangoFechas[1],input$RangoFechas[2]))
        
        Gsintomas_reportados <- plot_ly(
            cantDeSintomas, x = ~descripcion, y = ~cantidad,type = "bar",
            marker = list(
                color = 'rgb(30,144,255)'
            ) 
        )
            
            # Seteamos el layout de la grafica
            Gsintomas_reportados <- Gsintomas_reportados %>% layout(title = "",
                              xaxis = list(title = "Síntomas"),
                              yaxis = list(title = "Cantidad de Personas que Reportaron"))
    })
    
    
    
    output$sexvscases <- renderPlot({
        pie(sexoVsCasos$cantidad, labels = c("Femenino", "Femenino Confirmado", "Masculino", "Masculino Convirmado"), main = "Sexo Vs Casos")
    })
    
}

shinyApp(ui, server)