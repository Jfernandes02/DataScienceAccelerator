install.packages("tidyverse")
library("tidyverse")

install.packages("nycflights13")
library("nycflights13")
nycflights13::flights

cont_dep_time <- transmute(flights, dep_time, hour = dep_time %/% 100, minute = dept_time %%)
arrange(flights, air_time)

# 5.5.2
1. transmute(flights, dep_time, 
          minutes_midnight = ((dep_time %/% 100)*60) + dep_time %% 100)
2. I would have expected it to line up with each other but because of time zone changes and minutes, it does not line up. I will have to figure out a way to get it to be in the same time zone. 
3. They should all be lined up, you should be able to add dep_delay with the scheduled_dep_time for the dep_time.
4. 
rankMatrix(flights, na.last = TRUE)
5. [1]  2  4  6  5  7  9  8 10 12 11. Because it is adding each column to each other until the longer vector is complete. 

5.6.7

2. 
notcancelled %>% 
3. When looking for a cancelled flight, you can tell just by the dep_delay if it was cancelled or not.
4. The higher the delay on a given day, the more cancellations it seems like
flights %>%
  group_by(day) %>%
  summarise(cancelled = mean(is.na(dep_delay)),
            mean_dep = mean(dep_delay, na.rm = TRUE),
            mean_arr = mean(arr_delay, na.rm = TRUE)) %>%
  ggplot(aes(y = cancelled)) +
  geom_point(aes(x = mean_dep), colour = "red") +
  geom_point(aes(x = mean_arr), colour = "blue") +
  labs(x = "Avg delay per day", y = "Cancelled flights p day")
5. HA has the worst delays with the dep_max being above 1300.  
flights %>%
  group_by(carrier) %>%
  summarise(dep_max = max(dep_delay, na.rm = TRUE),
            arr_max = max(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(dep_max, arr_max)) %>%
  filter(1:n() == 1)
6. When you may want to sort based on the count of a certain field.
flights %>%
  count(flight, sort = TRUE)

# 5.7.1 
1. 
2. N103US has the worst on-time record
flights %>%
  filter(!is.na(arr_delay)) %>%
  group_by(tailnum) %>%
  summarise(prop_time = sum(arr_delay <= 30)/n(),
            mean_arr = mean(arr_delay, na.rm = T),
            fl = n()) %>%
  arrange(desc(prop_time))
3. The best time to fly is early morning between 5am and 7am 
flights %>%
  group_by(hour) %>%
  summarize(mean_dep_time = mean(dep_delay, na.rm = TRUE))
  
                  
4. 
flights %>%
  mutate(new_dep_delay = ifelse(is.na(dep_delay),0,dep_delay)) %>%
  group_by(dest) %>%
  summarise(total_delay = sum(new_dep_time),
            total_flights = n(),
            avg_delay = (total_delay/total_flights))

flights %>%
  mutate(new_dep_delay = ifelse(is.na(dep_delay),0,dep_delay)) %>%
  group_by(flight) %>% 
  summarise(delay_time = sum(new_dep_delay)/sum(air_time),
            totalflights = n())
5. 
flights %>%
  select(year, month, day, hour, dest, dep_delay) %>%
  group_by(dest) %>%
  mutate(lag_delay = lag(dep_delay)) %>%
  arrange(dest) %>%
  filter(!is.na(lag_delay)) %>%
  summarize(cor = cor(dep_delay, lag_delay, use = "complete.obs"),
            n = n()) %>%
  arrange(desc(cor)) %>%
  filter(row_number(desc(cor)) %in% 1:10)
6. 
flights %>%
  group_by(dest) %>%
  arrange(air_time) %>%
  slice(1:5) %>%
  select(tailnum, sched_dep_time, sched_arr_time, air_time) %>%
  arrange(air_time)
7. 
flights %>%
  group_by(dest) %>%
  filter(n_distinct(carrier) > 2) %>%
  group_by(carrier) %>%
  summarise(n = n_distinct(dest)) %>%
  arrange(-n)
8. 
flights %>%
  mutate(dep_date = lubridate::make_datetime(year, month, day)) %>%
  group_by(tailnum) %>%
  arrange(dep_date) %>%
  filter(!cumany(arr_delay>60)) %>%
  tally(sort = TRUE)

# 19.3.1
1. 
  - prefix
  - drop_last_char
  - recycle
2.  
3. You could create a function to do the same thing and then have a factor to determine if you want to make it multivariable or not
4. They both end up switching the action it performs by the distribution.

# 19.4.4
1. if is one logical statement vs ifelse being for a vector
2. 
greeter <- function(now = now()) {
  if (between(hour(now), 8, 13)) {
    print("Good morning")
  } else if (between(hour(now), 13, 18)) {
    print("Good afternoon")
  } else {
    print("Good evening")
  }
}
greeter(now())
3. 
x <- 9
fizzbuzz <- function(x) {
  by_three <- x %% 3 == 0
  by_five <- x %% 5 == 0
  
  if (by_three && by_five) {
    return("fizzbuzz")
  } else if (by_three) {
    return("fizz")
  } else if (by_five) {
    return("buzz")
  } else {
    return(x)
  }
}
4. 
cut(temp, breaks = seq(-10, 40, 10),
    right = FALSE,
    labels = c("freezing", "cold", "cool", "warm", "hot"))
5. 
{r, eval = FALSE}
x = 2
switch(x, 1 = "No", 2 = "Yes")
switch(x, `1` = "No", `2` = "Yes")
6. 
x <- "d"
switch(x, 
       a = ,
       b = "ab",
       c = ,
       d = "cd"
)