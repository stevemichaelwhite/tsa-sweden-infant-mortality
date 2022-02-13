## Overview

This project applies classical time series analysis to Sweden infant
mortality rates. The dataset under analysis comes from a problem
presnted in [Bayesian Demographic Estimation and
Forecasting](https://www.taylorfrancis.com/chapters/mono/10.1201/9780429452987-11/infant-mortality-sweden-john-bryant-junni-zhang).
The data can be found in the `bdefdata` package located here:
<https://github.com/johnrbryant/bdefdata/>. The package contains infant
birth and death data for multiple counties in Sweden.

Currently, analysis has only been performed on the largest county,
Stockholm.

This project’s analysis framework is based on the one presented in:
[Forecasting: Principles and
Practice](https://otexts.com/fpp3/arima-r.html).

## Analyse Raw Data

### Observed data

![](README_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

## 

## Transformations

The data is visually assessed to see if transformation or differencing
is required. Additionally a KPSS test is performed for which the null
hypothesis: the data is stationary (small p-value -\> differencing is
requried).

Logging the data appears to do little in altering the shape of the data.
Differencing appears to make the data more stationary. This is supported
by KPSS tests. p-value for test performed on:

  - the orignal series: .01 –\> reject the null
  - the first-differenced series 0.1 –\> fail to reject the null

Therefore first-differenced data will be used for model selection.

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

Two models are considered:

  - A manually selected one based on assesing the ACF/ and PACF plots.
  - An automatic selected using the [Hyndman-Khandakar
    algorithm](https://otexts.com/fpp3/arima-r.html) (step-wise and full
    grid search yield the same result)

Summary of results:

    ## # A tibble: 2 × 9
    ##   county    .model   sigma2 log_lik   AIC  AICc   BIC ar_roots  ma_roots 
    ##   <chr>     <chr>     <dbl>   <dbl> <dbl> <dbl> <dbl> <list>    <list>   
    ## 1 Stockholm arima011  0.212  -12.5   29.0  29.7  31.0 <cpl [0]> <cpl [1]>
    ## 2 Stockholm stepwise  0.156   -8.74  25.5  28.1  29.5 <cpl [2]> <cpl [0]>

### Manual

Observing the plots for the first-differenced series, The ACF appears to
be significant at lag 1 and then cuts off. The PACF appears to show
geometric decay. Therefore an MA(1) model for the first-differenced
series is chosen which is equivalent to an ARIMA(0,1,1) model for the
original series (ie the airline model).

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

### Model quality

Both models are plausible and have acceptable residual diagnostics.

## 

## Forecast

The Manual model is only modelling innovations because it’s an MA(1),
and so the estimate for each forecast step is the same. On the
otherhand, the automatic model is an AR(2) model and so the estimate for
each forecast step will depend on the observed/estimated value at t-1
and t.

### Manual

![](README_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

### Auto

![](README_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

## 

## Conclusions

The goal of this analysis was primarily to explore and not necessarily
to develop the best forecasting model.

The original problem is multivariate with time series data for 21
Swedish counties. The Bayesian book models time effects and region
efects explicitly, infers the underlying mortality rate and forecasts
the rates by county.

Next steps for this analysis:

  - Attempt to replicate and gain a deeper understanding of Bryant’s
    Bayesian model
  - Apply modern ML techniques to generate forecasts by region (with one
    or more regions as inputs)
  - Compare forecasts generated from ARIMA, Bayesian, and ML models

*Note: see
[gp-sweden-infant-mortality](https://github.com/stevemichaelwhite/gp-sweden-infant-mortality)
which models and forecasts the same dataset with a Gaussian Proccess.*
