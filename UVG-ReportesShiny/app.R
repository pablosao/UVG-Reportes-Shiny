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
library(leaflet)
library(viridis)
library(rworldmap)
library(maps)
library(ggmap)
read.csv("~/covid27.csv") -> data
data$Province.State <- lapply(data$Province.State, as.character)

str(data$Province.State)

data$Country.Region<- lapply(data$Country.Region, as.character)

key = "AIzaSyB8hwaB2EEOsucgdc80NCaGp7p7XiSPBvQ" #please use your own API key, I have input the key previously.
register_google(key=key)

#obtain the coordinates
country <- data$Country.Region
cities <- data$Province.State
#use lapply to iterate and obtain the coordinates information.
loc1 <- do.call(rbind, lapply(cities, function(x) geocode(x))) 
loc1 <- as.data.frame(loc1)
loc2 <- do.call(rbind, lapply(country, function(x) geocode(x))) 
loc2 <- as.data.frame(loc2)

#create them as data.frame
as.data.frame(data[,1:2]) -> data2
data2$lon <- ifelse(data2[,1]== "", loc2[,1], loc1[,1])
data2$lat <- ifelse(data2[,1]== "", loc2[,2], loc1[,2])
data2 <- data.frame(data2, Confirmed=data$Confirmed, Deaths=data$Deaths, Recovered= data$Recovered)





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
                        h1("Regiones"),
                        plotlyOutput("p", height = "600px")
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
    output$p <- renderPlotly({
        #static map with ggplot
        world  <- map_data("world")
        
        g <- data2 %>%
            arrange(Confirmed) %>% 
            mutate( name=factor(Country.Region, unique(Country.Region))) %>% 
            ggplot() +
            geom_polygon(data = world, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
            geom_point( aes(x=lon, y=lat, size=Confirmed, color=Confirmed), alpha=0.4) +
            scale_size_continuous(range=c(1,10)) +scale_color_viridis (trans="log") +
            ggtitle("Coronavirus outbreak until
    27 Jan 2020")  + theme(plot.title =
                               element_text(size = 10, face =
                                                "bold"), legend.title =
                               element_text(size = 15), legend.text
                           = element_text(size = 10))+
            coord_map()
        
        
        #interactive map with plotly
        #mutate the data, so the country/cities can be viewed when you hover the region
        
        
        
        data2$New.R <- ifelse(data2[,1]== "", data2[,2], data2[,1])
        #it will replace the city that does not mention in the table with the country information
        
        data2n <- data2 %>%
            arrange(Deaths) %>%
            mutate(Country.Region=factor(New.R, unique(New.R))) %>%
            mutate( mytext=paste(
                "CountryOrCity: ", New.R, "\n", 
                "Confirmed: ", Deaths, sep=""))
        
        
        #this is actually still static
        p <- data2n %>%
            ggplot() +
            geom_polygon(data = world, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
            geom_point(aes(x=lon, y=lat, size=Confirmed, color=Confirmed, text=mytext, alpha=0.5) ) +
            scale_size_continuous(range=c(1,15)) +
            scale_color_viridis(option="inferno", trans="log" ) +
            scale_alpha_continuous(trans="log") +
            theme_void() +
            coord_map() +
            theme(legend.position = "none")
        #to make it as an interactive map    
        p <- ggplotly(p, tooltip="text")
    })
    
}

shinyApp(ui, server)