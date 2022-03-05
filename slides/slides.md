<link href="https://fonts.googleapis.com/css?family=Noto+Serif|Source+Sans+Pro" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Barlow:wght@100;400&display=swap" rel="stylesheet">

<style>
  .reveal {
    font-family: "Barlow", sans-serif;
    font-size: 40px;
    font-weight: normal;
    color: #545454; }
    
  .reveal h1 {
      font-size: 1.25em;
      // color: #0000b3;
      padding-bottom: 10px;
      font-family: 'Barlow', serif;
      line-height: 10px;
  }
  
  .reveal h2 {
      font-size: 1em;
      //color: #fff7e6;
      padding-bottom: 10px;
      font-family: 'Barlow', serif;
  }
  
  .reveal h3 {
      font-size: .8em;
      //color: #69BE28;
      padding-bottom: 10px;
      font-family: "Barlow", sans-serif;
  }
  
  .reveal p, .reveal em {
      padding-bottom: 10px;
      width: 960px;
      font-family: 'Barlow', sans-serif;
  }
  
  .reveal p {
      font-size: .8em;
     font-family: "Barlow", sans-serif;
  }
  
  .reveal small {
      width: 500px;
  }
  
  .reveal ul {
    list-style-type: disc;
    font-family: "Barlow", sans-serif;
    font-size: .75em;
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

Four-Year AV of a Drafted NFL Player
========================================================
author: Werlindo Mangrobang
date: May 2018
autosize: true
<!-- css: freelancer.css -->
<!-- font-family: 'Courier' -->

[LinkedIn](https://www.linkedin.com/in/werlindo/) | 
[GitHub](https://github.com/MangrobanGit) |
[Medium](https://medium.com/@werlindo) | 
[About Me](https://werlindo.com)


The Use Case
========================================================
- National Football League teams (American Football :D ) have an annual draft of college players.
- Each team has by default a set amount of draft picks, which can increase and decrease.  
    - Trades between teams
    - League action (E.g. team may be compensated with an extra pick, or penalized a pick, etc.)
- How can teams maximize the value they get out of their draft picks?

Example - Seattle Seahawks
========================================================

- The Seattle Seahawks didn't have picks in Round 2 or 3 before the start of the 2018 NFL Draft. 
- Thus it was especially important for them to extract maximum "value" from those picks.

<pre><iframe src="./assets/img/lfhawk.html" width=100% height=350px allowtransparency="true"> </iframe></pre>

What are some variable that impact value?
========================================================
Countless! But we'll focus on a few that were likely obvious to you:

- Round - There are 7 rounds of draft picks
- Position - The player's position on the playing field
- Age - How old at time of draft
- College/University - What school the player played at

We built an app that estimates the first four years of [Approximate Value](https://www.pro-football-reference.com/blog/index37a8.html) of a drafted player. 

<pre><iframe src="./assets/img/ps.html" width=100% height=350px allowtransparency="true"> </iframe></pre>

Approximate Value Predictor for Drafted Player
========================================================

As an example, here are the estimated 4-Year AVs of the Seahawks' 2018 draft class. 

The total estimated 4-Year AV is 122.7.

Go Hawks.

**Shiny App Code (in R):**  
[User Interface (ui.R)](https://raw.githubusercontent.com/MangrobanGit/nfl_draft_av/master/app/ui.R) and [Logic (server.R)](https://raw.githubusercontent.com/MangrobanGit/nfl_draft_av/master/app/server.R)

<pre><iframe src="./assets/img/dtsea.html" width=150% height=350px allowtransparency="true"> </iframe></pre>
