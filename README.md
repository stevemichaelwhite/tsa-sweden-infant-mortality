<style type="text/css">
  p,ul,li{
  font-size: 12pt;
}
</style>

## Overview

This document answers exercise questions from lesson 4 as well as
explores the TS analysis framework provided by:
<https://otexts.com/fpp3/arima-r.html>

[Code Available on
GitLab](https://gitlabstats-prd/StatsMethods/time-series-network/learning/arima-modelling/lecture-4/-/tree/swhite)

## Analyse Raw Data

### Observed data

<div id="htmlwidget-69641e8345bbca28213c" style="width:100%;height:400px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-69641e8345bbca28213c">{"x":{"data":[{"x":[1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015],"y":[4.24290639087775,3.46539290062752,3.003003003003,3.8914244535191,3.25935867324929,3.43453771122407,3.00592343736186,2.90649393788407,2.67700175803101,2.48264090926723,2.43845796562935,2.85364859355891,2.18810400787717,2.46887075998283,1.92509625481274,2.05948884162193,1.67539267015707,2.21208350615236,2.46513355620842,1.42392188771359,2.14424287805044],"text":["year: 1995<br />mort_rate: 4.242906","year: 1996<br />mort_rate: 3.465393","year: 1997<br />mort_rate: 3.003003","year: 1998<br />mort_rate: 3.891424","year: 1999<br />mort_rate: 3.259359","year: 2000<br />mort_rate: 3.434538","year: 2001<br />mort_rate: 3.005923","year: 2002<br />mort_rate: 2.906494","year: 2003<br />mort_rate: 2.677002","year: 2004<br />mort_rate: 2.482641","year: 2005<br />mort_rate: 2.438458","year: 2006<br />mort_rate: 2.853649","year: 2007<br />mort_rate: 2.188104","year: 2008<br />mort_rate: 2.468871","year: 2009<br />mort_rate: 1.925096","year: 2010<br />mort_rate: 2.059489","year: 2011<br />mort_rate: 1.675393","year: 2012<br />mort_rate: 2.212084","year: 2013<br />mort_rate: 2.465134","year: 2014<br />mort_rate: 1.423922","year: 2015<br />mort_rate: 2.144243"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,0,0,1)","dash":"solid"},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1994,2016],"y":[2.67729162365761,2.67729162365761],"text":"yintercept: 2.677292","type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,0,0,1)","dash":"solid"},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":41.4991494314621,"r":7.30593607305936,"b":37.919240755663,"l":31.4155251141553},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"title":{"text":"Stockholm Annaual Infant Mortality","font":{"color":"rgba(0,0,0,1)","family":"","size":17.5342465753425},"x":0,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1994,2016],"tickmode":"array","ticktext":["1995","2000","2005","2010","2015"],"tickvals":[1995,2000,2005,2010,2015],"categoryorder":"array","categoryarray":["1995","2000","2005","2010","2015"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"year [1Y]","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1.28297266255538,4.38385561603596],"tickmode":"array","ticktext":["2","3","4"],"tickvals":[2,3,4],"categoryorder":"array","categoryarray":["2","3","4"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"Mort rate","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":false,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895}},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"54ae211f1464":{"x":{},"y":{},"type":"scatter"},"54ae2414bd5e":{"yintercept":{}}},"cur_data":"54ae211f1464","visdat":{"54ae211f1464":["function (y) ","x"],"54ae2414bd5e":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

## 

## Transformations

The data is visually assessed to see if transformation or differencing
is required. Additionally a KPSS test is performed in which the null
hypothesis is that the data is stationary (small p-value -\>
differencing is requried).

Logging the data appears to do little in altering the shape of the data.
Differencing appears to make the data more stationary. Also KPSS p-value
of the orignal series is reported as .01 which indicates to reject the
null. The KPSS p-value for the diffed series is reported as 0.1.
Therefore diffed data will be used for model selection.

### actual-data

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

    ## # A tibble: 1 × 3
    ##   county    kpss_stat kpss_pvalue
    ##   <chr>         <dbl>       <dbl>
    ## 1 Stockholm     0.775        0.01

### log-data

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

    ## # A tibble: 1 × 3
    ##   county    kpss_stat kpss_pvalue
    ##   <chr>         <dbl>       <dbl>
    ## 1 Stockholm     0.776        0.01

### diff-data

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

    ## # A tibble: 1 × 3
    ##   county    kpss_stat kpss_pvalue
    ##   <chr>         <dbl>       <dbl>
    ## 1 Stockholm     0.223         0.1

### logdiff-data

![](README_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

    ## # A tibble: 1 × 3
    ##   county    kpss_stat kpss_pvalue
    ##   <chr>         <dbl>       <dbl>
    ## 1 Stockholm     0.166         0.1

## 

## Model Selection

The ACF appears to be significant at lag 1 and then cut off. The PACF
appears to show geometric decay. I will choose an MA(1) model for the
diffed series or ARIMA(0,1,1) on the original (ie the airline model).
The automatic model was performed using the stepwise [Hyndman-Khandakar
algorithm](https://otexts.com/fpp3/arima-r.html). The algorithm chose an
ARIMA(2,1,0) Which I would have never chosen by looking at the ACF and
PACF.

Summary of manual model and automatic model:

    ## # A tibble: 2 × 9
    ##   county    .model   sigma2 log_lik   AIC  AICc   BIC ar_roots  ma_roots 
    ##   <chr>     <chr>     <dbl>   <dbl> <dbl> <dbl> <dbl> <list>    <list>   
    ## 1 Stockholm arima011  0.212  -12.5   29.0  29.7  31.0 <cpl [0]> <cpl [1]>
    ## 2 Stockholm stepwise  0.156   -8.74  25.5  28.1  29.5 <cpl [2]> <cpl [0]>

### Manual

![](README_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

    ## Series: mort_rate 
    ## Model: ARIMA(0,1,1) 
    ## 
    ## Coefficients:
    ##           ma1
    ##       -0.4950
    ## s.e.   0.1509
    ## 
    ## sigma^2 estimated as 0.2118:  log likelihood=-12.49
    ## AIC=28.97   AICc=29.68   BIC=30.96

### Auto

![](README_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

    ## Series: mort_rate 
    ## Model: ARIMA(2,1,0) w/ drift 
    ## 
    ## Coefficients:
    ##           ar1      ar2  constant
    ##       -0.9404  -0.5319   -0.2342
    ## s.e.   0.2191   0.2326    0.0856
    ## 
    ## sigma^2 estimated as 0.1559:  log likelihood=-8.74
    ## AIC=25.47   AICc=28.14   BIC=29.45

## 

## Forecast

### Manual

![](README_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

### Auto

![](README_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

##
