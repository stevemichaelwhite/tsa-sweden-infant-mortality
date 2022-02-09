county_ts <- readRDS("data/county_ts.rds")

county_model <- county_ts  %>% model(
  arima011 = ARIMA(mort_rate ~ pdq(0,1,1)),
  stepwise = ARIMA(mort_rate)
  )
glance(county_model)

county_model %>% select(arima011) %>%report()
county_model %>% select(stepwise) %>%report()

# btc_fit <- county_ts  %>% model(
#       stepwise = ARIMA(close_guerro),
#       search = ARIMA(close_guerro, stepwise=FALSE))
# 
# btc_fit %>% pivot_longer(names_to = "Model name",
#                          values_to = "Orders")



county_model %>% select(arima011) %>% gg_tsresiduals()
county_model %>% select(stepwise) %>% gg_tsresiduals()

# glance(btc_fit)
# 
# btc_fit %>%
#   select(stepwise) %>%
#   gg_tsresiduals()

augment(btc_fit) %>%
  filter(.model=='search') %>%
  features(.innov, ljung_box, lag = 10, dof = 3)

p <- county_model %>%
  forecast(h=5)  %>%
  autoplot(county_ts)

ggplotly(p)
