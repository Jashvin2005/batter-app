# Load Packages
library(shiny)
library(tidyverse)
source("R/helper-functions.R")

# Load Data
batter = batting_data(directory = "data/daily-batting.csv")

ui = navbarPage(
  title = "Batter",
  tabPanel(
    title = "Input / Visualization",
    titlePanel(title = "Daily Batter Data: 2008 - 2024"),
    sidebarLayout(
      sidebarPanel(
        sliderInput(
          inputId = "season_range",
          label = "Select a Range of Seasons:",
          min = min(unique(batter$season)),
          max = max(unique(batter$season)),
          value = c(min(unique(batter$season)), max(unique(batter$season))),
          step = 1
        ),
        selectInput(
          inputId = "team",
          label = "Select Team:",
          choices = sort(unique(batter$Team))
        ),
        selectInput(
          inputId = "player",
          label = "Select Player:",
          choices = sort(unique(batter$Name))
        ),
        selectInput(
          inputId = "category",
          label = "Select Category:",
          choices = colnames(batter)[-(1:4)],
          selected = (colnames(batter)[-(1:4)])[1]
        )
      ),
      mainPanel(plotOutput("plot"))
    )
  ),
  tabPanel(
    title = "Table",
    dataTableOutput("table")
  ),
  tabPanel(title = "About", includeMarkdown("about.Rmd"))
)

server = function(input, output) {
  
  batter_season = reactive({
    batter %>%
      filter(season >= input$season_range[1]) %>%
      filter(season <= input$season_range[2])
  })
  
  observeEvent(
    eventExpr = input$season_range,
    handlerExpr = {
      updateSelectInput(
        inputId = "team",
        choices = sort(unique(batter_season()$Team)),
        selected = min(unique(batter_season()$Team))
      )
    }
  )
  
  batter_season_team = reactive({
    batter_season() %>%
      filter(Team == input$team)
  })
  
  observeEvent(
    eventExpr = {
      input$season_range
      input$team
    },
    handlerExpr = {
      updateSelectInput(
        inputId = "player",
        choices = sort(unique(batter_season_team()$Name)),
        selected = min(unique(batter_season_team()$Name))
      )
    }
  )
  
  observeEvent(
    eventExpr = input$team,
    handlerExpr = {
      updateSelectInput(
        inputId = "player",
        choices = sort(unique(batter_season_team()$Name)),
        selected = min(unique(batter_season_team()$Name))
      )
    }
  )
  
  batter_season_team_name = reactive({
    batter_season_team() %>%
      filter(Name == input$player)
  })

  output$plot = renderPlot({
    ggplot(data = batter_season_team_name(), aes(x = season, y = !!as.symbol(input$category))) +
      geom_line(color = "blue", size = 1) +
      labs(
        title = paste(as.character(input$category), "v.s. Seasons"),
        x = "Seasons",
        y = as.character(input$category)
      ) +
      theme_bw()
  })
  
  output$table = renderDataTable({
    batter_season_team_name() %>%
      sb_attempts_perc() %>%
      strike_out_rate()
  })
}

shinyApp(ui = ui, server = server)