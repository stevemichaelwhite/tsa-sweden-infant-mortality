glimpse(county_ts)
county_ts %>% print(n=3)
county_STLmodel <- county_ts  %>% model(
  STL(mort_rate ~ trend(window = 4),
      robust = TRUE)) 

county_STLmodel %>%
  components() %>%
  autoplot()

View(county_STLmodel)
attributes(county_STLmodel)
