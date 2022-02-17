library(plotly)
dfree <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2011_february_us_airport_traffic.csv')
head(dfree)

# geo styling
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showland = TRUE,
  landcolor = toRGB("gray95"),
  subunitcolor = toRGB("gray85"),
  countrycolor = toRGB("gray85"),
  countrywidth = 0.5,
  subunitwidth = 0.5
)

p <- plot_geo(dfree, lat = ~lat, lon = ~long)
p

p <- add_markers(p,
    text = ~paste(airport, city, state, paste("Arrivals:", cnt), sep = "<br />"),
    color = ~cnt, symbol = I("square"), size = I(8), hoverinfo = "text"
  ) 
p

%>%
    colorbar(title = "Incoming flights<br />February 2011") %>%
  layout(
    title = 'Most trafficked US airports<br />(Hover for airport)', geo = g
  )
p


# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
chart_link = api_create(p, filename="maps-traffic")
chart_link



file.path <-"https://raw.githubusercontent.com/GitAMoveOn/DDP/gh-pages/nfl_draft.csv"
draft <- read.csv(file.path)

names(draft)
College

z<-getwd()
z
dir()
setwd(paste(z,"/9. Developing Data Products/",sep=""))
getwd()
dir()
setwd("./Week 4")
getwd()
dir()
setwd("./Project/app")
dir()
setwd('./data')
dir()
colleges <- read.csv('college_scorecard.csv')
head(colleges)

install.packages('fuzzyjoin')
library(fuzzyjoin)

head(draft)
names(draft)
#College.Univ
names(colleges)
#INSTNM
?fuzzy_left_join
zz <- stringdist_left_join(draft,colleges,c("College.Univ"="INSTNM"))
head(zz)
zz[zz$College.Univ=='Baylor',]


library(dplyr)
dd <- draft %>%
  group_by(College.Univ) %>%
  select(College.Univ)
dd<-unique(draft$College.Univ)
class(dd)
nfl.colleges<-as.data.frame(dd)
nfl.colleges
str(nfl.colleges)
zz <- stringdist_left_join(nfl.colleges,colleges,c("dd"="INSTNM"),method='lv',distance_col="SCORE")

head(zz[zz['dd']=='Washington',c('dd','INSTNM','SCORE')])

library(plotly)
library(ggplot2)
library(RColorBrewer)

file.path <-"https://raw.githubusercontent.com/GitAMoveOn/DDP/gh-pages/nfl_draft.csv"
draft <- read.csv(file.path)

draft <- draft %>%
  filter(Year<=2012) %>%
  filter(Year>=1994)

avg.4.AV.round <- draft %>%
  group_by(Rnd) %>%
  summarise(avg.F4.AV = mean(First4AV)) %>%
  arrange(Rnd)
# avg.4.AV.round

ct.4.AV.round <- draft %>%
  group_by(Rnd) %>%
  count(Rnd) %>%
  arrange(Rnd)
# ct.4.AV.round

tbl.round <- inner_join(avg.4.AV.round,ct.4.AV.round,by="Rnd")
# tbl.round

avg.4.AV.age <- draft %>%
  group_by(Age) %>%
  summarise(avg.F4.AV = mean(First4AV)) %>%
  arrange(Age)
# avg.4.AV.age

ct.4.AV.age <- draft %>%
  group_by(Age) %>%
  count(Age) %>%
  arrange(Age)
# ct.4.AV.age

tbl.age<- inner_join(avg.4.AV.age,ct.4.AV.age,by="Age")
# tbl.age

avg.4.AV.pos <- draft %>%
  group_by(Pos) %>%
  summarise(avg.F4.AV = mean(First4AV)) %>%
  arrange(Pos)
# avg.4.AV.pos

ct.4.AV.pos <- draft %>%
  group_by(Pos) %>%
  count(Pos) %>%
  arrange(Pos)
# ct.4.AV.pos

tbl.pos<- inner_join(avg.4.AV.pos,ct.4.AV.pos,by="Pos")
# tbl.pos

xx <- list(title = "Draft Round")
yy <- list(title = "AV over First 4 Years")

p1 <- plot_ly(tbl.round
             , x = ~Rnd
             , y = ~avg.F4.AV
             , color = ~n
             , type = "bar"
             , colors = brewer.pal(1, "Blues")
             , name = 'Draft Round' ) %>%
  layout(xaxis = xx, yaxis = yy) 
# p1
p2 <- plot_ly(tbl.age
              , x = ~Age
              , y = ~avg.F4.AV
              , type = "bar"
              , color = ~n
              , colors = brewer.pal(1, "Greens")
              , name = 'Age' ) %>%
  layout(xaxis = xx, yaxis = yy) 
# p2
p3 <- plot_ly(tbl.pos
              , x = ~Pos
              , y = ~avg.F4.AV
              , type = "bar"
              # , color = ~n
              , colors = brewer.pal(1, "Reds")
              , name = 'Position' ) %>%
  layout(xaxis = xx, yaxis = yy) 
# p3
ps <-subplot(p1,p2,p3, shareX = FALSE, shareY = TRUE, nrows = 2) %>%
   layout(title = "4 Yr AV by Features")
ps
?subplot

file.path <-"https://raw.githubusercontent.com/GitAMoveOn/DDP/gh-pages/seahawks_results.csv"
sea.res <- read.csv(file.path)

colnames(sea.res)[1]<-"Round"
sea.res
library(DT)

dt.sea <- datatable(sea.res)
dt.sea
