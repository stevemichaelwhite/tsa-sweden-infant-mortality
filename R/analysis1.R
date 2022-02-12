source("R/global.R")

# Get Data ----------------------------------------------------------------

birth_death_ts <- readRDS("data/birth_death_ts.rds")
county_ts <- birth_death_ts %>% filter(county == "Stockholm")
res_plots <- readRDS("data/res_plots.rds")

# Procedure from https://otexts.com/fpp3/arima-r.html






# 1. Plot the data and identify any unusual observations. -----

mort_mean <- mean(county_ts$mort_rate)
p <- county_ts %>% autoplot(mort_rate) +
  labs(title="Stockholm Annaual Infant Mortality",
       y="Mort rate") + geom_hline(yintercept = mort_mean)

res_plots[["stockholm_raw"]] <- p




# 2. If necessary, transform the data (using a Box-Cox transformation) to stabilise the variance. -----

lambda <- county_ts  %>%
  features(mort_rate, features = guerrero) %>%
  pull(lambda_guerrero)

p <- county_ts %>%
  autoplot(box_cox(mort_rate, lambda)) 

p_plotly <- ggplotly(p) %>% 
  layout(title = plotly::TeX(paste0(
    "\\text{Transformed close price } \\lambda = ",
    round(lambda,2)))) %>% config(mathjax = 'cdn')

res_plots[["stockholm_guerrero"]] <- p_plotly

p <- county_ts %>%
  autoplot(log(mort_rate)) 

p_plotly <- ggplotly(p) %>% 
  layout(title = "Natural log transformation") 

res_plots[["stockholm_log"]] <- p_plotly

# county_ts <- county_ts %>% mutate(mort_rate = box_cox(mort_rate, lambda))


# 3. If the data are non-stationary, take first differences of the data until the data are stationary.
county_ts <- county_ts %>% mutate(mort_rate_diff = difference(mort_rate))

# Dicky fuller test here
county_ts %>% features(mort_rate, unitroot_ndiffs)
county_ts %>% features(mort_rate, unitroot_nsdiffs)

county_ts %>% features(mort_rate, unitroot_kpss)
county_ts %>% features(mort_rate_diff, unitroot_kpss)



# 4. Examine the ACF/PACF: Is an ARIMA(p,d,0) or ARIMA(0,d,q) model appropriate?

res <- county_ts %>%  gg_tsdisplay(mort_rate_diff, plot_type='partial')
# btc_acf <- county_ts %>% ACF(mort_rate_diff) 



res_plots[["stockholm_acf"]] <- county_ts %>% ACF(mort_rate) %>% autoplot() 
res_plots[["stockholm_pacf"]] <- county_ts %>% PACF(mort_rate) %>% autoplot() 

res_plots[["stockholm_diff_acf"]] <- county_ts %>% ACF(mort_rate_diff) %>% autoplot() 
res_plots[["stockholm_diff_pacf"]] <- county_ts %>% PACF(mort_rate_diff) %>% autoplot() 

county_ts  %>% gg_lag(mort_rate_diff, geom="point")


# Save results ------------------------------------------------------------

saveRDS(res_plots,"data/res_plots.rds")
saveRDS(county_ts,"data/county_ts.rds")








# 5. Try your chosen model(s), and use the AICc to search for a better model.
# 6. Check the residuals from your chosen model by plotting the ACF of the residuals, and doing a portmanteau test of the residuals. If they do not look like white noise, try a modified model.
# 7. Once the residuals look like white noise, calculate forecasts.
