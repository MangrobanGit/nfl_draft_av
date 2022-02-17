library(shiny)
library(ggplot2)
library(plotly)
library(RColorBrewer)
library(dplyr)
library(tidyr)
library(DT)

# draft <- read.csv(paste0( file.path, '/nfl_draft.csv'))
#file.path <-"data/nfl_draft.csv"
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

shinyUI(fluidPage(
  titlePanel("Predict First 4 Years of Accumulated AV for a Drafted NFL Player"),
  sidebarLayout(
    sidebarPanel(
      #   span("groups of words", style = "color:blue"),

      p(tags$b("1. Select values from the drop-downs below"), br(),br(),
        tags$b("2. Click on the "), br(), 
        tags$b("[Calculate Predicted AV] button"),br(), tags$b("to get results"), br(), br()),
      selectizeInput('dd.rnd','Round', draft$Rnd, selected="" ),
      # verbatimTextOutput('out2'),
      selectInput('dd.pos','Position', draft$Position.Standard, selected=""),
      selectInput('dd.age','Age at Draft', draft$Age[order(draft$Age)], selected=""),
      selectInput('dd.school','College/University', draft$College.Univ[order(draft$College.Univ)], selected="Alabama"),
      submitButton("Calculate Predicted AV"),
      p(br(),
        "Data Source:"
        , br()
        , tags$a(href="https://www.kaggle.com/ronaldjgrafjr/nfl-draft-outcomes", "Kaggle")
        ),
      br(),
      helpText("Approximate Value (AV) is a metric that attempts to quantify",
               "the contributions of a player to a common basis across all positions.")
    )
    ,
    mainPanel(
      # Output: Tabset w/ plot, summary, and table ----
      h3("")
      , tabsetPanel(type = "tabs",
                  tabPanel("AV by Draft Round",
                           h3("")
                           , htmlOutput("pred.AV")
                           , br()
                           , br()
                           , plotlyOutput("plot.AV")
                           # , plotlyOutput("plot.pt")
                  )
                  ,
                  tabPanel("Appendix"
                    ,h4("Data")
                    ,p("Data is limited to 1994 and forward because that is the
                       year that the draft was reduced to 7 rounds, and remains
                       so today.")
                    ,p("Data is up to 2012 because dataset goes only until
                       2015, and wanted to allow for each player to have up to
                       4 years of AV calculated (Some may have less due to
                       events such as retirement, injuries, etc).")
                    ,br()
                    ,h4("Detailed Table")
                    ,p("For those, curious here is the detailed data, in descending order of greatest AV in first four years.")
                    ,DT::dataTableOutput("mytable")
                    , tags$a(href="https://www.kaggle.com/ronaldjgrafjr/nfl-draft-outcomes", "You can fine the source here (Kaggle Datasets)")
                    )
      )
    )
  )
))

