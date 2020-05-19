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
library(RPostgreSQL)
library(DT)
library(ECharts2Shiny)

#Coneccion a DB DUMMY

db <- 'preportes'

host_db <- 'covid-19.westus2.cloudapp.azure.com'

db_port <- '5432'

db_user <- 'reportes'

db_password <- 'SDex2020'

con <- dbConnect(RPostgres::Postgres(), dbname = db, host=host_db, port=db_port, user=db_user, password=db_password)

casosPorMunicipio <- dbGetQuery(con, "select b.descripcion as pais,c.descripcion as municipio,a.caso_confirmado,count(a.codigo_solicitud) as cantidad_registrados from solicitud as a inner join pais as b on a.codigo_pais = b.codigo_pais inner join municipio as c on a.codigo_municipio = c.codigo_municipio group by b.descripcion,c.descripcion,a.caso_confirmado order by c.descripcion;")

cantDeSintomas <- dbGetQuery(con, "select b.descripcion ,count(a.codigo_sintoma) from sintomas_persona as a inner join tipo_sintoma as b on a.codigo_sintoma = b.codigo_sintoma group by b.descripcion;")

sexoVsCasos <- dbGetQuery(con, "select case sexo when 'F' then 'Femenino' when 'M' then 'Masculino' end as sexo,caso_confirmado,count(codigo_solicitud) from solicitud group by sexo,caso_confirmado order by sexo;")

print(cantDeSintomas)

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
                        hr(),
                        h3("Casos por Municipio"),
                        DT::dataTableOutput("cpm"),
                        h3("Cantidad de Sintomas"),
                        tags$div(id="test", style="width:50%;height:400px;"),
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
    renderBarChart(div_id = "test", grid_left = '1%', direction = "horizontal", data = cantDeSintomas)
}

shinyApp(ui, server)