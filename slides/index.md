---
title       : Week 4 Project - Shiny App and HTML5 Presentation
subtitle    : Predicting Value of Drafted NFL Players
author      : werlindo
job         : 'January 29, 2019'
framework   : revealjs     # {io2012, html5slides, shower, dzslides, ...}
revealjs    :
  theme     : sky     #sky #night
  transition: convex
highlighter : highlight.js  # {highlight.js, prettify, highlight}
widgets     : [plotly, leaflet, mathjax, quiz, bootstrap]            # {mathjax, quiz, bootstrap}
ext_widgets : {rCharts: [libraries/nvd3, libraries/leaflet, libraries/plotly]}
hitheme     : github
mode        : selfcontained
knit        : slidify::knit2slides
#biglogo        : hawkslogo.png
assets      : {assets: ../../assets}

--- 
<link href="https://fonts.googleapis.com/css?family=Noto+Serif|Source+Sans+Pro" rel="stylesheet">

<!-- font-family: 'Noto Serif', cursive; -->
<!-- font-family: 'Roboto Condensed', sans-serif; -->

<style>
.reveal {
  font-family: "Source Sans Pro", sans-serif;
  font-size: 40px;
  font-weight: normal;
  color: #545454; }
  
.reveal h1 {
    font-size: 1.5em;
    // color: #0000b3;
    padding-bottom: 10px;
    font-family: 'Noto Serif', serif;
    line-height: 10px;
}

.reveal h2 {
    font-size: 1em;
    //color: #fff7e6;
    padding-bottom: 10px;
    font-family: 'Noto Serif', serif;
}

.reveal h3 {
    font-size: .75em;
    //color: #69BE28;
    padding-bottom: 10px;
    font-family: "Source Sans Pro", sans-serif;
}

.reveal p, .reveal em {
    padding-bottom: 10px;
    width: 960px;
    font-family: 'Source Sans Pro', cursive;
}

.reveal p {
    font-size: .8em;
}

.reveal small {
    width: 500px;
}

.reveal ul {
  list-style-type: disc; 
    font-size: .8em;
}

.reveal .slides {
    text-align: left;
}

.reveal .roll {
    vertical-align: text-bottom;
}

code {
    color: red;
}

.reveal pre code { 
     height: 250px;
}


#left {
  left:-8.33%;
  text-align: left;
  float: left;
  width:50%;
  z-index:-10;
}

#right {
  left:31.25%;
  top: 75px;
  float: right;
  text-align: right;
  z-index:-10;
  width:50%;
}


</style>


# Developing Data Products
---------------------

## Week 4 Project - [Shiny App](https://mangrobang.shinyapps.io/Project_Draft_AV/) and HTML5 Presentation  
<!-- January 29, 2019 -->
May 08, 2018

<small>
[werlindo](https://www.linkedin.com/in/werlindo/)|[(GitHub)](https://mangrobangit.github.io)  

[RMD for these slides](https://github.com/mangrobangit/DDP/blob/gh-pages/slides/index.Rmd)
</small>

---  

## The Use Case

- National Football League teams (American Football :D ) have an annual draft of college players.
- Each team has by default a set amount of draft picks, which can increase and decrease.  
    - Trades between teams
    - League action (E.g. team may be compensated with an extra pick, or penalized a pick, etc.)
- How can teams maximize the value they get out of their draft picks?

--- .class2 #id2 bg:#002145

## Example - Seattle Seahawks

- The Seattle Seahawks didn't have picks in Round 2 or 3 before the start of the 2018 NFL Draft. 
- Thus it was especially important for them to extract maximum "value" from those picks.

<pre><iframe src="./assets/img/lfhawk.html" width=100% height=350px allowtransparency="true"> </iframe></pre>

--- .class3 #Appy bg:#66C010
## What are some variable that impact value?
Countless! But we'll focus on a few that were likely obvious to you:

- Round - There are 7 rounds of draft picks
- Position - The player's position on the playing field
- Age - How old at time of draft
- College/University - What school the player played at

We built an app that estimates the first four years of [Approximate Value](https://www.pro-football-reference.com/blog/index37a8.html) of a drafted player. 

<pre><iframe src="./assets/img/ps.html" width=100% height=350px allowtransparency="true"> </iframe></pre>


<div id="right">

</div>


--- .class4 #idDemo
## Approximate Value Predictor for Drafted Player

As an example, here are the estimated 4-Year AVs of the Seahawks' 2018 draft class. The total estimated 4-Year AV is 122.7.

Code: [ui.R](https://raw.githubusercontent.com/mangrobangit/DDP/gh-pages/app/ui.R) and [server.R](https://raw.githubusercontent.com/mangrobangit/DDP/gh-pages/app/server.R)

Go Hawks.

<pre><iframe src="./assets/img/dtsea.html" width=150% height=350px allowtransparency="true"> </iframe></pre>
