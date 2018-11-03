4.4 
1. There is a difference in my_variable and my_var1able
2. 

install.packages("tidyverse")
library("tidyverse")

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)


3. Go to "Tools" and Select "Keyboard Shortcuts Help"

5.2
install.packages("nycflights13")
library("nycflights13")
nycflights13::flights
1. 
  1. filter(flights, dep_delay >= 120)
  2. filter(flights, dest == "IAH" | dest == "HOU")
  3. filter(flights, carrier %in% c("UA", "AA", 'DL'))
  4. filter (flights, month %in% c(7,8,9))
  5. filter (flights, dep_delay <= 0, arr_delay >= 120)
  6. filter (flights, dep_delay >= 60, arr_delay - dep_delay < -30)
  7. filter (flights, dep_time <= '600')
  
2. You can utilize it to filter more easily (ie. for 4 above. filter(flights, between(month, 7, 9)))
3. There are 8,255 flights without a departure time listed. filter (flights, is.na(dep_time))
4. NA is not a value so the other is true when paired with something. 

5.3.1
1. arrange(flights, desc(is.na(dep_time)))
2. arrange (flights, desc(dep_delay)) & arrange(flights, (dep_delay))
3. arrange(flights, air_time)
4. shortest -- arrange(flights, distance); longest arrange(flights, desc(distance))

5.4.1
2. It ends up only returning that variable once. (ie.select(flights, day, day))
3. One_of will return any of the columns included in the statement. (ie. vars <- c("year", "month", "day", "dep_delay", "arr_delay"), select(flights, one_of(vars)))
4. You can change it by using the (ignore.case) function. Here is an example. select(flights, contains(ignore.case = FALSE, "TIME"))

