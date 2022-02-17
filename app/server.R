library(shiny)
library(ggplot2)
library(plotly)
library(RColorBrewer)
library(dplyr)
library(tidyr)
library(DT)

# draft <- read.csv(paste0( file.path, '/nfl_draft.csv'))
# file.path <-"data/nfl_draft.csv"
file.path <-"https://raw.githubusercontent.com/GitAMoveOn/DDP/gh-pages/nfl_draft.csv"
draft <- read.csv(file.path)

# EDA
names(draft)
head(draft)
str(draft)
dim(draft)

# Want to keep this simple for the shiny app. I think the most naive but
# generalizeable, understandable realtionship for audience is round pick
# vs Career AV
library(dplyr)
library(tidyr)

# I think that the # of rounds reduced to 7 over the years, so figure that out
dd <- draft %>%
  group_by(Year) %>%
  summarise(max.rnd = max(Rnd)) %>%
  arrange(Year)
dd

# Appears that from 1994 onward, so just use that data.
# Also I think I wan to go with First4AV instead of CarAV, because I the length
# of a career can vary, and allowing for all observations to accommodate a
# reasonable career length might reduce the data too much

# When does this data end?
max(draft$Year)

# 2015. So I will only use data up through 2012 draft class.
draft <- draft %>%
  filter(Year<=2012) %>%
  filter(Year>=1994)

min(draft$Year)
max(draft$Year)

nrow(draft)

# Data up to this point passed filters, so don't think it should have NAs in
# the features I want to use but will double check
draft <- draft %>%
  drop_na(Year) %>%
  drop_na(Rnd) %>%
  drop_na(First4AV)

nrow(draft)
# 4519 rows. Same as before. So I was right.

# I want average four-year AV by draft round, across all positions
avg.4.AV <- draft %>%
  group_by(Rnd) %>%
  summarise(avg.F4.AV = mean(First4AV)) %>%
  arrange(Rnd)
avg.4.AV

# I want highest avg 4 year AV by player
# each row is a player so can just divide by 4 to get avg.
by.player <- draft %>%
  select(Player, First4AV) %>%
  mutate(avg.F4.AV = First4AV/4) %>%
  arrange(desc(avg.F4.AV))
head(by.player)

by.player[1,]$Player

###############################################################################
shinyServer(function(input, output) {
  output$out2 <- renderPrint(input$dd.rnd)
  mod.draft <- lm(First4AV ~ Rnd + Position.Standard + Age + College.Univ ,draft)

  mod.draft.pred <- reactive({
    input.rnd <- as.numeric(input$dd.rnd)
    input.pos <- input$dd.pos
    input.age <- as.numeric(input$dd.age)
    input.college <- input$dd.school

    input.df <- data.frame( Rnd = input.rnd
                            ,Position.Standard = input.pos
                            ,Age = input.age
                            ,College.Univ = input.college )

    predict(mod.draft, newdata = input.df)
  })
  # print( paste(class(mod.draft.pred),"is the class")

  output$plot.AV <- renderPlotly({
    input.rnd <- as.numeric(input$dd.rnd)
    input.pos <- input$dd.pos

    xx <- list(title = "Draft Round")
    yy <- list(title = "AV over First 4 Years")

    jj <- list(
      x = 1,
      y = by.player[1,]$First4AV,
      text = by.player[1,]$Player,
      xref = "x",
      yref = "y",
      showarrow = TRUE,
      # arrowhead = 7,
      ax = 0,
      ay = -20
      # color = "green"
    )

    pr <- list(
      x = input$dd.rnd,
      y = mod.draft.pred(),
      text = round(mod.draft.pred(),1),
      xref = "x",
      yref = "y",
      showarrow = TRUE,
      # arrowhead = 7,
      ax = 30,
      ay = -30
      # color = "green"
    )

    p <- plot_ly(draft
                 , x = ~Rnd
                 , y = ~First4AV
                 , type = "scatter"
                 , mode = "markers"

                 , color = ~draft$Position.Standard
                 , colors = brewer.pal(8, "Spectral")
                 , marker = list(size = 10, opacity = .25 )
    ) %>%
      # Plot the average for each draft round
      layout(title = "Accumulated AV over First 4 Years of Player Careers by Draft Round, Yrs 1994-2012") %>%
      layout(xaxis = xx, yaxis = yy) %>%
      add_trace( data=avg.4.AV, x = ~Rnd, y = ~avg.F4.AV, type = "scatter"
              , name = "Avg 4-Yr AV", color=I("lightpink"), mode="lines" ) %>%
      # Plot the predicted value
      add_trace(x = input.rnd, y = mod.draft.pred(), type = "scatter"
              , mode = "markers"
              , marker = list(symbol='x',size=15, color='black')) %>%
      layout(annotations = jj) %>%
      layout(annotations = pr)

    p
  })

  output$pred.AV <- renderText({
    paste("<font color=\"#458b74\"><b>","Predicted AV:", round(as.numeric(mod.draft.pred()),1), "</b></font>" )
  })

  output$mytable = DT::renderDataTable({
    # mtcars[1:10,]
    draft[order(-draft$First4AV),]
  })

  # output$plot.pt <- renderPlotly({
  #
  # z <- plot_ly(x = input.rnd, y = mod.draft.pred(), type = "scatter"
  #               ,mode = "markers"
  #               # ,color = 'grey38'
  #               #, colors = brewer.pal(3, "BrBG")
  #               ,marker = list(symbol='x',size=15, color='black'))
  # z
  # })

})
